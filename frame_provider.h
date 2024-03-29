#ifndef FRAMEPRODER_H
#define FRAMEPRODER_H

#include <QObject>
#include <QAbstractVideoSurface>
#include <QVideoSurfaceFormat>
#include <QMediaPlayer>
#include <QVideoProbe>
#include <QTimer>
#include "custom_video_surface.h"
/*!
 * \brief FrameProvider 作为qml VideoOutput.source
 */
class FrameProvider : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QAbstractVideoSurface *videoSurface READ videoSurface WRITE setVideoSurface)


public:
    FrameProvider();
    ~FrameProvider();

    QAbstractVideoSurface *videoSurface() const;

    void setVideoSurface(QAbstractVideoSurface *surface);

    void setFormat(int width, int heigth, QVideoFrame::PixelFormat format);
    Q_INVOKABLE void test();
public slots:
    /*!
     * \brief 接收外部数据源，视频帧
     * \param frame
     */
    void onNewVideoContentReceived(const QVideoFrame &frame);

private:
    QAbstractVideoSurface *m_surface = NULL;
    CustomVideoSurface *m_customSurface = NULL;
    QVideoSurfaceFormat m_format;
    QTimer timer;
};
#endif // FRAMEPRODER_H
