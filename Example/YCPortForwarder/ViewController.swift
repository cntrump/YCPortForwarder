//
//  ViewController.swift
//  YCPortForwarder
//
//  Created by yicheng on 12/23/2018.
//  Copyright (c) 2018 yicheng. All rights reserved.
//

import UIKit
import YCPortForwarder

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        startPortForward()
    }
    
    var fordwarder:YCPortForwarder?
    func startPortForward() {
        fordwarder = YCPortForwarder(remoteHost: "192.168.1.1", remotePort: 22, toPort: 8888)
        if let localPort = fordwarder?.start() {
            print("127.0.0.1:\(localPort) <===> 192.168.1.1:22")
        }
    }

}

