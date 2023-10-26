//
//  LLJSilderView.swift
//  Dandelion-swift
//
//  Created by liushuai on 2023/8/10.
//

import UIKit

class LLJSilderView: UISlider {
    
    private var _progressValue: CGFloat = 0.0
    private var sliderView: UIView?
    
    lazy var progressView: UIImageView = {
        let progressView = UIImageView()
        progressView.backgroundColor = .lightGray;
        return progressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LLJSilderView {
    // 缓冲进度
    var progressValue: CGFloat {
        set {
            
            if _progressValue == newValue {
                return
            }
            
            _progressValue = newValue
            self.layoutSubviews()
        }
        get {
            return _progressValue
        }
    }
}

extension LLJSilderView {
    // UI
    private func setUpUI() {
        self.superview?.layoutIfNeeded()
        self.layoutSubviews()
        
        let subView: UIView = self.subviews.first!
        self.sliderView = subView.subviews.first
        
        self.sliderView?.addSubview(self.progressView)
    }
    
    private func layoutProgressView() {
        if self.sliderView != nil {
            let frame: CGRect = self.sliderView!.frame
            var bounds: CGRect?
            bounds?.origin.x = 0.0
            bounds?.origin.y = 0.0
            bounds?.size.width = self.frame.size.width*self.progressValue
            bounds?.size.height = frame.size.height
            self.progressView.frame = bounds!
        }
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let newBounds: CGRect = CGRect(bounds.origin.x, 14, bounds.size.width, 2.0)
        return newBounds
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutProgressView()
    }
}
