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
    var subLayer: CAEmitterLayer?
    var drawLayer: CAShapeLayer?
    
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
        
        self.layoutIfNeeded()
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
            
            self.animationView.snp_remakeConstraints { (make) in
                make.left.equalTo(self.drawView.snp_left)
                make.centerY.equalTo(self.drawView.snp_centerY)
                make.height.equalTo(50)
                make.width.equalTo(50)
            }
            self.animationView.addSubview(self.subAnimationView)
            self.subAnimationView.frame = CGRect(x: 0, y: 0, width: 10, height: 10);
        } else if model.animationName == "基础动画-缩放" {
            //动画名称
            self.titleLabel.text = model.animationName
            
            self.animationView.snp_remakeConstraints { (make) in
                make.centerX.equalTo(self.drawView.snp_centerX)
                make.centerY.equalTo(self.drawView.snp_centerY)
                make.height.equalTo(100)
                make.width.equalTo(100)
            }
            self.animationView.addSubview(self.subAnimationView)
            self.subAnimationView.frame = CGRect(x: 0, y: 0, width: 10, height: 10);
        } else if model.animationName == "基础动画-旋转" {
            //动画名称
            self.titleLabel.text = model.animationName
            
            self.animationView.snp_remakeConstraints { (make) in
                make.centerX.equalTo(self.drawView.snp_centerX)
                make.centerY.equalTo(self.drawView.snp_centerY)
                make.height.equalTo(50)
                make.width.equalTo(50)
            }
            self.animationView.addSubview(self.subAnimationView)
            self.subAnimationView.frame = CGRect(x: 0, y: 0, width: 10, height: 10);
        } else if model.animationName == "基础动画-淡出" {
            //动画名称
            self.titleLabel.text = model.animationName
            
            self.animationView.snp_remakeConstraints { (make) in
                make.centerX.equalTo(self.drawView.snp_centerX)
                make.centerY.equalTo(self.drawView.snp_centerY)
                make.height.equalTo(100)
                make.width.equalTo(100)
            }
            self.animationView.addSubview(self.subAnimationView)
            self.subAnimationView.frame = CGRect(x: 0, y: 0, width: 10, height: 10);
        } else if model.animationName == "弹性动画-缩放" {
            //动画名称
            self.titleLabel.text = model.animationName
            
            self.animationView.snp_remakeConstraints { (make) in
                make.centerX.equalTo(self.drawView.snp_centerX)
                make.centerY.equalTo(self.drawView.snp_centerY)
                make.height.equalTo(50)
                make.width.equalTo(50)
            }
            self.animationView.addSubview(self.subAnimationView)
            self.subAnimationView.frame = CGRect(x: 0, y: 0, width: 10, height: 10);
        } else if model.animationName == "弹性动画-平移" {
            //动画名称
            self.titleLabel.text = model.animationName
            
            self.animationView.snp_remakeConstraints { (make) in
                make.left.equalTo(self.drawView.snp_left)
                make.centerY.equalTo(self.drawView.snp_centerY)
                make.height.equalTo(50)
                make.width.equalTo(50)
            }
            self.animationView.addSubview(self.subAnimationView)
            self.subAnimationView.frame = CGRect(x: 0, y: 0, width: 10, height: 10);
        } else if model.animationName == "弹性动画-旋转" {
            //动画名称
            self.titleLabel.text = model.animationName
            
            self.animationView.snp_remakeConstraints { (make) in
                make.centerX.equalTo(self.drawView.snp_centerX)
                make.centerY.equalTo(self.drawView.snp_centerY)
                make.height.equalTo(50)
                make.width.equalTo(50)
            }
            self.animationView.addSubview(self.subAnimationView)
            self.subAnimationView.frame = CGRect(x: 0, y: 0, width: 10, height: 10);
            
        } else if model.animationName == "粒子发射-烟花" {
            //动画名称
            self.titleLabel.text = model.animationName
            
        } else if model.animationName == "粒子发射-雪花" {
            //动画名称
            self.titleLabel.text = model.animationName
            self.drawView.backgroundColor = LLJBlackColor()
            
        } else if model.animationName == "粒子发射-细雨" {
            //动画名称
            self.titleLabel.text = model.animationName
            self.drawView.backgroundColor = LLJBlackColor()
            
        } else if model.animationName == "粒子发射-点赞" {
            //动画名称
            self.titleLabel.text = model.animationName
            
        } else if model.animationName == "移动动画-椭圆" {
                        
            self.subAnimationView.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
            self.subAnimationView.center = CGPoint(x: self.drawView.bounds.width/2, y: (self.drawView.bounds.height-80)/2)
            self.subAnimationView.backgroundColor = UIColor.blue
            self.drawView.addSubview(self.subAnimationView)
            //动画名称
            self.titleLabel.text = model.animationName
            self.drawLayer = CAShapeLayer()
        } else if model.animationName == "移动动画-正弦" {
            
            self.subAnimationView.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
            self.subAnimationView.center = CGPoint(x: 20, y: 70)
            self.subAnimationView.backgroundColor = UIColor.blue
            self.drawView.addSubview(self.subAnimationView)
            //动画名称
            self.titleLabel.text = model.animationName
            self.drawLayer = CAShapeLayer()
        } else if model.animationName == "移动动画-帧动画" {
            
            self.subAnimationView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            self.subAnimationView.center = self.drawView.center
            self.subAnimationView.backgroundColor = UIColor.blue
            self.drawView.addSubview(self.subAnimationView)
            //动画名称
            self.titleLabel.text = model.animationName
            self.drawLayer = CAShapeLayer()
        }
    }
}

