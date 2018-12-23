//
//  QueueFactory.swift
//  YCPortForwarder
//
//  Created by yicheng on 2018/12/23.
//

class QueueFactory: NSObject {
    
    static let queue: DispatchQueue = {
        let q = DispatchQueue(label: "YCPortForwarder.networkQueue", qos: .default, attributes: DispatchQueue.Attributes.concurrent)
        return q
    }()
    
    static func getQueue() -> DispatchQueue {
        return QueueFactory.queue
    }
    
}
