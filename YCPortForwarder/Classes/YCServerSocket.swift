//
//  YCServerSocket.swift
//  YCPortForwarder
//
//  Created by yicheng on 2018/12/23.
//  Copyright © 2018 west2online. All rights reserved.
//

import CocoaAsyncSocket

protocol YCServerSocketDelegate:class {
    func socket(_ sock: YCServerSocket, didAcceptNewSocket newSocket: GCDAsyncSocket)
}


class YCServerSocket: NSObject {
    var localSocket:GCDAsyncSocket!
    weak var delegate:YCServerSocketDelegate?
    
    private let port:UInt16!
    
    var listenPort:UInt16 {
        return localSocket.localPort
    }
    
    override init() {
        fatalError()
    }
    
    init(port inPort:UInt16 = 0) {
        port = inPort
        super.init()
        localSocket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
    }
    
    func start() throws {
        try localSocket.accept(onPort: port)
    }
}

extension YCServerSocket:GCDAsyncSocketDelegate {
    func socket(_ sock: GCDAsyncSocket, didAcceptNewSocket newSocket: GCDAsyncSocket) {
        delegate?.socket(self, didAcceptNewSocket: newSocket)
    }
}
