//
//  LLJBaseCell.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/1/13.
//

import UIKit

class LLJBaseCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    /*自定义这个叫必要初始化器，这种情况一般会出现在继承了遵守NSCoding protocol的类，比如UIView系列的类、UIViewController
     系列的类。什么情况下要显示添加：当我们在子类定义了指定初始化器(包括自定义和重写父类指定初始化器)，那么必须显示实现
     required init?(coder aDecoder: NSCoder)，而其他情况下则会隐式继承，我们可以不用理会。*/
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
