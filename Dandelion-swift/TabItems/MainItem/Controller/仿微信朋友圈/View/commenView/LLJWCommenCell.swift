//
//  LLJWCommenCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/6/22.
//

import UIKit

class LLJWCommenCell: UITableViewCell {
    
    typealias moreActionBlock = ((LLJZanView) ->Void)
    typealias zanViewActionBlock = ((Int64) -> Void)
    typealias pingViewActionBlock = ((Int) -> Void)

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
    
    lazy var zanView: LLJZanView = {
        let zanView = LLJZanView()
        return zanView
    }()
    
    lazy var zanListView: LLJZanListView = {
        let zanListView = LLJZanListView()
        return zanListView
    }()
    
    var moreAction: moreActionBlock?
    var zanViewAction: zanViewActionBlock?
    var pingViewAction: pingViewActionBlock?

    private var model: LLJCycleMessageModel?

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
        self.contentView.addSubview(self.zanListView)
        
        self.zanView.zanAction = { (type) in
            
            self.viewHidden()

            if self.zanViewAction != nil {
                self.zanViewAction!(type)
            }
        }
        
        weak var weakSelf = self
        self.zanListView.selectPingItem = { (index) in
            if weakSelf!.pingViewAction != nil {
                weakSelf!.pingViewAction!(index)
            }
        }
            
    }
    
    private func layoutSubview(frameModel: LLJCycleFrameModel) {
        
        self.headImageView.frame = frameModel.headImageFrame
        self.nickNameLabel.frame = frameModel.nickNameFrame
        self.contentLabel.frame  = frameModel.contentFrame
        self.timeLabel.frame     = frameModel.timeIntevalFrame
        self.moreButton.frame    = frameModel.moreButtonFrame
        self.zanListView.frame   = frameModel.zanBgViewFrame
        self.lineView.frame      = frameModel.lineViewFrame
    }
}

//MARK: - 数据处理 -
extension LLJWCommenCell {
    
    //按钮事件
    @objc private func moreButtonClick(sender: UIButton) {
        
        if self.zanView.bounds.width < 0.1 || self.zanView.isHidden{
            viewShow()
        } else {
            viewHidden()
        }

        if moreAction != nil {
            moreAction!(self.zanView)
        }
    }
    
    //设置数据
    func setDataSource(sourceModel: LLJCycleMessageModel) {
        
        self.model = sourceModel
        //布局
        layoutSubview(frameModel: sourceModel.frameModel)
        //设置数据
        self.headImageView.image = UIImage(named: sourceModel.headImageName ?? "")
        self.nickNameLabel.text = sourceModel.nickName
        self.contentLabel.text = sourceModel.content
        self.timeLabel.text = LLJSHelper.exChangeTimeIntevalToMin(timeInteval: sourceModel.timeInteval!)
        //赞
        self.zanListView.setDataSource(sourceModel: sourceModel)
    }
    
    func viewShow() {
        
        self.addSubview(self.zanView)
        if self.model!.hasZaned {
            self.zanView.zanButton.setTitle("取消", for: .normal)
            self.zanView.zanButton.imageEdgeInsets = UIEdgeInsets.init(top: LLJDX(12), left: LLJDX(21), bottom: LLJDX(12), right: LLJDX(53))
            self.zanView.zanButton.titleEdgeInsets = UIEdgeInsets.init(top: LLJDX(12), left: LLJDX(-10), bottom: LLJDX(12), right: LLJDX(0))
        } else {
            self.zanView.zanButton.setTitle("赞", for: .normal)
            self.zanView.zanButton.imageEdgeInsets = UIEdgeInsets.init(top: LLJDX(12), left: LLJDX(26), bottom: LLJDX(12), right: LLJDX(48))
            self.zanView.zanButton.titleEdgeInsets = UIEdgeInsets.init(top: LLJDX(12), left: LLJDX(-10), bottom: LLJDX(12), right: LLJDX(0))
        }
        
        let X = self.moreButton.frame.origin.x - LLJDX(8) - LLJDX(180)
        let Y = self.moreButton.frame.origin.y - LLJDX(10)
        self.zanView.frame = CGRect(x: X + LLJDX(180), y: Y, width: LLJDX(0.01), height: LLJDX(40))
        self.zanView.isHidden = false
        UIView.animate(withDuration: 0.25) {
            self.zanView.frame = CGRect(x: X, y: Y, width: LLJDX(180), height: LLJDX(40))
        }
    }
    
    //隐藏
    func viewHidden() {
        let X = self.zanView.frame.origin.x
        let Y = self.zanView.frame.origin.y
        UIView.animate(withDuration: 0.25) {
            self.zanView.frame = CGRect(x: X + LLJDX(180), y: Y, width: LLJDX(0.01), height: LLJDX(40))
        } completion: { (com) in
            self.zanView.isHidden = true
        }
    }
}
