//
//  LLJWCommenCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/6/22.
//

import UIKit

class LLJWCommenCell: UITableViewCell {

    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.layer.cornerRadius = LLJDX(8.0)
        return headImageView
    }()
    
    lazy var nickNameLabel: UILabel = {
        let nickNameLabel = UILabel()
        nickNameLabel.textColor = LLJColor(68, 86, 130, 1.0)
        nickNameLabel.font = LLJBoldFont(18)
        return nickNameLabel
    }()
    
    lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.textColor = LLJBlackColor()
        contentLabel.font = LLJBoldFont(18)
        contentLabel.numberOfLines = 0;
        return contentLabel
    }()
    
    lazy var contentBgView: UIView = {
        let contentBgView = UIView()
        return contentBgView
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textColor = LLJColor(179, 179, 179, 1.0)
        timeLabel.font = LLJBoldFont(16)
        return timeLabel
    }()
    
    lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: UIButton.ButtonType.custom)
        moreButton.backgroundColor = LLJColor(245.0, 245.0, 245.0, 1.0)
        moreButton.setTitle("● ●", for: UIControl.State.normal)
        moreButton.setTitleColor(LLJColor(68, 86, 130, 1.0), for: UIControl.State.normal)
        moreButton.titleLabel?.font = LLJFont(16)
        moreButton.addTarget(self, action: #selector(moreButtonClick(sender:)), for: UIControl.Event.touchUpInside)
        return moreButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //UI
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI -
extension LLJWCommenCell {
    
    //UI
    private func setUpUI() {
        
        self.contentView.addSubview(self.headImageView)
        self.contentView.addSubview(self.nickNameLabel)
        self.contentView.addSubview(self.contentLabel)
        self.contentView.addSubview(self.timeLabel)
    }
}

//MARK: - 数据处理 -
extension LLJWCommenCell {
    
    //按钮事件
    @objc private func moreButtonClick(sender: UIButton) {
        
    }
}
