//
//  YCPortForwarder.swift
//  YCPortForwarder
//
//  Created by yicheng on 2018/12/23.
//  Copyright © 2018 west2online. All rights reserved.
//

import Foundation
import CocoaAsyncSocket

@objc public  protocol YCPortForwarderDelegate:class {
    @objc optional func portForwarderDidReadRemoteData(_ forwarder:YCPortForwarder, data:Data)
    @objc optional func portForwarderDidReadClientData(_ forwarder:YCPortForwarder, data:Data)
}

public class YCPortForwarder:NSObject {
    
    private var tunnels = [String:YCTunnel]()
    
    private let server:YCServerSocket
    
    private var tunnelFactory:YCTunnelFactory
    
    public weak var delegate:YCPortForwarderDelegate?
    
    public var delegateQueue:DispatchQueue = DispatchQueue.main

    
    override init() {fatalError()}
    
    public init(remoteHost host:String, remotePort:UInt16, toPort target:UInt16 = 0) {
        server = YCServerSocket(port: target)
        tunnelFactory = YCTunnelFactory(remoteHost: host, remotePort: remotePort)
        super.init()
        server.delegate = self
    }
    
    @discardableResult
    public func start() -> UInt16? {
        do {
            try server.start()
            print(server.listenPort)
        } catch {
            return nil
        }

        return server.listenPort
    }
    
}


extension YCPortForwarder:YCServerSocketDelegate {
    func socket(_ sock: YCServerSocket, didAcceptNewSocket newSocket: GCDAsyncSocket) {
        if let tunnel = tunnelFactory.getTunnel(client: newSocket, delegate: self) {
            tunnels[tunnel.uuid] = tunnel
        } else {
            newSocket.disconnect()
        }
    }
}

extension YCPortForwarder:YCTunnelDelegate {
    func tunnelDidReadRemoteData(_ tunnel: YCTunnel, data: Data) {
        delegateQueue.async {
            self.delegate?.portForwarderDidReadRemoteData?(self, data: data)
        }
    }
    
    func tunnelDidReadClientData(_ tunnel: YCTunnel, data: Data) {
        delegateQueue.async {
            self.delegate?.portForwarderDidReadClientData?(self, data: data)
        }
    }
    
    func tunnelDidDisconnect(_ tunnel: YCTunnel) {
        tunnels[tunnel.uuid] = nil
    }
    
}
