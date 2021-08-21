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
        var attr = LJTextString(content: text)
        attr.add(searchContents: ["孩子","我们"], searchRanges: [NSRange(location: 5, length: 2)], attributeKeys: [.font(LLJFont(18)),.foreground(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))], highLightKeys: [.background(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))], action: self.action, bindObject: 10010101)
        
        self.textLabel.attribute = attr
    }
    
    //点击事件
    func setCallBack() {
        let action = Action(tigger: .click, callBack: { result in
            
        })
        self.action = action
    }
}
