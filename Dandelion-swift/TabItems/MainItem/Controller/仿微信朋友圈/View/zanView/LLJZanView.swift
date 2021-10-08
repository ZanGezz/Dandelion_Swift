//
//  LLJZanView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/26.
//

import UIKit

class LLJZanView: UIView {

    typealias zanActionBlock = ((Int64) -> Void)
    
    lazy var zanView: UIView = {
        let zanView = UIView()
        return zanView
    }()
    
    lazy var zanImageView: UIImageView = {
        let zanImageView = UIImageView(image: UIImage(named: "zan"))
        return zanImageView
    }()
    
    lazy var zanTitle: UILabel = {
        let zanTitle = UILabel()
        zanTitle.font = LLJFont(14, "")
        zanTitle.textColor = LLJWhiteColor()
        return zanTitle
    }()
    
    lazy var pingView: UIView = {
        let pingView = UIView()
        return pingView
    }()
    
    lazy var pingImageView: UIImageView = {
        let pingImageView = UIImageView(image: UIImage(named: "pinglun"))
        return pingImageView
    }()
    
    lazy var pingTitle: UILabel = {
        let pingTitle = UILabel()
        pingTitle.font = LLJFont(14, "")
        pingTitle.textColor = LLJWhiteColor()
        pingTitle.text = "评论"
        return pingTitle
    }()
    
    lazy var zanButton: UIButton = {
        let zanButton = UIButton(type: .custom)
        zanButton.tag = 2000020
        zanButton.addTarget(self, action: #selector(zanAction(sender:)), for: .touchUpInside)
        return zanButton
    }()
    
    lazy var pingButton: UIButton = {
        let pingButton = UIButton(type: .custom)
        pingButton.tag = 2000021
        pingButton.addTarget(self, action: #selector(zanAction(sender:)), for: .touchUpInside)
        return pingButton
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = LLJColor(70, 70, 70, 1.0)
        return lineView
    }()
    
    var zanAction: zanActionBlock?
    
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
        
        self.addSubview(self.zanView)
        self.addSubview(self.pingView)
        self.zanView.addSubview(self.zanButton)
        self.pingView.addSubview(self.pingButton)
        self.zanView.addSubview(self.zanImageView)
        self.pingView.addSubview(self.pingImageView)
        self.zanView.addSubview(self.zanTitle)
        self.pingView.addSubview(self.pingTitle)
        self.addSubview(self.lineView)
        
        self.zanView.frame = CGRect(x: 0, y: 0, width: LLJDX(90), height: LLJDX(40))
        self.pingView.frame = CGRect(x: LLJDX(90), y: 0, width: LLJDX(90), height: LLJDX(40))
        self.zanButton.frame = CGRect(x: 0, y: 0, width: LLJDX(90), height: LLJDX(40))
        self.pingButton.frame = CGRect(x: 0, y: 0, width: LLJDX(90), height: LLJDX(40))
        
        self.zanImageView .snp_makeConstraints { (make) in
            make.centerY.equalTo(self.zanView.snp_centerY);
            make.right.equalTo(self.zanView.snp_centerX).offset(-2)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        self.zanTitle .snp_makeConstraints { (make) in
            make.centerY.equalTo(self.zanView.snp_centerY);
            make.left.equalTo(self.zanView.snp_centerX).offset(2)
        }
        
        self.pingImageView .snp_makeConstraints { (make) in
            make.centerY.equalTo(self.pingView.snp_centerY);
            make.right.equalTo(self.pingView.snp_centerX).offset(-3)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        self.pingTitle .snp_makeConstraints { (make) in
            make.centerY.equalTo(self.pingView.snp_centerY);
            make.left.equalTo(self.pingView.snp_centerX).offset(1)
        }
        
        self.zanButton.frame = CGRect(x: 0, y: 0, width: LLJDX(90), height: LLJDX(40))
        self.pingButton.frame = CGRect(x: 0, y: 0, width: LLJDX(90), height: LLJDX(40))
        self.lineView.frame = CGRect(x: LLJDX(90), y: LLJDX(8), width: LLJDX(1.0), height: LLJDX(24))
    }
    
    @objc private func zanAction(sender: UIButton) {
        var type: Int64 = 0
        switch sender.tag {
        case 2000020:
            type = 10001010
        default:
            type = 10001011
        }
        
        if self.zanAction != nil {
            self.zanAction!(type)
        }
    }
}
