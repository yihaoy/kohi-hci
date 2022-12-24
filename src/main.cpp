#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include <QFont>

#include "KotiModel.h"
#include "KotiController.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication::setFont(QFont("Inter"));

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    KotiModel* kotiModel = new KotiModel(&app);
    KotiController *kotiController = new KotiController(kotiModel, &app);

    qRegisterMetaType<KotiModel::KotiPage>("KotiPage");
    qmlRegisterUncreatableType<KotiModel>("Koti", 1, 0, "KotiPage", "Error: KotiPage is an enum type.");

    engine.rootContext()->setContextProperty("kotiModel", kotiModel);
    engine.rootContext()->setContextProperty("kotiController", kotiController);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl) {
                QCoreApplication::exit(-1);
            }
        }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
