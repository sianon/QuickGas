#pragma once
#include <opencv2/core/core.hpp>
#include <string>
#include <gst/gst.h>
#include <memory>
#include <gst/gstelement.h>
#include <gst/app/gstappsink.h>
class RrspDecode : public std::enable_shared_from_this<RrspDecode>
{
public:
    using Ptr = std::shared_ptr<RrspDecode>;
    ~RrspDecode();

    /**
     * @brief 初始化编码器
     */
    int init(int width, int height,std::string url);

    inline int width(){
        return width_;
    }

    inline int height(){
        return height_;
    }

    inline GstElement *rtph264depay(){
        return rtph264depay_;
    }
private:
    GstElement *pipeline_;
    GstElement *rtspsrc_;      // 读取rtsp流
    GstElement *rtph264depay_; // 从rtspsrc接收到rtp包
    GstElement *h264parse_;    // 分割输出H264帧数据
    GstElement *omxh264dec_;   // 硬解码H264帧数据
    GstElement *nvvidconv_;    // 硬解码drm_prime帧数据成BGRx
    GstElement *capsfilter_;   // 指定输出的数据类型
    GstElement *videoconvert_; // 转换video数据格式
    GstElement *appsink_;      // 获取BGRx数据

    int width_ = 0;
    int height_ = 0;

    std::string url_;
};
