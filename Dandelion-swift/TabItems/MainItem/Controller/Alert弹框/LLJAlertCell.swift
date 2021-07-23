//
//  LLJAlertCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/23.
//

import UIKit

enum AlertCellType {
    case commen
    case subTitle
}

class LLJAlertCell: UITableViewCell {
    
    //标题
    lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    //副标题
    lazy var subTitleLabel : UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.textColor = LLJColor(135, 135, 135, 1)
        subTitleLabel.font = LLJFont(12, "")
        return subTitleLabel
    }()
    lazy var lineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = LLJColor(241, 241, 241, 1)
        return lineView
    }()
    
    var type: AlertCellType = .commen
    
    //初始化
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, type: AlertCellType) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.type = type
        //添加子视图
        setUpUI()
    }
    
    /*自定义这个叫必要初始化器，这种情况一般会出现在继承了遵守NSCoding protocol的类，比如UIView系列的类、UIViewController
     系列的类。什么情况下要显示添加：当我们在子类定义了指定初始化器(包括自定义和重写父类指定初始化器)，那么必须显示实现
     required init?(coder aDecoder: NSCoder)，而其他情况下则会隐式继承，我们可以不用理会。*/
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:UI and 布局
extension LLJAlertCell {
    
    //添加子视图
    private func setUpUI() {
        
        //添加
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.subTitleLabel)
        self.contentView.addSubview(self.lineView)
        //布局
        layoutSubview()
    }
    //布局子视图
    private func layoutSubview() {
        
        if self.type == .commen {
            //标题
            self.titleLabel.snp_makeConstraints { (make) in
                make.centerX.equalTo(self.snp_centerX)
                make.centerY.equalTo(self.snp_centerY)
            }
        } else {
            //标题
            self.titleLabel.snp_makeConstraints { (make) in
                make.centerX.equalTo(self.snp_centerX)
                make.centerY.equalTo(self.snp_centerY).offset(-LLJDX(6))
                make.height.equalTo(LLJDX(19))
            }
            //副标题
            self.subTitleLabel.snp_makeConstraints { (make) in
                make.top.equalTo(self.titleLabel.snp_bottom).offset(LLJDX(6))
                make.centerX.equalTo(self.snp_centerX)
                make.height.equalTo(LLJDX(13))
            }
        }
        //底线
        self.lineView.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.bottom.equalTo(self.snp_bottom)
            make.height.equalTo(0.5)
        }
    }
    
    //赋值
    func setDataSource(model: LLJAlertModel) {
        self.titleLabel.text = model.title
        self.subTitleLabel.text = model.subTitle
    }
    
    func setCancelTitle(title: String) {
        self.titleLabel.text = title
    }
}
