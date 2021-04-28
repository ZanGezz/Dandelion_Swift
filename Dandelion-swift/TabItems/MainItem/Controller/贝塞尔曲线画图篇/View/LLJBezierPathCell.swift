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
            LLJDrawRect.drawCyle(rect: model.rect!,lineWidth: model.lineWidth!,strokColor:model.strokeColor,fillColor: model.fillColor,superView: self.drawView);

        } else if model.title == "圆一" {
            //画椭圆
            //LLJDrawRect.drawCyle(lineWidth: model.lineWidth, strokColor: model.strokeColor, fillColor: model.fillColor, backColor: nil, arcCenter: <#T##CGPoint#>, radius: <#T##CGFloat#>, startAngle: <#T##CGFloat#>, endAngle: <#T##CGFloat#>, clockwise: <#T##Bool#>, superView: <#T##UIView#>);

        } else if model.title == "椭圆" {
            //画椭圆
            LLJDrawRect.drawCyle(rect: model.rect!,lineWidth: model.lineWidth!,strokColor:model.strokeColor,fillColor: model.fillColor,superView: self.drawView);

        } else if model.title == "多边形" {

            //画多边形
            LLJDrawRect.drawPolygon(pointArray: model.pointArray!, closePath: model.closePath!, lineWidth: model.lineWidth!, strokColor: model.strokeColor, fillColor: model.fillColor, superView: self.drawView)
            
        } else if model.title == "折线" {

            //画折线图
            LLJDrawRect.drawPolygon(pointArray: model.pointArray!, closePath: model.closePath!, lineWidth: model.lineWidth!, strokColor: model.strokeColor, fillColor: model.fillColor, superView: self.drawView)
        }
    }
}
