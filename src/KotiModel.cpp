#include "KotiModel.h"

#include <QDebug>
#include <QSqlQuery>
#include <QSqlError>

auto static constexpr SQL_DRIVER = "QSQLITE";
auto static constexpr PROJECT_NAME = "koti";

KotiModel::KotiModel(QObject *parent)
    : QObject { parent }
{
    createDatabase();
    refreshActiveUserId();
}

void KotiModel::setActivePage(const KotiPage& activePage)
{
    if (m_activePage == activePage)
        return;
    m_activePage = activePage;
    emit activePageChanged();
}

const QStringList KotiModel::usernameList() const
{
    QSqlQuery query;
    query.prepare("SELECT username FROM user;");

    QStringList usernameList;

    if (query.exec()) {

        while (query.next()) {
            usernameList += query.value("username").toString();
        }
    }
    else {
        qDebug() << "Failed to select from user table.";
    }

    return usernameList;
}

const QString KotiModel::activeUsername() const
{
    if (m_activeUserId < 1) {
        return {};
    }

    QSqlQuery query;
    query.prepare("SELECT username FROM user WHERE id=:activeUserId;");
    query.bindValue(":activeUserId", m_activeUserId);

    QString activeUsername;

    if (query.exec() && query.first()) {
        activeUsername = query.value("username").toString();
    }
    else {
        qDebug() << "Failed to select active username from user table.";
    }

    return activeUsername;
}

const KotiModel::KotiPage &KotiModel::activePage() const
{
    return m_activePage;
}

void KotiModel::createDatabase()
{
    m_database = QSqlDatabase::addDatabase(SQL_DRIVER);
    m_database.setDatabaseName(PROJECT_NAME);

    if (!m_database.open()) {
        qDebug() << "Failed to connect to Koti database.";
        return;
    }

    bool newDatabase { false };

    QSqlQuery query;

    query.prepare("SELECT COUNT(*) FROM sqlite_master WHERE type='table' AND name='user';");

    if (query.exec()) {

        if (query.first() && query.value(0).toInt() == 0) {
            newDatabase = true;
        }
    }

    query.prepare("CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY, username TEXT, password TEXT);");

    if (!query.exec()) {
        qDebug() << "Failed to create user table.";
        return;
    }

    query.prepare("CREATE TABLE IF NOT EXISTS setting(setting TEXT PRIMARY KEY, value TEXT);");

    if (!query.exec()) {
        qDebug() << "Failed to create setting table.";
        return;
    }

    if (newDatabase) {
        createTestUsers();
    }
}

void KotiModel::createTestUsers()
{
    QMap<QString, QString> userMap;
    userMap["Emily"] = "password1";
    userMap["Tom"] = "password2";
    userMap["Jerry"] = "password3";

    QSqlQuery query;

    auto iterator = userMap.constBegin();
    while (iterator != userMap.constEnd()) {
        query.prepare("INSERT INTO user (username, password) VALUES (:username, :password);");
        query.bindValue(":username", iterator.key());
        query.bindValue(":password", iterator.value());

        if (!query.exec()) {
            qDebug() << "Failed to insert into user table.";
            return;
        }

        iterator += 1;
    }

    m_activeUserId = 1;

    query.prepare("INSERT INTO setting (setting, value) VALUES ('activeUserId', :activeUserId);");
    query.bindValue(":activeUserId", m_activeUserId);
    query.exec();

    emit activeUsernameChanged();
    emit usernameListChanged();
}

void KotiModel::refreshActiveUserId()
{
    QSqlQuery query;
    query.prepare("SELECT value FROM setting WHERE setting = 'activeUserId'");

    if (query.exec() && query.first()) {
        m_activeUserId = query.value("value").toInt();

        emit activeUsernameChanged();
    }
}
