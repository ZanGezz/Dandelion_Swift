//
//  LLJVideoView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/24.
//

import UIKit

class LLJVideoView: UIView {

    lazy var videoStart: UIButton = {
        let videoStart = UIButton(type: .custom)
        videoStart.addTarget(self, action: #selector(videoStartAction), for: .touchUpInside)
        return videoStart
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        //UI
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LLJVideoView {
    
    private func setUpUI() {
        
    }
    
    @objc private func videoStartAction() {
        
    }
}
