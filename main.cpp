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
    RrspDecode rtspDecode;
    rtspDecode.init(640, 480, "rtsp://mobliestream.c3tv.com:554/live/goodtv.sdp");

    return app.exec();
}
