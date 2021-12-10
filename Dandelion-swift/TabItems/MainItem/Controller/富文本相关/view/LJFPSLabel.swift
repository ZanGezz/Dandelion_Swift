//
//  LJFPSLabel.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/8/31.
//

import UIKit

class LJFPSLabel: UILabel {

    private var displayLink: CADisplayLink?
    private var count: Int = 0
    private var lastTime: TimeInterval = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //添加监听
        addObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.displayLink?.invalidate()
    }
}

extension LJFPSLabel {
    
    private func addObserver() {
        
        let displayLink = CADisplayLink(target: self, selector: #selector(tick(displayLink:)))
        displayLink.add(to: RunLoop.current, forMode: .common)
        self.displayLink = displayLink
    }
    
    @objc private func tick(displayLink: CADisplayLink) {
        
        if lastTime == 0 {
            lastTime = displayLink.timestamp
            return
        }
        
        count += 1
        
        let dt = displayLink.timestamp - lastTime
        if dt < 1 {
            return
        }

        lastTime = displayLink.timestamp

        let fps = Double(count) / dt
        if fps >= 55 {
            self.textColor = UIColor.green
        } else if (fps > 40) {
            self.textColor = UIColor.yellow
        } else {
            self.textColor = UIColor.red
        }
        self.text = String(Int(fps)) + " FPS"
        
        count = 0
    }
}
