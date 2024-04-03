#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "producer.h"
#include "src/frame_provider.h"
#include "src/rtsp_decode.h"

int main(int argc, char* argv[]){
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    QQmlContext* ctx = engine.rootContext();
//    FrameProvider provider;
//
//    ctx->setContextProperty("_provider", &provider);

    qmlRegisterType<FrameProvider>("Local", 1, 0, "FrameProvider");
    qmlRegisterType<Producer>("pkg.producer", 1, 0, "Producers");
    qmlRegisterType<Producer>("pkg.custom_video_surface", 1, 0, "CustomVideoSurface");

    engine.load(QStringLiteral("qrc:/main.qml"));
    QObject* rootObject = engine.rootObjects().value(0);
    QObject* item = rootObject->findChildren<QObject*>("main_window").value(0);

    gst_init(&argc, &argv);
    RrspDecode rtspDecode;
    rtspDecode.init(640, 480, "rtsp://mobliestream.c3tv.com:554/live/goodtv.sdp");

    return app.exec();
}
