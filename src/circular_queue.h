//
// Created by Chian on 4/3/2024.
//

#ifndef QUICK_DEMO_CIRCULAR_QUEUE_H
#define QUICK_DEMO_CIRCULAR_QUEUE_H

#include <vector>

using namespace std;

template<class T>
class CircularQueue{
    int front;
    int rear;
    int capacity = 60;
    vector<T> elements;

public:
    CircularQueue(int k){
        this->capacity = k + 1;
        rear = front = 0;
    }

    bool enQueue(T value);
    bool deQueue();

    T Front();

    T Rear();
    bool isEmpty(){
        return rear == front;
    }

    bool isFull(){
        return ((rear + 1) % capacity) == front;
    }
};

#endif //QUICK_DEMO_CIRCULAR_QUEUE_H
