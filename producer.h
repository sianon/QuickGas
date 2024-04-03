#ifndef PRODUCER_H
#define PRODUCER_H

#include <QObject>
#include <QQmlEngine>
//#include <QVideoSink>
#include <QQmlEngine>
#include <QPointer>
#include <QTimer>

class QVideoSink;

class Producer : public QObject{
Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(QVideoSink* videoSinks READ getVideoSink WRITE setVideoSink NOTIFY videoSinkChanged)
public:
    Producer(QObject* parent = nullptr);
    QVideoSink* getVideoSink() const;
    Q_INVOKABLE void setVideoSink(QVideoSink* newVideoSink);
    Q_INVOKABLE void start();
signals:
    void videoSinkChanged();
private:
    QVideoSink* m_videoSink;
    void handleTimeout();
    QTimer m_timer;
};

#endif // PRODUCER_H
