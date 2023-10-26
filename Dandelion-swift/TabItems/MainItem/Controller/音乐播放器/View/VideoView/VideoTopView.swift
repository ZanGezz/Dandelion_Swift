//
//  VideoTopView.swift
//  Dandelion-swift
//
//  Created by liushuai on 2023/8/3.
//

import UIKit

class VideoTopView: UIView {
    // 闭包
    typealias callBackBlock = ((NSInteger) -> Void)
    // 返回按钮
    lazy var backButton: UIButton = {
        let back = UIButton(type: .custom)
        back.setImage(UIImage(named: "xiajiantou"), for: .normal)
        back.tag = 1020100
        back.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return back
    }()
    
    lazy var shareButton: UIButton = {
        let share = UIButton(type: .custom)
        share.tag = 1020101
        share.setImage(UIImage(named: "paishipin"), for: .normal)
        share.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return share
    }()
    lazy var movieButton: UIButton = {
        let movie = UIButton(type: .custom)
        movie.tag = 1020102
        movie.setImage(UIImage(named: "fenxiang"), for: .normal)
        movie.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return movie
    }()
    
    // 回调
    var callBack: callBackBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VideoTopView {
    // UI
    private func setUpUI() {
        self.addSubview(self.backButton)
        self.backButton.snp_makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(LLJDX(22))
            make.top.equalTo(self.snp_top).offset(LLJDX(12))
            make.width.equalTo(LLJDX(26))
            make.height.equalTo(LLJDX(26))
        }
        
        self.addSubview(self.movieButton);
        self.movieButton.snp_makeConstraints { make in
            make.right.equalTo(self.snp_right).offset(-LLJDX(22))
            make.centerY.equalTo(self.backButton.snp_centerY)
            make.width.equalTo(LLJDX(26))
            make.height.equalTo(LLJDX(26))
        }
        
        self.addSubview(self.shareButton)
        self.shareButton.snp_makeConstraints { make in
            make.right.equalTo(self.movieButton.snp_left).offset(-LLJDX(12))
            make.centerY.equalTo(self.backButton.snp_centerY)
            make.width.equalTo(LLJDX(26))
            make.height.equalTo(LLJDX(26))
        }
    }
    // 返回
    @objc private func buttonAction(sender: UIButton) {
        LLJLog("back")
        if self.callBack != nil {
            self.callBack!(sender.tag)
        }
    }
}
