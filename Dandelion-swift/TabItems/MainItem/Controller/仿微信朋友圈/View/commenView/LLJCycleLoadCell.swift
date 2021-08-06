//
//  LLJCycleLoadCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/8/5.
//

import UIKit

class LLJCycleLoadCell: UITableViewCell {

    lazy var logoImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "loading")
        return logoImage
    }()
    
    lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.textColor = LLJBlackColor()
        contentLabel.font = LLJFont(15, "")
        contentLabel.text = "正在加载..."
        return contentLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        //UI
        setSubUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LLJCycleLoadCell {
    
    private func setSubUpUI() {
        
        self.contentView.addSubview(self.logoImage)
        self.contentView.addSubview(self.contentLabel)
        
        self.contentLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.contentView.snp_centerX).offset(LLJDX(13))
            make.centerY.equalTo(self.contentView.snp_centerY)
        }
        
        self.logoImage.snp_makeConstraints { (make) in
            make.right.equalTo(self.contentLabel.snp_left).offset(LLJDX(-10))
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.height.equalTo(LLJDX(16))
            make.width.equalTo(LLJDX(16))
        }
    }
    //设置数据
    func startLoading() {
        let basic = LLJAnimation.basicAnimation(keyPath: "transform.rotation.z", beginTime: 0.0, fromValue: nil, toValue: CGFloat.pi*2, byValue: nil, duration: 1.0, timingFunctionName: .linear, repeatCount: 3, repeatDuration: 3.0, fillMode: .forwards, autoreverses: false, removedOnCompletion: false)
        self.logoImage.layer.add(basic, forKey: "basic")
    }
}
