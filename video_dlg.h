#include <QDialog>
#include <QVideoFrame>
#include <QImage>
#include <QPainter>
#include <QLabel>

class VideoDialog : public QDialog{
Q_OBJECT

public:
    VideoDialog(QWidget* parent = nullptr) : QDialog(parent){
    }

    void setVideoFrame(const QVideoFrame& videoFrame){
        // 将 QVideoFrame 渲染到 QImage
        QImage image = videoFrameToImage(videoFrame);

        // 显示 QImage
        QLabel* label = new QLabel(this);
        label->setPixmap(QPixmap::fromImage(image));
        label->show();
    }

private:
    QImage videoFrameToImage(const QVideoFrame& tmp_frame){
        QVideoFrame frame(tmp_frame);
        if(!frame.map(QAbstractVideoBuffer::ReadOnly))
            return QImage();

        QImage::Format format = QVideoFrame::imageFormatFromPixelFormat(frame.pixelFormat());
        QImage image(frame.bits(), frame.width(), frame.height(), frame.bytesPerLine(), format);

        frame.unmap();

        return image.copy();
    }
};

