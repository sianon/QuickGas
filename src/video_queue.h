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

class VideoQueue {
public:
    static VideoQueue* moGetInstance() {
        std::lock_guard<std::mutex> lock(mutex_);

        if (!instance_) {
            instance_ = new VideoQueue();
        }
        return instance_;
    }

    void mvPushVideo2Queue(const std::string& rtsp_url, QImage* image) {
        rtsp_video_queue_[rtsp_url].push(image);
    }

    QImage* moGetVideoFromQueue(const std::string& rtsp_url) {
        if (rtsp_video_queue_[rtsp_url].empty()) {
            return nullptr;
        }
        return rtsp_video_queue_[rtsp_url].front();
    }

    VideoQueue(const VideoQueue&) = delete;
    VideoQueue& operator=(const VideoQueue&) = delete;
private:
    VideoQueue() {}
    std::unordered_map<std::string, std::queue<QImage*>> rtsp_video_queue_;
    static VideoQueue* instance_;
    static std::mutex mutex_;
};


#endif //QUICKGAS_VIDEO_QUEUE_H
