#pragma once

#include <opencv2/core/core.hpp>
#include <string>
#include <gst/gst.h>
#include <memory>
#include <gst/gstelement.h>
#include <gst/app/gstappsink.h>

class RrspDecode : public std::enable_shared_from_this<RrspDecode>{
public:
    using Ptr = std::shared_ptr<RrspDecode>;

    ~RrspDecode();

    int init(int width, int height, std::string url);

    inline int width(){
        return width_;
    }

    inline int height(){
        return height_;
    }

    inline GstElement* rtph264depay(){
        return rtph264depay_;
    }

private:
    GstElement* pipeline_;
    GstElement* rtspsrc_;
    GstElement* rtph264depay_;
    GstElement* h264parse_;
    GstElement* omxh264dec_;
    GstElement* nvvidconv_;
    GstElement* capsfilter_;
    GstElement* videoconvert_;
    GstElement* appsink_;

    int width_ = 0;
    int height_ = 0;

    std::string url_;
};
