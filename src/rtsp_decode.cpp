#include "rtsp_decode.h"
#include <iostream>
#include <stdio.h>
#include <unistd.h>
#include <gst/gstelement.h>

#include <opencv2/core/core.hpp>
#include <opencv2/opencv.hpp>
#include <QImage>
#include "src/video_queue.h"

using namespace std;

GstFlowReturn CaptureGstBGRBuffer(GstAppSink* sink, gpointer user_data){
    GstSample* sample = gst_app_sink_pull_sample(sink);

    auto piple = GST_ELEMENT(gst_element_get_parent(sink));

    GstElement* source = gst_bin_get_by_name(GST_BIN(piple), "Rtspsrc");

    if(source == NULL || sample == NULL){
        g_print("Source not found in the pipeline.\n");
        return GST_FLOW_ERROR;
    }
    gchar* uri;
    g_object_get(source, "location", &uri, NULL);

    GstBuffer* buffer = gst_sample_get_buffer(sample);
    GstMapInfo map_info;
    if(!gst_buffer_map((buffer), &map_info, GST_MAP_READ)){
        gst_buffer_unmap((buffer), &map_info);
        gst_sample_unref(sample);
        return GST_FLOW_ERROR;
    }
    GstCaps* caps = gst_sample_get_caps(sample);
    gint width, height;
    GstStructure* structure = gst_caps_get_structure(caps, 0);
    gst_structure_get_int(structure, "width", &width);
    gst_structure_get_int(structure, "height", &height);
    QImage image(map_info.data, width, height, QImage::Format_RGBA8888);

    VideoQueue::moGetInstance()->mvPushVideo2Queue(uri, image.rgbSwapped());

    gst_buffer_unmap((buffer), &map_info);
    gst_sample_unref(sample);
    return GST_FLOW_OK;
}

static void RtspSrcPadAdded(GstElement* element, GstPad* pad, gpointer data){
    gchar* name;
    GstCaps* p_caps;
    gchar* description;
    GstElement* p_rtph264depay;

    name = gst_pad_get_name(pad);
    g_print("A new pad %s was created\n", name);

    // here, you would setup a new pad link for the newly created pad
    // sooo, now find that rtph264depay is needed and link them?
    p_caps = gst_pad_get_pad_template_caps(pad);

    description = gst_caps_to_string(p_caps);
    printf("%s \n", description);
    g_free(description);

    p_rtph264depay = GST_ELEMENT(data);

    // try to link the pads then ...
    if(!gst_element_link_pads(element, name, p_rtph264depay, "sink")){
        printf("Failed to link elements 3\n");
    }

    g_free(name);
}

RrspDecode::~RrspDecode(){
    if(pipeline_){
        gst_element_set_state(pipeline_, GST_STATE_NULL);
        gst_object_unref(pipeline_);
        pipeline_ = nullptr;
    }
}

int RrspDecode::init(int width, int height, std::string url){
    width_ = width;
    height_ = height;
    url_ = url;

    pipeline_ = gst_pipeline_new("pipeline");
    rtspsrc_ = gst_element_factory_make("rtspsrc", "Rtspsrc");
    rtph264depay_ = gst_element_factory_make("rtph264depay", "Rtph264depay");
    h264parse_ = gst_element_factory_make("h264parse", "H264parse");
    omxh264dec_ = gst_element_factory_make("d3d11h264dec", "d3d11h264dec");
    //    nvvidconv_ = gst_element_factory_make("nvvidconv", "Nvvidconv");
    videoconvert_ = gst_element_factory_make("videoconvert", "Videoconvert");
    capsfilter_ = gst_element_factory_make("capsfilter", "Capsfilter");

    appsink_ = gst_element_factory_make("appsink", "Appsink");

    if(!pipeline_ || !rtspsrc_ || !rtph264depay_ || !h264parse_ || !omxh264dec_ || !videoconvert_ || !capsfilter_ ||
       !appsink_){
        std::cerr << "Not all elements could be created" << std::endl;
        return -1;
    }

    // 设置
    g_object_set(G_OBJECT(rtspsrc_), "location", url_.c_str(), "latency", 1000, NULL);
    GstCaps* caps = gst_caps_new_simple("video/x-raw", "format", G_TYPE_STRING, "RGBA", NULL);
    g_object_set(G_OBJECT(capsfilter_), "caps", caps, NULL);
    //    g_object_set(G_OBJECT(capsfilter_), "caps", gst_caps_new_simple("video/x-raw", "format", G_TYPE_STRING, "BGRx", "width", G_TYPE_INT, width_, "height", G_TYPE_INT, height_, nullptr), NULL);
    // Set up appsink
    g_object_set(G_OBJECT(appsink_), "emit-signals", TRUE, NULL);
    g_object_set(G_OBJECT(appsink_), "sync", FALSE, NULL);
    g_object_set(G_OBJECT(appsink_), "drop", TRUE, NULL);
    g_signal_connect(appsink_, "new-sample", G_CALLBACK(CaptureGstBGRBuffer), reinterpret_cast<void*>(this));

    // Set up rtspsrc
    g_signal_connect(rtspsrc_, "pad-added", G_CALLBACK(RtspSrcPadAdded), rtph264depay_);


    // BAdd elements to pipeline
    gst_bin_add_many(GST_BIN(pipeline_), rtspsrc_, rtph264depay_, h264parse_, omxh264dec_, videoconvert_, capsfilter_,
                     appsink_, nullptr);

    // Link elements
    if(gst_element_link_many(rtph264depay_, h264parse_, omxh264dec_, videoconvert_, capsfilter_, appsink_, nullptr) !=
       TRUE){
        std::cerr
                << "rtspsrc_, rtph264depay_, h264parse_, omxh264dec_, capsfilter_,videoconvert_,appSink_ could not be linked"
                << std::endl;
        return -1;
    }

    // Start playing
    auto ret = gst_element_set_state(pipeline_, GST_STATE_PLAYING);
    if(ret == GST_STATE_CHANGE_FAILURE){
        std::cerr << "Unable to set the pipeline to the playing state" << std::endl;
        return -1;
    }
    return 0;
}