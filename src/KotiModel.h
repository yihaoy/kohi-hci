#pragma once

#include <QObject>
#include <QSqlDatabase>

class KotiModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(KotiPage activePage READ activePage WRITE setActivePage NOTIFY activePageChanged)
    Q_PROPERTY(QStringList usernameList READ usernameList NOTIFY usernameListChanged)
    Q_PROPERTY(QString activeUsername READ activeUsername NOTIFY activeUsernameChanged)

public:
    explicit KotiModel(QObject* = nullptr);

    enum KotiPage {
        Login,
        Welcome,
        Devices,
        RingDoorbell
    };
    Q_ENUM(KotiPage)

    void setActivePage(const KotiPage&);

    // Q_PROPERTY READ
    const QStringList usernameList() const;
    const QString activeUsername() const;
    const KotiPage &activePage() const;

signals:
    // Q_PROPERTY NOTIFY
    void usernameListChanged();
    void activeUsernameChanged();

    void activePageChanged();

private:
    void createDatabase();
    void createTestUsers();

    void refreshActiveUserId();

private:
    QSqlDatabase m_database;

    int m_activeUserId { 0 };
    KotiPage m_activePage { KotiPage::Login };
};
