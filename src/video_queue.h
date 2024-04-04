//
// Created by Chian on 4/2/2024.
//

#ifndef QUICKGAS_VIDEO_QUEUE_H
#define QUICKGAS_VIDEO_QUEUE_H

#include <iostream>
#include <mutex>
#include <unordered_map>
#include <queue>
#include <QImage>
#include <string>
#include "circular_queue.hpp"

class VideoQueue{
public:
    static VideoQueue* moGetInstance(){
        std::lock_guard<std::mutex> lock(mutex_);

        if(!instance_){
            instance_ = new VideoQueue();
        }
        return instance_;
    }

    void mvPushVideo2Queue(const std::string& rtsp_url, QImage image){
        QImage img = image.copy();

        rtsp_video_queue_[rtsp_url].push(img);
        rtsp_video_queue_t[rtsp_url].enQueue(img);
    }

    QImage moGetVideoFromQueue(const std::string& rtsp_url){
        if(rtsp_video_queue_[rtsp_url].empty()){
            return QImage(nullptr);
        }

        QImage tmp = rtsp_video_queue_[rtsp_url].front();
        rtsp_video_queue_[rtsp_url].pop();
        return tmp;
    }

    std::list<std::string> moGetAllRtspUrl(){
        std::list<std::string> rtsp_url_list;
        for(auto& rtsp_video_queue: rtsp_video_queue_){
            rtsp_url_list.push_back(rtsp_video_queue.first);
        }
        return rtsp_url_list;
    }

    VideoQueue(const VideoQueue&) = delete;

    VideoQueue& operator=(const VideoQueue&) = delete;
    CircularQueue<QImage> c_que_;
private:
    VideoQueue(){}

    std::unordered_map<std::string, std::queue<QImage>> rtsp_video_queue_;
    std::unordered_map<std::string, CircularQueue<QImage>> rtsp_video_queue_t;
    static VideoQueue* instance_;
    static std::mutex mutex_;
};


#endif //QUICKGAS_VIDEO_QUEUE_H
