#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "producer.h"
#include "frame_provider.h"
#include "rtsp_decode.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QQmlContext *ctx = engine.rootContext();

    FrameProvider provider;
    ctx->setContextProperty("_provider", &provider);
//    ctx->setContextProperty("Config", config);

    qmlRegisterType<Producer>("pkg.producer", 1, 0, "Producers");
    qmlRegisterType<Producer>("pkg.custom_video_surface", 1, 0, "CustomVideoSurface");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
//    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app, [url](QObject *obj, const QUrl &objUrl) {
//        if (!obj && url == objUrl) QCoreApplication::exit(-1);
//    },
//                     Qt::QueuedConnection);
    engine.load(url);

    gst_init(&argc, &argv);
    RrspDecode rtspDecode;
    rtspDecode.init(640, 480, "rtsp://mobliestream.c3tv.com:554/live/goodtv.sdp");

    return app.exec();
}
