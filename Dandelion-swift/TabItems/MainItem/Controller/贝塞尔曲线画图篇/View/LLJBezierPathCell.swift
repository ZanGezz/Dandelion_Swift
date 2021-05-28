//
//  LLJBezierPathCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/4/19.
//

import UIKit

class LLJBezierPathCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = LLJFont(14)
        titleLabel.textColor = LLJPurpleColor()
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
    
    var model: LLJBezierPathModel?
    
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

//MARK: - UI -
extension LLJBezierPathCell {
    
    //UI
    func setUpUI() {
        
        self.contentView.backgroundColor = LLJWhiteColor()
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_left)
            make.right.equalTo(self.contentView.snp_right)
            make.top.equalTo(self.contentView.snp_top).offset(10)
            make.height.equalTo(15)
        }
        
        self.contentView.addSubview(self.titleButton)
        self.titleButton.snp_makeConstraints { (make) in
            make.edges.equalTo(self.titleLabel)
        }
        
        self.contentView.addSubview(self.drawView)
        self.drawView.frame = CGRect(x: (self.contentView.frame.size.width - self.contentView.frame.size.height + 50)/2 , y: 50, width: self.contentView.frame.size.height - 50, height: self.contentView.frame.size.height - 50)
        
        self.contentView.layoutIfNeeded()
    }
    
    //按钮事件
    @objc func buttonClick(sender: UIButton) {
        self.model?.fillColor = UIColor.red
        setDataSource(model: self.model!)
    }
}

//设置数据
extension LLJBezierPathCell {
    
    func setDataSource(model: LLJBezierPathModel) {
        
        self.model = model
        
        self.titleLabel.text = model.title
        
        //移除子图层
        self.drawView.layer.sublayers?.removeAll()
        
        if model.title == "圆" {
            //画圆
            LLJDrawRect.drawCyle(rect: CGRect(x: 10, y: 10, width: 80, height: 80),lineWidth: model.lineWidth!,strokColor:model.strokeColor,fillColor: nil, lineDashPattern: nil, superLayer: self.drawView.layer);

        } else if model.title == "圆(一)" {
            //画椭圆
            LLJDrawRect.drawCyle(lineWidth: 2.0, strokColor: UIColor.brown, fillColor: nil, backColor: nil, arcCenter: CGPoint(x: 50, y: 50), radius: 40, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true, lineDashPattern: nil, superLayer: self.drawView.layer, animation: nil)

        } else if model.title == "椭圆" {
            //画椭圆
            LLJDrawRect.drawCyle(rect: CGRect(x: 10, y: 10, width: 80, height: 60),lineWidth: model.lineWidth!,strokColor:model.strokeColor,fillColor: nil,lineDashPattern: nil, superLayer: self.drawView.layer);

        } else if model.title == "多边形" {

            //画多边形
            LLJDrawRect.drawPolygon(pointArray: model.pointArray!, closePath: model.closePath!, lineWidth: model.lineWidth!, strokColor: model.strokeColor, fillColor: nil, lineDashPattern: nil, superLayer: self.drawView.layer)
            
        } else if model.title == "折线" {

            //画折线图
            LLJDrawRect.drawPolygon(pointArray: model.pointArray!, closePath: model.closePath!, lineWidth: model.lineWidth!, strokColor: model.strokeColor, fillColor: nil, lineDashPattern: nil, superLayer: self.drawView.layer)
        } else if model.title == "矩形" {
            
            //画矩形
            LLJDrawRect.drawRoundedRect(rect: CGRect(x: 10, y: 10, width: 80, height: 80), lineWidth: 1, strokColor: UIColor.red, fillColor: nil, lineDashPattern: nil, superLayer: self.drawView.layer)
        } else if model.title == "虚线" {
            
            //画虚线
            LLJDrawRect.drawRoundedRect(rect: CGRect(x: 10, y: 10, width: 80, height: 80), lineWidth: 1, strokColor: UIColor.red, fillColor: nil, lineDashPattern: [8,4], superLayer: self.drawView.layer)
        } else if model.title == "切圆角" {
            
            //切圆角
            LLJDrawRect.drawRoundedRect(rect: CGRect(x: 10, y: 10, width: 80, height: 80), byRoundingCorners: [UIRectCorner.topLeft,UIRectCorner.topRight,UIRectCorner.bottomRight,UIRectCorner.bottomLeft], cornerRadius: [10,4,20,8], lineWidth: 2.0, strokColor: UIColor.red, fillColor: UIColor.yellow, lineDashPattern: nil, superLayer: self.drawView.layer)
        } else if model.title == "单曲线" {
            
            //单曲线
            LLJDrawRect.drawQuadCurve(startPoint: CGPoint(x: 0, y: 50), endPoint: CGPoint(x: 90, y: 50), controlPoint: CGPoint(x: 80, y: 0), lineWidth: 1.0, strokColor: UIColor.red, lineDashPattern: [4,2], superLayer: self.drawView.layer)
            
        } else if model.title == "双曲线" {
            
            let endArray = [CGPoint(x: 40, y: 50),CGPoint(x: 80, y: 50)]
            
            let controlArray = [[CGPoint(x: 10, y: 10),CGPoint(x: 30, y: 90)],[CGPoint(x: 50, y: 10),CGPoint(x: 70, y: 90)]]
            
            //双曲线
            LLJDrawRect.drawCurve(startPoint: CGPoint(x: 0, y: 50), endPoints: endArray, controlPoints: controlArray, lineWidth: 1.0, strokColor: UIColor.red, lineDashPattern: nil, superLayer: self.drawView.layer)
            
        } else if model.title == "正弦曲线" {
            
            //生成正弦曲线的点集合
            var addLines = [CGPoint]()
            var x: CGFloat = 0.0
            for _ in stride(from: 0, to: 200, by: 1) {
                x = x + CGFloat.pi/100.0
                addLines.append(CGPoint(x: 10+10*x, y: 40+20*sin(x)))
            }
            
            LLJDrawRect.drawSin(addLines: addLines, lineWidth: 1.0, strokeColor: UIColor.red, lineDashPattern: [4,2], superLayer: self.drawView.layer)
            
        } else if model.title == "正切函数" {
            
            var addLines = [CGPoint]()
            var x: CGFloat = -CGFloat.pi/2 + 0.1
            for _ in stride(from: 0, to: 1000, by: 1) {
                x = x + (CGFloat.pi - 0.2)/1000
                addLines.append(CGPoint(x: 40+15*x, y: 40 - 5*tan(x)))
            }
            
            LLJDrawRect.drawSin(addLines: addLines, lineWidth: 1.0, strokeColor: UIColor.red, lineDashPattern: [4,2], superLayer: self.drawView.layer)
        }
    }
}
