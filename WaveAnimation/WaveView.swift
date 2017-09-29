//
//  SinView.swift
//  Tesst2
//
//  Created by llc on 2017/9/28.
//  Copyright © 2017年 llc. All rights reserved.
//

import UIKit

/// 波浪动画View
class WaveView: UIView {
    /// 进度 默认0.5
    var progress: CGFloat = 0.5
    /// 颜色
    var color = UIColor(red: 113/255.0, green: 205/255.0, blue: 250/255.0, alpha: 1)
    /// 每次绘制调整的X变化
    private var plus: Double = 0
    /// sin曲线的基准Y
    private lazy var baseY: CGFloat = self.frame.height/2
    /// 同步绘制定时器
    private var disLink: CADisplayLink!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        disLink = CADisplayLink(target: self, selector: #selector(doDraw))
        disLink.add(to: RunLoop.current, forMode: .defaultRunLoopMode)
        backgroundColor = UIColor.white
        baseY = frame.height * (1-progress)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func doDraw() {
        if plus == 31.4 {
            plus = 0.05
        } else {
            plus += 0.05
        }
        baseY = frame.height * (1-progress)
        if baseY >= self.frame.height {
            baseY = self.frame.height
        }
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //let context = UIGraphicsGetCurrentContext()
        //使用UIBezierPath比UIGraphicsGetCurrentContext更节省CPU
        let path = UIBezierPath()
        path.lineWidth = 1
        color.set()
        path.move(to: CGPoint(x: 0, y: baseY))
        var y: CGFloat = baseY
        for x in (0..<(Int(rect.width))) {
            let newX = Double(x)*0.04 - plus
            y = baseY - CGFloat(sin(newX))*7
            path.addLine(to: CGPoint(x: CGFloat(x), y: y))
        }
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: baseY))
        path.fill()
    }
}

