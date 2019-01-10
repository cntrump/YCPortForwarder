//
//  YCServerSocket.swift
//  YCPortForwarder
//
//  Created by yicheng on 2018/12/23.
//  Copyright © 2018 west2online. All rights reserved.
//

import CocoaAsyncSocket

public protocol YCServerSocketDelegate:class {
    func socket(_ sock: YCServerSocket, didAcceptNewSocket newSocket: GCDAsyncSocket)
}


public class YCServerSocket: NSObject {
    private var localSocket:GCDAsyncSocket!
    public weak var delegate:YCServerSocketDelegate?
    
    private let port:UInt16!
    
    public var listenPort:UInt16 {
        return localSocket.localPort
    }
    
    override init() {
        fatalError()
    }
    
    public init(port inPort:UInt16 = 0) {
        port = inPort
        super.init()
        localSocket = GCDAsyncSocket(delegate: self, delegateQueue: QueueFactory.getQueue())
    }
    
    public func start() throws {
        try localSocket.accept(onPort: port)
    }
}

extension YCServerSocket:GCDAsyncSocketDelegate {
    public func socket(_ sock: GCDAsyncSocket, didAcceptNewSocket newSocket: GCDAsyncSocket) {
        delegate?.socket(self, didAcceptNewSocket: newSocket)
    }
}
