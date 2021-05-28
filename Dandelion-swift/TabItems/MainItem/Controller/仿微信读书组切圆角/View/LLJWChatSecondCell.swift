//
//  LLJWChatSecondCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/5/17.
//

import UIKit

enum LLJWChatSecondCellType {
    case one
    case two
}

class LLJWChatSecondCell: UITableViewCell {
    
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
    
    lazy var content: UILabel = {
        let content = UILabel()
        content.textColor = LLJColor(50, 50, 50, 1)
        content.font = LLJFont(14)
        return content
    }()
    
    lazy var subContent: UILabel = {
        let subTitle = UILabel()
        subTitle.font = LLJFont(12)
        subTitle.textColor = LLJColor(159, 165, 175, 1)
        return subTitle
    }()
    
    lazy var pointView: UIImageView = {
        let pointView = UIImageView()
        pointView.image = LLJSHelper.getImageByColorAndSize(UIColor.red, CGSize(width: 8, height: 8))
        pointView.bounds = CGRect(x: 0, y: 0, width: 8, height: 8)
        LLJSUIKitHelper.LLJCView(subView: pointView, cornerRadius: 4)
        return pointView
    }()
    
    var type: LLJWChatSecondCellType?
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, type: LLJWChatSecondCellType) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.type = type
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LLJWChatSecondCell {
    
    func setUpUI() {
        
        self.backgroundColor = LLJColor(246, 246, 246, 1)
        
        self.contentView.addSubview(self.logoImageView)
        self.logoImageView.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_left).offset(15)
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        self.contentView.addSubview(self.title)
        self.title.snp_makeConstraints { (make) in
            make.left.equalTo(self.logoImageView.snp_right).offset(12)
            make.centerY.equalTo(self.logoImageView.snp.centerY)
            make.height.equalTo(17)
        }
        
        self.contentView.addSubview(self.pointView)
        self.pointView.snp_makeConstraints { (make) in
            make.left.equalTo(self.title.snp_right).offset(8)
            make.centerY.equalTo(self.title.snp.centerY)
            make.height.equalTo(8)
            make.width.equalTo(8)
        }
        
        if type == LLJWChatSecondCellType.one {
            
            self.contentView.addSubview(self.content)
            self.content.snp_makeConstraints { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-14)
                make.top.equalTo(self.contentView.snp.top).offset(16)
                make.height.equalTo(15)
            }
            
            self.contentView.addSubview(self.subContent)
            self.subContent.snp_makeConstraints { (make) in
                make.right.equalTo(self.content.snp_right)
                make.top.equalTo(self.content.snp.bottom).offset(12)
                make.height.equalTo(13)
            }
        } else {
            
            self.contentView.addSubview(self.content)
            self.content.snp_makeConstraints { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-14)
                make.centerY.equalTo(self.title.snp.centerY)
            }
        }
    }
    
    func setDataSource(title: String?, content: String?, subContent: String?, redPointShow: Bool?) {
        self.title.text = title ?? ""
        self.content.text = content ?? ""
        self.subContent.text = subContent ?? ""
        self.pointView.isHidden = !redPointShow! 
    }
}

extension LLJWChatSecondCell {
    
    override var frame:CGRect {
        didSet {
            var newFrame = frame
            newFrame.origin.x += 15
            newFrame.size.width -= 30
            super.frame = newFrame
        }
    }
}
