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

FrameProvider::FrameProvider(QObject* parent) : nosignal_count_(6){
    nosignal_timer_.setInterval(1000);
    connect(&nosignal_timer_, &QTimer::timeout, this, &FrameProvider::OnNoSignalTimeout);
}

FrameProvider::~FrameProvider(){

}

QAbstractVideoSurface* FrameProvider::videoSurface() const{
    return m_surface;
}

void FrameProvider::setVideoSurface(QAbstractVideoSurface* surface){
    if(m_surface && m_surface != surface && m_surface->isActive()){
        m_surface->stop();
    }

    m_surface = surface;

    if(m_surface && m_format.isValid()){
        m_format = m_surface->nearestFormat(m_format);
        m_surface->start(m_format);
    }
}

void FrameProvider::setFormat(int width, int heigth, QVideoFrame::PixelFormat format){
    QSize size(width, heigth);
    QVideoSurfaceFormat vsformat(size, format);
    m_format = vsformat;

    if(m_surface){
        if(m_surface->isActive()){
            m_surface->stop();
        }
        m_format = m_surface->nearestFormat(m_format);
        m_surface->start(m_format);
    }
}

void FrameProvider::tests(){
    auto urls = VideoQueue::moGetInstance()->moGetAllRtspUrl();
    if(urls.empty()) return;

    QImage image = VideoQueue::moGetInstance()->moGetVideoFromQueue(urls.front());

    if(image.isNull()) return;

    nosignal_count_ >= 6 ? nosignal_count_ = 6 : nosignal_count_++;

    QVideoFrame video_frame(image);
    auto cs = video_frame.pixelFormat();

    setFormat(video_frame.width(), video_frame.height(), video_frame.pixelFormat());
    if(m_surface)
        m_surface->present(image);
}

void FrameProvider::onNewVideoContentReceived(const QVideoFrame& frame){
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

    setFormat(video_frame.width(), video_frame.height(), video_frame.pixelFormat());
    if(m_surface)
        m_surface->present(video_frame);
}

bool FrameProvider::mbIsNoSignal(){
    return nosignal_count_ == 0 ? true : false;
}

void FrameProvider::OnNoSignalTimeout(){
    nosignal_count_ > 0 ? nosignal_count_-- : nosignal_count_ = 0;
}

void FrameProvider::mvRanderImage(QString url){
    if(url.isEmpty()) return;

    QImage image = VideoQueue::moGetInstance()->moGetVideoFromQueue(url.toStdString());

    if(image.isNull()){
        qDebug() << "rtsp image is null\n";
        return;
    }

    nosignal_count_ >= 6 ? nosignal_count_ = 6 : nosignal_count_++;

    QVideoFrame video_frame(image);
    auto cs = video_frame.pixelFormat();

    setFormat(video_frame.width(), video_frame.height(), video_frame.pixelFormat());
    if(m_surface)
        m_surface->present(image);
}

