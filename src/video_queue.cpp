//
// Created by Chian on 4/2/2024.
//

#include "video_queue.h"

VideoQueue* VideoQueue::instance_;
std::mutex VideoQueue::mutex_;