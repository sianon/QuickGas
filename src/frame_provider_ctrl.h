//
// Created by Chian on 4/8/2024.
//

#ifndef QUICKGAS_FRAME_PROVIDER_CTRL_H
#define QUICKGAS_FRAME_PROVIDER_CTRL_H

#include <iostream>
#include <mutex>
#include <unordered_map>
#include <queue>
#include <QImage>
#include <string>
#include <QStringList>

#include "frame_provider.h"
#include "video_queue.h"

class FrameProviderCtrl : public QObject{
Q_OBJECT
public:
    explicit FrameProviderCtrl(QObject* parent = nullptr){
        provider_ = new FrameProvider();
    }

    ~FrameProviderCtrl(){
    }

    Q_INVOKABLE FrameProvider* moGetProvider(){
        return provider_;
    }

    Q_INVOKABLE QStringList molGetAllRtspUrl(){
        std::list<std::string> tmp = VideoQueue::moGetInstance()->moGetAllRtspUrl();
        QStringList res;
        for(auto& i: tmp){
            QString tmp = QString::fromStdString(i);
            res.push_back(tmp);
        }

        return res;
    }

    Q_INVOKABLE QString mosGetRtspUrlByIndex(unsigned int index){
        std::list<std::string> tmp = VideoQueue::moGetInstance()->moGetAllRtspUrl();
        QStringList res;
        for(auto& i: tmp){
            QString tmp = QString::fromStdString(i);
            res.push_back(tmp);
        }
        auto tmps = res.size();
        if(index >= res.size())
            return "";
        else
            return res[index];
    }

private:
    FrameProvider* provider_;
    FrameProviderCtrl* instance_;
    static std::mutex mutex_;
};

#endif //QUICKGAS_FRAME_PROVIDER_CTRL_H
