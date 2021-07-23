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
        headImageView.layer.masksToBounds = true
        headImageView.layer.cornerRadius = LLJDX(6.0)
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
        contentLabel.font = LLJFont(17, "")
        contentLabel.numberOfLines = 0;
        return contentLabel
    }()
    
    lazy var contentBgView: UIView = {
        let contentBgView = UIView()
        return contentBgView
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = LLJColor(241, 241, 241, 241)
        return lineView
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textColor = LLJColor(179, 179, 179, 1.0)
        timeLabel.font = LLJFont(14)
        timeLabel.text = "2分钟前"
        return timeLabel
    }()
    
    lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: UIButton.ButtonType.custom)
        moreButton.backgroundColor = LLJColor(245.0, 245.0, 245.0, 1.0)
        moreButton.setTitle("●  ●", for: UIControl.State.normal)
        moreButton.setTitleColor(LLJColor(68, 86, 130, 1.0), for: UIControl.State.normal)
        moreButton.titleLabel?.font = LLJFont(5)
        moreButton.layer.masksToBounds = true
        moreButton.layer.cornerRadius = 4.0
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
        self.contentView.addSubview(self.lineView)
        self.contentView.addSubview(self.moreButton)
    }
    
    private func layoutSubview(frameModel: LLJCycleFrameModel) {
        
        self.headImageView.frame = frameModel.headImageFrame
        self.nickNameLabel.frame = frameModel.nickNameFrame
        self.contentLabel.frame  = frameModel.contentFrame
        self.timeLabel.frame     = frameModel.timeIntevalFrame
        self.moreButton.frame    = frameModel.moreButtonFrame
        self.lineView.frame      = frameModel.lineViewFrame
    }
}

//MARK: - 数据处理 -
extension LLJWCommenCell {
    
    //按钮事件
    @objc private func moreButtonClick(sender: UIButton) {
        
    }
    
    //设置数据
    func setDataSource(sourceModel: LLJWeChatCycleModel, frameModel: LLJCycleFrameModel) {
        
        //布局
        layoutSubview(frameModel: frameModel)
        //设置数据
        self.headImageView.image = UIImage(named: sourceModel.headImageName ?? "")
        self.nickNameLabel.text = sourceModel.nickName
        self.contentLabel.text = sourceModel.content
    }
}
