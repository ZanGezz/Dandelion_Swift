//
//  LLJZanView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/26.
//

import UIKit

class LLJZanView: UIView {

    lazy var zanButton: UIButton = {
        let zanButton = UIButton(type: .custom)
        zanButton.tag = 2000020
        zanButton.setTitle("赞", for: .normal)
        zanButton.setImage(UIImage(named: "zan"), for: .normal)
        zanButton.titleLabel?.font = LLJFont(14, "")
        zanButton.setTitleColor(LLJWhiteColor(), for: .normal)
        zanButton.imageEdgeInsets = UIEdgeInsets.init(top: LLJDX(13), left: LLJDX(31), bottom: LLJDX(11), right: LLJDX(42))
        zanButton.addTarget(self, action: #selector(zanAction), for: .touchUpInside)
        return zanButton
    }()
    
    lazy var pingButton: UIButton = {
        let pingButton = UIButton(type: .custom)
        pingButton.tag = 2000021
        pingButton.setTitle("评论", for: .normal)
        pingButton.setImage(UIImage(named: "pinglun"), for: .normal)
        pingButton.titleLabel?.font = LLJFont(14, "")
        pingButton.imageEdgeInsets = UIEdgeInsets.init(top: LLJDX(14), left: LLJDX(22), bottom: LLJDX(12), right: LLJDX(54))
        pingButton.titleEdgeInsets = UIEdgeInsets.init(top: LLJDX(12), left: LLJDX(-40), bottom: LLJDX(12), right: LLJDX(0))
        pingButton.setTitleColor(LLJWhiteColor(), for: .normal)
        pingButton.addTarget(self, action: #selector(zanAction), for: .touchUpInside)
        return pingButton
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = LLJColor(70, 70, 70, 1.0)
        return lineView
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

extension LLJZanView {
    
    private func setUpUI() {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 6.0
        self.frame = CGRect(x: 0, y: 0, width: LLJDX(0.01), height: LLJDX(40))
        self.backgroundColor = LLJColor(77, 77, 77, 1.0)
        
        self.addSubview(self.zanButton)
        self.addSubview(self.pingButton)
        self.addSubview(self.lineView)
        
        self.zanButton.frame = CGRect(x: 0, y: 0, width: LLJDX(90), height: LLJDX(40))
        self.pingButton.frame = CGRect(x: LLJDX(90), y: 0, width: LLJDX(90), height: LLJDX(40))
        self.lineView.frame = CGRect(x: LLJDX(90), y: LLJDX(8), width: LLJDX(1.0), height: LLJDX(24))
    }
    
    @objc private func zanAction() {
        
    }
}
