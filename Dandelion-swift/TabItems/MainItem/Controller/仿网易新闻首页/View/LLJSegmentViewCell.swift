//
//  LLJSegmentViewCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/5/25.
//

import UIKit

class LLJSegmentViewCell: UICollectionViewCell {
    
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = NSTextAlignment.center
        return titleLabel
    }()
    
    lazy var cycleView: UIView = {
        let cycleView = UIView()
        return cycleView
    }()
    
    private var _firstItemLeftOffSet: CGFloat = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - set get 方法
extension LLJSegmentViewCell {
    
    var firstItemLeftOffSet: CGFloat {
        set {
            _firstItemLeftOffSet = newValue
            layoutSubview()
        }
        get {
            return _firstItemLeftOffSet
        }
    }
}

//MARK: - 基础UI 布局 设置数据 -
extension LLJSegmentViewCell {
    
    //UI
    private func setUpUI() {
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.cycleView)
        
        layoutSubview()
    }
    
    //布局
    private func layoutSubview() {
        self.titleLabel.snp_remakeConstraints { (make) in
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.centerX.equalTo(self.contentView.snp_centerX).offset(self.firstItemLeftOffSet/2)
        }
    }
    
    //赋值
    func setDataSource(title: String, textColor: UIColor, textFont: UIFont) {
        self.titleLabel.text = title
        self.titleLabel.font = textFont
        self.titleLabel.textColor = textColor
    }
    
    //设置圆圈frame
    func setCycleViewFrame(model: LLJSegmentModel, color: UIColor) {
        
        self.cycleView.backgroundColor = color
        self.cycleView.snp_remakeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp_right).offset(2.0)
            make.centerY.equalTo(self.titleLabel.snp_top)
            make.width.equalTo(model.bottomLineDragFrame.width)
            make.height.equalTo(model.bottomLineDragFrame.height)
        }
    }
}

