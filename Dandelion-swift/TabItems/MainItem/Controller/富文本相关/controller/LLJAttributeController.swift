//
//  ViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/8/11.
//

import UIKit

class LLJAttributeController: LLJFViewController {

    lazy var textLabel: LJLabel = {
        let textLabel = LJLabel()
        textLabel.font = LLJFont(14)
        textLabel.numberOfLines = 0
        textLabel.frame = CGRect(x: 20, y: 300, width: 300, height: 60)
        return textLabel
    }()
    
    var action: Action?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

extension LLJAttributeController {
    
    func setUpUI() {
        
        self.view.backgroundColor = LLJWhiteColor()
        self.view.addSubview(self.textLabel)
        
        setCallBack()
        
        let text: String = "我们都是好孩子，异想天开的孩子！我们都是好孩子，异想天开的孩子！"
        let model = AttributeModel()
        model.content = text
        model.attributeContent = ["孩子","我们"]
        model.bindObject = UIColor.red
        model.attributeKeys = [.font(LLJFont(18)),.foregroundColor(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))]
        model.ranges = [NSRange(location: 5, length: 2)]
        model.action = self.action
        var attr = LLJAttributeString(content: text)
        attr.addAttribute(model: model)
        
        self.textLabel.attribute = attr
    }
    
    //点击事件
    func setCallBack() {
        let action = Action { (result) in
            LLJLog(result.content)
            LLJLog(result.range)
            LLJLog(result.bindObject as Any)
        }
        self.action = action
    }
}
