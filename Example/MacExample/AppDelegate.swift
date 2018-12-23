//
//  AppDelegate.swift
//  MacExample
//
//  Created by CYC on 2018/12/23.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Cocoa
import YCPortForwarder

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    let forwarder = YCPortForwarder(remoteHost: "127.0.0.1", remotePort: 20000, toPort: 5555)
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        forwarder.delegate = self
        forwarder.start()
    }

}

extension AppDelegate:YCPortForwarderDelegate {
    func portForwarderDidReadClientData(_ forwarder: YCPortForwarder, data: Data) {
        print("client")
    }
    
    func portForwarderDidReadRemoteData(_ forwarder: YCPortForwarder, data: Data) {
        print("remote")
    }
}

