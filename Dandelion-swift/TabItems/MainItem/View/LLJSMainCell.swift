//
//  LLJSMainCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/1/13.
//

import UIKit
import SnapKit

class LLJSMainCell: UITableViewCell {

    //标题
    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = LLJCommenColor()
        titleLabel.font = LLJFont(16)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = NSTextAlignment.left
        return titleLabel
    }()
    //跳转箭头
    private lazy var indictor: UIImageView = {
        let indictor = UIImageView(image: UIImage(named: "wode_next"))
        return indictor
    }()
    private lazy var lineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = LLJColor(238, 238, 238, 1)
        return lineView
    }()
    
    //初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
extension LLJSMainCell {
    
    //添加子视图
    private func setUpUI() {
        //添加
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.indictor)
        self.contentView.addSubview(self.lineView)
        //布局
        layoutSubview()
    }
    //布局子视图
    private func layoutSubview() {
        //箭头
        self.indictor.snp_makeConstraints { (make) in
            make.right.equalTo(contentView.snp_right).offset(-Cell_OffSet_right)
            make.centerY.equalTo(contentView.snp_centerY)
        }
        //标题
        self.titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(contentView.snp_left).offset(Cell_OffSet_left);
            make.centerY.equalTo(contentView.snp_centerY)
            make.right.equalTo(self.indictor.snp_left).offset(-Cell_OffSet_right)
        }
        //箭头
        self.lineView.snp_makeConstraints { (make) in
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.bottom.equalTo(contentView.snp_bottom)
            make.height.equalTo(1.0)
        }
    }
    
    //赋值
    func setDataSource(_ title: String) {
        self.titleLabel.text = title;
    }
}
