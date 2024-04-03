#include "custom_video_surface.h"

CustomVideoSurface::CustomVideoSurface(QObject* parent)
        : QAbstractVideoSurface(parent){
}

QList<QVideoFrame::PixelFormat>
CustomVideoSurface::supportedPixelFormats(QAbstractVideoBuffer::HandleType handleType) const{
    Q_UNUSED(handleType);
    return QList<QVideoFrame::PixelFormat>()
            << QVideoFrame::Format_ARGB32
            << QVideoFrame::Format_ARGB32_Premultiplied
            << QVideoFrame::Format_RGB32
            << QVideoFrame::Format_RGB24
            << QVideoFrame::Format_RGB565
            << QVideoFrame::Format_RGB555
            << QVideoFrame::Format_ARGB8565_Premultiplied
            << QVideoFrame::Format_BGRA32
            << QVideoFrame::Format_BGRA32_Premultiplied
            << QVideoFrame::Format_BGR32
            << QVideoFrame::Format_BGR24
            << QVideoFrame::Format_BGR565
            << QVideoFrame::Format_BGR555
            << QVideoFrame::Format_BGRA5658_Premultiplied
            << QVideoFrame::Format_AYUV444
            << QVideoFrame::Format_AYUV444_Premultiplied
            << QVideoFrame::Format_YUV444
            << QVideoFrame::Format_YUV420P
            << QVideoFrame::Format_YV12
            << QVideoFrame::Format_UYVY
            << QVideoFrame::Format_YUYV
            << QVideoFrame::Format_NV12
            << QVideoFrame::Format_NV21
            << QVideoFrame::Format_IMC1
            << QVideoFrame::Format_IMC2
            << QVideoFrame::Format_IMC3
            << QVideoFrame::Format_IMC4
            << QVideoFrame::Format_Y8
            << QVideoFrame::Format_Y16
            << QVideoFrame::Format_Jpeg
            << QVideoFrame::Format_CameraRaw
            << QVideoFrame::Format_AdobeDng;
}

bool CustomVideoSurface::present(const QVideoFrame& frame){
    auto tmp = frame.pixelFormat();
    auto tmp1 = frame.size();
    auto tmp3 = surfaceFormat().pixelFormat();
    auto tmp4 = surfaceFormat().frameSize();
    if(surfaceFormat().pixelFormat() != frame.pixelFormat() || surfaceFormat().frameSize() != frame.size()){
        setError(IncorrectFormatError);
        stop();
        return false;
    }

    currentFrameImage = imageFromVideoFrame(frame);

    emit framePresented();

    return true;
}

QVideoSurfaceFormat CustomVideoSurface::surfaceFormat() const{
    // Set the desired video format
    return QVideoSurfaceFormat(QSize(960, 400), QVideoFrame::Format_ARGB32);
}

QImage CustomVideoSurface::imageFromVideoFrame(const QVideoFrame& tmp_frame){
    QVideoFrame frame(tmp_frame);
    if(!frame.map(QAbstractVideoBuffer::ReadOnly))
        return QImage();

    QImage::Format format = QVideoFrame::imageFormatFromPixelFormat(frame.pixelFormat());
    QImage image(frame.bits(),
                 frame.width(),
                 frame.height(),
                 frame.bytesPerLine(),
                 format);

    frame.unmap();

    return image.copy();  // Ensure that you create a copy to detach from the original data
}

QImage CustomVideoSurface::currentImage() const{
    return currentFrameImage;
}
