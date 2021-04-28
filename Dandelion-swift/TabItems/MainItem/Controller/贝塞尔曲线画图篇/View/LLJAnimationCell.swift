//
//  LLJAnimationCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/4/28.
//

import UIKit

class LLJAnimationCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = LLJFont(14)
        titleLabel.textColor = LLJWhiteColor()
        titleLabel.backgroundColor = LLJBlackColor()
        titleLabel.textAlignment = NSTextAlignment.center
        return titleLabel
    }()
    
    lazy var titleButton: UIButton = {
        let titleButton = UIButton(type: UIButton.ButtonType.custom)
        titleButton.addTarget(self, action: #selector(buttonClick(sender:)), for: UIControl.Event.touchUpInside)
        return titleButton
    }()
    
    lazy var drawView: UIView = {
        let drawView = UIView()
        return drawView
    }()
    
    lazy var animationView: UIView = {
        let animationView = UIView()
        animationView.backgroundColor = UIColor.red
        return animationView
    }()
    
    lazy var subAnimationView: UIView = {
        let subAnimationView = UIView()
        subAnimationView.backgroundColor = UIColor.yellow
        return subAnimationView
    }()
    
    var model: LLJAnimationModel?
    
    var animation: CAAnimation?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //UI
        setUpUI()
    }
    //必要初始化器
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LLJAnimationCell {
    //UI
    func setUpUI() {
        
        self.contentView.backgroundColor = LLJWhiteColor()
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_left)
            make.right.equalTo(self.contentView.snp_right)
            make.bottom.equalTo(self.contentView.snp_bottom)
            make.height.equalTo(30)
        }
        
        self.contentView.addSubview(self.titleButton)
        self.titleButton.snp_makeConstraints { (make) in
            make.edges.equalTo(self.titleLabel)
        }
        
        self.contentView.addSubview(self.drawView)
        self.drawView.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_left)
            make.right.equalTo(self.contentView.snp_right)
            make.top.equalTo(self.contentView.snp_top)
            make.bottom.equalTo(self.titleLabel.snp_top)
        }
    }
}

extension LLJAnimationCell {
    //设置数据
    func setDataSource(model: LLJAnimationModel) {
        
        self.model = model
        self.drawView.addSubview(self.animationView)
        //基础动画
        if model.animationName == "基础动画-平移" {
            //动画名称
            self.titleLabel.text = model.animationName
            
            self.animationView.snp_makeConstraints { (make) in
                make.left.equalTo(self.drawView.snp_left)
                make.centerY.equalTo(self.drawView.snp_centerY)
                make.height.equalTo(50)
                make.width.equalTo(50)
            }
        } else if model.animationName == "基础动画-缩放" {
            //动画名称
            self.titleLabel.text = model.animationName
            
            self.animationView.snp_makeConstraints { (make) in
                make.centerX.equalTo(self.drawView.snp_centerX)
                make.centerY.equalTo(self.drawView.snp_centerY)
                make.height.equalTo(100)
                make.width.equalTo(100)
            }
        } else if model.animationName == "基础动画-旋转" {
            //动画名称
            self.titleLabel.text = model.animationName
            
            self.animationView.snp_makeConstraints { (make) in
                make.centerX.equalTo(self.drawView.snp_centerX)
                make.centerY.equalTo(self.drawView.snp_centerY)
                make.height.equalTo(50)
                make.width.equalTo(50)
            }
        } else if model.animationName == "基础动画-淡出" {
            //动画名称
            self.titleLabel.text = model.animationName
            
            self.animationView.snp_makeConstraints { (make) in
                make.centerX.equalTo(self.drawView.snp_centerX)
                make.centerY.equalTo(self.drawView.snp_centerY)
                make.height.equalTo(100)
                make.width.equalTo(100)
            }
        } else if model.animationName == "弹性动画-震动" {
            //动画名称
            self.titleLabel.text = model.animationName
            
            self.animationView.snp_makeConstraints { (make) in
                make.centerX.equalTo(self.drawView.snp_centerX)
                make.centerY.equalTo(self.drawView.snp_centerY)
                make.height.equalTo(50)
                make.width.equalTo(50)
            }
        } else if model.animationName == "弹性动画-平移" {
            //动画名称
            self.titleLabel.text = model.animationName
            
            self.animationView.snp_makeConstraints { (make) in
                make.left.equalTo(self.drawView.snp_left)
                make.centerY.equalTo(self.drawView.snp_centerY)
                make.height.equalTo(50)
                make.width.equalTo(50)
            }
        }
        
        self.animationView.addSubview(self.subAnimationView)
        self.subAnimationView.frame = CGRect(x: 0, y: 0, width: 10, height: 10);
    }
}