extension LLJAnimationCell {
    //按钮事件
    @objc func buttonClick(sender: UIButton) {
        
        if self.model!.animationName == "基础动画-平移" {

            let basicAnimation = LLJAnimation.basicAnimation(keyPath: "position", beginTime: nil, fromValue: NSValue(cgPoint: CGPoint(x: self.animationView.center.x, y: self.animationView.center.y)), toValue: NSValue(cgPoint: CGPoint(x: self.drawView.bounds.size.width - self.animationView.center.x, y: self.animationView.center.y)), byValue: nil, duration: 2, timingFunctionName: nil, repeatCount: 0.0, repeatDuration: 0.0, fillMode: CAMediaTimingFillMode.both, autoreverses: false, removedOnCompletion: false)
            self.animationView.layer.add(basicAnimation, forKey: "basic")

        } else if self.model!.animationName == "基础动画-缩放" {

            let basicAnimation = LLJAnimation.basicAnimation(keyPath: "transform.scale", beginTime:nil, fromValue: 1, toValue: 0.5, byValue: nil, duration: 2, timingFunctionName: nil, repeatCount: 0.0, repeatDuration: 0.0, fillMode: CAMediaTimingFillMode.both, autoreverses: true, removedOnCompletion: false)
            self.animationView.layer.add(basicAnimation, forKey: "basic")

        } else if self.model!.animationName == "基础动画-旋转" {

            let basicAnimation = LLJAnimation.basicAnimation(keyPath: "transform.rotation.z", beginTime:nil, fromValue: nil, toValue: Double.pi, byValue: nil, duration: 2, timingFunctionName: nil, repeatCount: 0.0, repeatDuration: 0.0, fillMode: CAMediaTimingFillMode.both, autoreverses: true, removedOnCompletion: false)
            self.animationView.layer.add(basicAnimation, forKey: "basic")

        } else if self.model!.animationName == "基础动画-淡出" {

            let basicAnimation = LLJAnimation.basicAnimation(keyPath: "opacity", beginTime:nil, fromValue: 1, toValue: 0.2, byValue: nil, duration: 2, timingFunctionName: nil, repeatCount: 0.0, repeatDuration: 0.0, fillMode: CAMediaTimingFillMode.both, autoreverses: true, removedOnCompletion: false)
            self.animationView.layer.add(basicAnimation, forKey: "basic")

        } else if self.model!.animationName == "弹性动画-缩放" {

            let springAnimation = LLJAnimation.springAnimation(keyPath: "bounds", fromValue: nil, toValue: CGRect(x: 0, y: 0, width: self.animationView.bounds.size.width + 50, height: self.animationView.bounds.size.height + 50), byValue: nil, duration: 5.0, damping: 10.0, stiffness: 1000.0, mass: 10, fillMode: CAMediaTimingFillMode.both, initialVelocity: 0,removedOnCompletion: false)
            self.animationView.layer.add(springAnimation, forKey: "basic")

        } else if self.model!.animationName == "弹性动画-平移" {

            let springAnimation = LLJAnimation.springAnimation(keyPath: "position.x", fromValue: 0, toValue: self.drawView.bounds.size.width - self.animationView.center.x, byValue: -self.drawView.bounds.size.width, duration: 5.0, damping: 2.0, stiffness: 100.0, mass: 1, fillMode: CAMediaTimingFillMode.both, initialVelocity: 0,removedOnCompletion: false)
            self.animationView.layer.add(springAnimation, forKey: "basic")

        } else if self.model!.animationName == "弹性动画-旋转" {

            let springAnimation = LLJAnimation.springAnimation(keyPath: "transform.rotation.z", fromValue: LLJSHelper.getPrintsByAngle(angle: -60), toValue: LLJSHelper.getPrintsByAngle(angle: 0), byValue: LLJSHelper.getPrintsByAngle(angle: 60), duration: 5.0, damping: 2.0, stiffness: 100.0, mass: 1, fillMode: CAMediaTimingFillMode.forwards, initialVelocity: 10,removedOnCompletion: false)
            self.animationView.layer.add(springAnimation, forKey: "basic")

        } else if self.model!.animationName == "粒子发射-烟花" {

            if self.subLayer == nil {
                self.subLayer = LLJLayer.fireworkLayer(superView: self.drawView)
                self.subLayer?.lifetime = 0.0
            }
            
            if !sender.isSelected {
                LLJSHelper.countDown(timeInterval: 1, totalTime: 4) { (timer, time) in
                    LLJLog(time)
                    if time < 3 {
                        self.subLayer?.lifetime = 1.0
                    }
                } completeHandler: {
                }

            } else {
                self.subLayer?.lifetime = 0
            }
            sender.isSelected = !sender.isSelected

        } else if self.model!.animationName == "粒子发射-雪花" {

            if self.subLayer == nil {
                self.subLayer = LLJLayer.snowLayer(superView: self.drawView)
                self.subLayer?.lifetime = 0.0
            }
            
            if !sender.isSelected {
                LLJSHelper.countDown(timeInterval: 0.5, totalTime: 3) { (timer, time) in
                    LLJLog(time)
                    if time < 2.5 {
                        self.subLayer?.lifetime = 1.0
                    }
                } completeHandler: {
                }

            } else {
                self.subLayer?.lifetime = 0.0;
            }
            sender.isSelected = !sender.isSelected

        } else if self.model!.animationName == "粒子发射-细雨" {

            self.subLayer?.removeFromSuperlayer()
            if !sender.isSelected {
                self.subLayer = LLJLayer.rainLayer(superView: self.drawView)
            }
            sender.isSelected = !sender.isSelected
            
        } else if self.model!.animationName == "粒子发射-点赞" {
            
            if self.subLayer == nil {
                self.subLayer = LLJLayer.zanLayer(superView: self.drawView)
                self.subLayer?.lifetime = 0.0
            }
            
            //通过修改粒子生命周期来控制发射与否
            if !sender.isSelected {
                LLJSHelper.countDown(timeInterval: 0.5, totalTime: 3) { (timer, time) in
                    LLJLog(time)
                    if time < 2.5 {
                        self.subLayer?.lifetime = 1.0
                    }
                    if time < 1 {
                        self.subLayer?.lifetime = 0.0
                    }
                } completeHandler: {
                }

            } else {
                self.subLayer?.lifetime = 0.0;
            }
            sender.isSelected = !sender.isSelected
        } else if self.model!.animationName == "移动动画-椭圆" {
            
            //view按path移动动画
            let path = LLJBezierPath.drawCyle(arcCenter: self.drawView.center, radius: 40, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi*3/2, clockwise: true)
            let keyAnimation = LLJAnimation.keyframeAnimation(keyPath: "position", values: nil, path: path.cgPath, keyTimes: nil, duration: 10, timingFunctions: nil, fillMode: nil, removedOnCompletion: false)
            self.subAnimationView.layer.add(keyAnimation, forKey: "keyAnimation")
            
            //画路径动画
            self.drawLayer = CAShapeLayer()
            self.drawView.layer.addSublayer(self.drawLayer!)
            
            //第一段路径
            let path1 = LLJBezierPath.drawCyle(arcCenter: self.drawView.center, radius: 40, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi/2, clockwise: true)
            let layer1 = LLJLayer.shapeLayer(path: path1, strokeStart: 0, strokeEnd: 1, lineWidth: 2.0, strokeColor: UIColor.red, fillColor: nil, lineDashPattern: nil)
            layer1.path = path1.cgPath

            //第二段路径
            let path2 = LLJBezierPath.drawCyle(arcCenter: self.drawView.center, radius: 40, startAngle: CGFloat.pi/2, endAngle: CGFloat.pi*3/2, clockwise: true)
            let layer2 = LLJLayer.shapeLayer(path: path2, strokeStart: 0, strokeEnd: 1, lineWidth: 2.0, strokeColor: UIColor.orange, fillColor: nil, lineDashPattern: nil)
            
            //添加路径
            self.drawLayer!.addSublayer(layer1)
            self.drawLayer!.addSublayer(layer2)
            
            //maskLayer
            let path3 = LLJBezierPath.drawCyle(arcCenter: self.drawView.center, radius: 40, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi*3/2, clockwise: true)
            let animationlayer = LLJLayer.shapeLayer(path: path3, strokeStart: 0, strokeEnd: 1, lineWidth: 2.0, strokeColor: UIColor.black, fillColor: nil, lineDashPattern: nil)
            self.drawLayer!.mask = animationlayer

            let animation = LLJAnimation.basicAnimation(keyPath: "strokeEnd", beginTime: nil, fromValue: 0, toValue: 1, byValue: nil, duration: 10, timingFunctionName: nil, repeatCount: nil, repeatDuration: nil, fillMode: nil, autoreverses: false, removedOnCompletion: false)
            animationlayer.add(animation, forKey: "cycleAnimation")

        } else if self.model!.animationName == "移动动画-正弦" {
            
            //view按path移动动画
            var addLines = [CGPoint]()
            var x: CGFloat = 0.0
            for _ in stride(from: 0, to: 200, by: 1) {
                x = x + CGFloat.pi/100.0
                addLines.append(CGPoint(x: 20+15*x, y: 70+30*sin(x)))
            }
            
            let path = UIBezierPath()
            let startPoint: CGPoint = addLines.first!
            path.move(to: startPoint)
            for item in addLines {
                path.addLine(to: item)
            }
            
            let keyAnimation = LLJAnimation.keyframeAnimation(keyPath: "position", values: nil, path: path.cgPath, keyTimes: nil, duration: 10, timingFunctions: nil, fillMode: CAMediaTimingFillMode.forwards, removedOnCompletion: false)
            self.subAnimationView.layer.add(keyAnimation, forKey: "keyAnimation")
            
            //画路径动画
            self.drawLayer = CAShapeLayer()
            self.drawView.layer.addSublayer(self.drawLayer!)
            
            LLJDrawRect.drawSin(addLines: addLines, lineWidth: 1.0, strokeColor: UIColor.red, lineDashPattern: [4,2], superLayer: self.drawLayer!)
            
            //maskLayer
            let animationlayer = LLJLayer.shapeLayer(path: path, strokeStart: 0, strokeEnd: 1, lineWidth: 2.0, strokeColor: UIColor.black, fillColor: nil, lineDashPattern: nil)
            self.drawLayer!.mask = animationlayer

            let animation = LLJAnimation.basicAnimation(keyPath: "strokeEnd", beginTime: nil, fromValue: 0, toValue: 1, byValue: nil, duration: 10, timingFunctionName: nil, repeatCount: nil, repeatDuration: nil, fillMode: nil, autoreverses: false, removedOnCompletion: false)
            animationlayer.add(animation, forKey: "cycleAnimation")

        } else if self.model!.animationName == "移动动画-帧动画" {
            
            //view按path移动动画
            let colorArray = [UIColor.blue.cgColor,UIColor.red.cgColor,UIColor.yellow.cgColor,UIColor.orange.cgColor]
            let keyAnimation = LLJAnimation.keyframeAnimation(keyPath: "backgroundColor", values: colorArray, path: nil, keyTimes: nil, duration: 2.0, timingFunctions: nil, fillMode: CAMediaTimingFillMode.forwards, removedOnCompletion: false)
            self.subAnimationView.layer.add(keyAnimation, forKey: "keyAnimation")
        }
    }
}
