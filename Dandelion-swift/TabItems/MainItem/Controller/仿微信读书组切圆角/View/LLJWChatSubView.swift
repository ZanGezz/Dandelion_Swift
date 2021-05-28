//
//  LLJWChatSubView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/5/14.
//

import UIKit

class LLJWChatSubView: UIView {

    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = LLJSHelper.getImageByColorAndSize(LLJRandomColor(), CGSize(width: 24, height: 24))
        logoImageView.bounds = CGRect(x: 0, y: 0, width: 24, height: 24)
        LLJSUIKitHelper.LLJCView(subView: logoImageView, cornerRadius: 12)
        return logoImageView
    }()
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.font = LLJMediumFont(16)
        title.textColor = LLJBlackColor()
        return title
    }()
    
    lazy var subTitle: UILabel = {
        let subTitle = UILabel()
        subTitle.font = LLJFont(12)
        subTitle.textColor = LLJColor(159, 165, 175, 1)
        return subTitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    //必要初始化器
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LLJWChatSubView {
    
    func setUpUI() {
        
        self.layer.cornerRadius = 12
        self.backgroundColor = LLJColor(246, 246, 246, 1)
        
        self.addSubview(self.logoImageView)
        self.logoImageView.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(15)
            make.top.equalTo(self.snp_top).offset(15)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        self.addSubview(self.title)
        self.title.snp_makeConstraints { (make) in
            make.left.equalTo(self.logoImageView.snp_right).offset(12)
            make.centerY.equalTo(self.logoImageView.snp.centerY)
            make.height.equalTo(17)
        }
        
        self.addSubview(self.subTitle)
        self.subTitle.snp_makeConstraints { (make) in
            make.left.equalTo(self.title.snp_left)
            make.top.equalTo(self.title.snp.bottom).offset(12)
            make.height.equalTo(13)
        }
    }
    
    func setDataSource(title: String, subTitle: String) {
        self.title.text = title
        self.subTitle.text = subTitle
    }
}
