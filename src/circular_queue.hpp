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
    CircularQueue(){
        this->capacity = 1;
        rear = front = 0;
    }

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

template<typename  T>
bool CircularQueue<T>::enQueue(T value){
    if(isFull()){
        return false;
    }
    elements[rear] = value;
    rear = (rear + 1) % capacity;
    return true;
}

template<typename  T>
bool CircularQueue<T>::deQueue(){
    if(isEmpty()){
        return false;
    }
    front = (front + 1) % capacity;
    return true;
}

template<typename  T>
T CircularQueue<T>::Front(){
    if(isEmpty()){
        return T();
    }
    return elements[front];
}

template<typename  T>
T CircularQueue<T>::Rear(){
    if(isEmpty()){
        return T();
    }
    return elements[(rear - 1 + capacity) % capacity];
}

#endif //QUICK_DEMO_CIRCULAR_QUEUE_H
