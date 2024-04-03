//
// Created by Chian on 4/3/2024.
//

#include "circular_queue.h"

template<class T>
bool CircularQueue<T>::enQueue(T value){
    if(isFull()){
        return false;
    }
    elements[rear] = value;
    rear = (rear + 1) % capacity;
    return true;
}

template<class T>
bool CircularQueue<T>::deQueue(){
    if(isEmpty()){
        return false;
    }
    front = (front + 1) % capacity;
    return true;
}

template<class T>
T CircularQueue<T>::Front(){
    if(isEmpty()){
        return T();
    }
    return elements[front];
}

template<class T>
T CircularQueue<T>::Rear(){
    if(isEmpty()){
        return T();
    }
    return elements[(rear - 1 + capacity) % capacity];
}