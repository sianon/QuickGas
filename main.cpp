#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "producer.h"
#include "frame_provider.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QQmlContext *ctx = engine.rootContext();
    FrameProvider provider;
//    ctx->setContextProperty("Config", config);


    qmlRegisterType<Producer>("pkg.producer", 1, 0, "Producers");
    qmlRegisterType<Producer>("pkg.custom_video_surface", 1, 0, "CustomVideoSurface");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    ctx->setContextProperty("_provider", &provider);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    return app.exec();
}
