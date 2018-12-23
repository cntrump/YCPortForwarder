//
//  YCTunnel.swift
//  YCPortForwarder
//
//  Created by yicheng on 2018/12/23.
//  Copyright © 2018 west2online. All rights reserved.
//

import CocoaAsyncSocket

@objc protocol YCTunnelDelegate:class {
    func tunnelDidDisconnect(_ tunnel:YCTunnel)
    func tunnelDidReadRemoteData(_ tunnel:YCTunnel, data:Data)
    func tunnelDidReadClientData(_ tunnel:YCTunnel, data:Data)
}

class YCTunnel:NSObject {
    var clientSocket:GCDAsyncSocket
    var remoteSocket:GCDAsyncSocket
    var uuid:String
    
    weak var delegate:YCTunnelDelegate?
    
    
    init(client:GCDAsyncSocket,remote:GCDAsyncSocket) {
        clientSocket = client
        remoteSocket = remote
        uuid = UUID().uuidString
        super.init()
    }
    
    func setup() {
        clientSocket.delegate = self
        remoteSocket.delegate = self
    }
    
    func remoteDidConnected() {
        print("did connect")
        clientSocket.readData(withTimeout: -1, tag: 0)
        remoteSocket.readData(withTimeout: -1, tag: 0)
    }
}

extension YCTunnel:GCDAsyncSocketDelegate {
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        var procceed = false
        if sock == remoteSocket {
            if clientSocket.isConnected {
                print("disconnecting client")
                clientSocket.disconnect()
                procceed = true
            }
        } else if sock == clientSocket {
            if remoteSocket.isConnected {
                print("disconnecting remote")
                remoteSocket.disconnect()
                procceed = true
            }
        }
        
        if procceed {
            delegate?.tunnelDidDisconnect(self)
        }
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        if sock == clientSocket {
            assert(remoteSocket.isConnected)
            remoteSocket.write(data, withTimeout: -1, tag: 0)
            
            delegate?.tunnelDidReadClientData(self, data: data)
        } else {
            clientSocket.write(data, withTimeout: -1, tag: 0)
            delegate?.tunnelDidReadRemoteData(self, data: data)
        }
        sock.readData(withTimeout: -1, tag: 0)
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectTo url: URL) {
        if sock == remoteSocket {
            remoteDidConnected()
        }
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        if sock == remoteSocket {
            remoteDidConnected()
        }
    }
}
