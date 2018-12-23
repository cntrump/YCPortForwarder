//
//  YCTunnelFactory.swift
//  YCPortForwarder
//
//  Created by yicheng on 2018/12/23.
//  Copyright © 2018 west2online. All rights reserved.
//

import CocoaAsyncSocket

class YCTunnelFactory: NSObject {
    private var remoteHost:String
    
    private var remotePort:UInt16
    
    internal var remoteConnectTimeout:TimeInterval = 5
    
    init(remoteHost host:String, remotePort port:UInt16) {
        remoteHost = host
        remotePort = port
    }
    
    func getTunnel(client: GCDAsyncSocket, delegate:YCTunnelDelegate) -> YCTunnel? {
        let remote = GCDAsyncSocket()
        let tunnel = YCTunnel(client: client, remote: remote)
        remote.delegate = tunnel
        remote.delegateQueue = QueueFactory.getQueue()
        do {
            try remote.connect(toHost: remoteHost, onPort: remotePort, withTimeout:remoteConnectTimeout)
            tunnel.delegate = delegate
            tunnel.setup()
        } catch {
            return nil
        }
        return tunnel
    }
}
