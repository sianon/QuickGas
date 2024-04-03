#include "frame_provider.h"
#include <QImage>
#include <QPainter>
#include <QDateTime>
#include <QRandomGenerator>
#include <QVideoFrame>
#include <QDebug>
#include <QVideoWidget>
#include <QFile>

#include <QVideoSurfaceFormat>
#include <QAbstractVideoSurface>

#include "video_dlg.h"
#include "src/video_queue.h"

FrameProvider::FrameProvider()
{
    QMediaPlayer* mediaPlayer = new QMediaPlayer(this);
//    QVideoProbe* videoProbe = new QVideoProbe(this);
//
    m_customSurface = new CustomVideoSurface(this);
    mediaPlayer->setVideoOutput(m_customSurface);
    mediaPlayer->setMedia(QUrl("rtsp://127.0.0.1:8554/"));

    mediaPlayer->play(); // Start playing the video
    auto tmp = mediaPlayer->state();

}

FrameProvider::~FrameProvider()
{

}

QAbstractVideoSurface *FrameProvider::videoSurface() const {
    return m_surface;
}

void FrameProvider::setVideoSurface(QAbstractVideoSurface *surface)
{
    if (m_surface && m_surface != surface  && m_surface->isActive()) {
        m_surface->stop();
    }

    m_surface = surface;

    if (m_surface && m_format.isValid())
    {
        m_format = m_surface->nearestFormat(m_format);
        m_surface->start(m_format);
    }
}

void FrameProvider::setFormat(int width, int heigth, QVideoFrame::PixelFormat format)
{
    QSize size(width, heigth);
    QVideoSurfaceFormat vsformat(size, format);
    m_format = vsformat;

    if (m_surface)
    {
        if (m_surface->isActive())
        {
            m_surface->stop();
        }
        m_format = m_surface->nearestFormat(m_format);
        m_surface->start(m_format);
    }
}

void FrameProvider::test()
{
    auto urls = VideoQueue::moGetInstance()->moGetAllRtspUrl();
    if(urls.empty()) return;

    QImage image = VideoQueue::moGetInstance()->moGetVideoFromQueue(urls.front());

    if(image.isNull()) return;

    auto tmp = image.rect();
    auto tmp1 = image.size();
    auto tmp2 = image.format();

    QVideoFrame video_frame(image);
    auto cs = video_frame.pixelFormat();
    //按照视频帧设置格式
    setFormat(video_frame.width(),video_frame.height(),video_frame.pixelFormat());
    if (m_surface)
        m_surface->present(image);
}

void FrameProvider::onNewVideoContentReceived(const QVideoFrame &frame)
{
    int plane = 0;
    QImage image(640, 480, QImage::Format_ARGB32);
    image.fill(QColor::fromRgb(QRandomGenerator::global()->generate()));
    QFont font;
    font.setPointSize(25);

    QPainter painter(&image);
    painter.setFont(font);
    painter.drawText(image.rect(), Qt::AlignCenter, QDateTime::currentDateTime().toString());
    painter.end();

    QVideoFrame video_frame(image);
    video_frame.unmap();

    //按照视频帧设置格式
    setFormat(video_frame.width(),video_frame.height(),video_frame.pixelFormat());
    if (m_surface)
        m_surface->present(video_frame);

    VideoDialog dialog;
    dialog.show();
    // 在 QDialog 中显示 QVideoFrame
    dialog.setVideoFrame(video_frame);
}