extension LLJAnimationCell {
    //按钮事件
    @objc func buttonClick(sender: UIButton) {
            
        if self.animation == nil {
            if self.model!.animationName == "基础动画-平移" {
                let basicAnimation = LLJAnimation.basicAnimation(keyPath: "position", fromValue: NSValue(cgPoint: CGPoint(x: self.animationView.center.x, y: self.animationView.center.y)), toValue: NSValue(cgPoint: CGPoint(x: self.drawView.bounds.size.width - self.animationView.center.x, y: self.animationView.center.y)), byValue: nil, duration: 2, timingFunctionName: nil, repeatCount: 0.0, repeatDuration: 0.0, fillMode: CAMediaTimingFillMode.both, autoreverses: false, removedOnCompletion: false)
                self.animation = basicAnimation
            } else if self.model!.animationName == "基础动画-缩放" {
                let basicAnimation = LLJAnimation.basicAnimation(keyPath: "transform.scale", fromValue: 1, toValue: 0.5, byValue: nil, duration: 2, timingFunctionName: nil, repeatCount: 0.0, repeatDuration: 0.0, fillMode: CAMediaTimingFillMode.both, autoreverses: true, removedOnCompletion: false)
                self.animation = basicAnimation
            } else if self.model!.animationName == "基础动画-旋转" {
                let basicAnimation = LLJAnimation.basicAnimation(keyPath: "transform.rotation.z", fromValue: nil, toValue: Double.pi, byValue: nil, duration: 2, timingFunctionName: nil, repeatCount: 0.0, repeatDuration: 0.0, fillMode: CAMediaTimingFillMode.both, autoreverses: true, removedOnCompletion: false)
                self.animation = basicAnimation
            } else if self.model!.animationName == "基础动画-淡出" {
                let basicAnimation = LLJAnimation.basicAnimation(keyPath: "opacity", fromValue: 1, toValue: 0.2, byValue: nil, duration: 2, timingFunctionName: nil, repeatCount: 0.0, repeatDuration: 0.0, fillMode: CAMediaTimingFillMode.both, autoreverses: true, removedOnCompletion: false)
                self.animation = basicAnimation
            } else if self.model!.animationName == "弹性动画-震动" {
                let springAnimation = LLJAnimation.springAnimation(keyPath: "bounds", fromValue: nil, toValue: CGRect(x: 0, y: 0, width: self.animationView.bounds.size.width + 50, height: self.animationView.bounds.size.height + 50), byValue: nil, duration: 5.0, damping: 10.0, stiffness: 1000.0, mass: 10, fillMode: CAMediaTimingFillMode.both, initialVelocity: 0,removedOnCompletion: false)
                self.animation = springAnimation
            } else if self.model!.animationName == "弹性动画-平移" {
                let springAnimation = LLJAnimation.springAnimation(keyPath: "position.x", fromValue: nil, toValue: self.drawView.bounds.size.width - self.animationView.center.x, byValue: nil, duration: 5.0, damping: 2.0, stiffness: 100.0, mass: 1, fillMode: CAMediaTimingFillMode.both, initialVelocity: 0,removedOnCompletion: false)
                self.animation = springAnimation
            } else {
                let basicAnimation = LLJAnimation.basicAnimation(keyPath: "position", fromValue: NSValue(cgPoint: CGPoint(x: self.animationView.center.x, y: self.animationView.center.y)), toValue: NSValue(cgPoint: CGPoint(x: self.drawView.bounds.size.width - self.animationView.center.x, y: self.animationView.center.y)), byValue: nil, duration: 2, timingFunctionName: nil, repeatCount: 0.0, repeatDuration: 0.0, fillMode: CAMediaTimingFillMode.both, autoreverses: false, removedOnCompletion: false)
                self.animation = basicAnimation
            }
        }
        self.animationView.layer.add(self.animation!, forKey: "basic")
    }
}
