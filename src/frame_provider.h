#ifndef FRAMEPRODER_H
#define FRAMEPRODER_H

#include <QObject>
#include <QAbstractVideoSurface>
#include <QVideoSurfaceFormat>
#include <QMediaPlayer>
#include <QVideoProbe>
#include <QTimer>
#include "custom_video_surface.h"

class FrameProvider : public QObject{
Q_OBJECT
    Q_PROPERTY(QAbstractVideoSurface* videoSurface READ videoSurface WRITE setVideoSurface)
public:
    ~FrameProvider();
    explicit FrameProvider(QObject* parent = nullptr);
    QAbstractVideoSurface* videoSurface() const;
    void setVideoSurface(QAbstractVideoSurface* surface);
    void setFormat(int width, int heigth, QVideoFrame::PixelFormat format);
    Q_INVOKABLE bool mbIsNoSignal();
    Q_INVOKABLE void tests();
    Q_INVOKABLE void mvRanderImage(QString url);
public slots:
    void onNewVideoContentReceived(const QVideoFrame& frame);
    void OnNoSignalTimeout();
private:
    QAbstractVideoSurface* m_surface = NULL;
    QVideoSurfaceFormat m_format;
    QTimer nosignal_timer_;
    unsigned int nosignal_count_;
};

#endif // FRAMEPRODER_H
