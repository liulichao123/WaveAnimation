//
//  ViewController.swift
//  WaveAnimation
//
//  Created by llc on 2017/9/28.
//  Copyright © 2017年 llc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let timer = DispatchSource.makeTimerSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test2()
        
        //test1()
    }
    
    /// 不带
    func test2() {
        let v = WaveView(frame: CGRect(x: 100, y:100, width: 200, height: 200))
        view.addSubview(v)
        v.layer.cornerRadius = 100
        v.layer.masksToBounds = true
        v.progress = 0.5
    }
    
    
    /// 带增长进度不带
    func test1() {
        let v = WaveView(frame: CGRect(x: 100, y:100, width: 200, height: 200))
        view.addSubview(v)
        v.layer.cornerRadius = 100
        v.layer.masksToBounds = true
        v.progress = 0
        
        //模拟进度控制
        timer.schedule(deadline: .now(), repeating: .milliseconds(50), leeway: .milliseconds(1))
        timer.setEventHandler {
            v.progress += 0.005
        }
        timer.resume()
    }
}


