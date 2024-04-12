#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "producer.h"
#include "src/frame_provider.h"
#include "src/frame_provider_ctrl.h"
#include "src/rtsp_decode.h"

int main(int argc, char* argv[]){
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    QQmlContext* ctx = engine.rootContext();

    qmlRegisterType<FrameProvider>("Local", 1, 0, "FrameProvider");
    qmlRegisterType<Producer>("pkg.producer", 1, 0, "Producers");
    qmlRegisterType<FrameProviderCtrl>("Local", 1, 0, "FrameProviderCtrl");

    engine.load(QStringLiteral("qrc:/main.qml"));
    QObject* rootObject = engine.rootObjects().value(0);
    QObject* item = rootObject->findChild<QObject*>("main_window");

    gst_init(&argc, &argv);
//    RrspDecode rtspDecode3;
//    rtspDecode3.init(640, 480, "rtsp://16.16.16.159:554/live/test0");
    RrspDecode rtspDecode;
    rtspDecode.init(640, 480, "rtsp://mobliestream.c3tv.com:554/live/goodtv.sdp");
    RrspDecode rtspDecode1;
    rtspDecode1.init(640, 480, "rtsp://rtspstream:4652b30fd7cece3fb77090976c7528c6@zephyr.rtsp.stream/pattern");
    RrspDecode rtspDecode2;
    rtspDecode2.init(640, 480, "rtsp://rtspstream:4ddbac5abc17d1e83d5ff173aba4eac3@zephyr.rtsp.stream/movie");

    return app.exec();
}
