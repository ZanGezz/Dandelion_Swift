//
//  LLJSCoreDataController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/1/20.
//

import UIKit

class LLJSCoreDataController: LLJFViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setUpUI()
    }
    
    //在extension中可以添加新函数，但是不能override一个已有的函数
    override func backAction() {
        LLJLog("点击了返回。。。")
    }
}

extension LLJSCoreDataController {
    //设置UI
    func setUpUI() {
        
        self.view.backgroundColor = LLJWhiteColor()
        //增加
        var button = LLJSUIKitHelper.LLJButton(title: "增加", titleColor: LLJBlackColor(), backGroundColor: LLJPurpleColor(), titleFont: LLJFont(18), frame: CGRect(x: 100, y: 200, width: 80, height: 40))
        button = LLJSUIKitHelper.LLJCView(subView: button, cornerRadius: 4.0, shadowColor: nil, shadowOffset: nil, shadowOpacity: nil, shadowRadius: nil) as! UIButton
        button.tag = 10001
        button.addTarget(self, action: #selector(buttonClick(sender:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button)
        
        //删除
        var button1 = LLJSUIKitHelper.LLJButton(title: "删除", titleColor: LLJBlackColor(), backGroundColor: LLJPurpleColor(), titleFont: LLJFont(18), frame: CGRect(x: 100, y: 300, width: 80, height: 40))
        button1 = LLJSUIKitHelper.LLJCView(subView: button1, cornerRadius: 4.0, shadowColor: nil, shadowOffset: nil, shadowOpacity: nil, shadowRadius: nil) as! UIButton
        button1.tag = 10002
        button1.addTarget(self, action: #selector(buttonClick(sender:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button1)
        
        //修改
        var button2 = LLJSUIKitHelper.LLJButton(title: "修改", titleColor: LLJBlackColor(), backGroundColor: LLJPurpleColor(), titleFont: LLJFont(18), frame: CGRect(x: 280, y: 200, width: 80, height: 40))
        button2 = LLJSUIKitHelper.LLJCView(subView: button2, cornerRadius: 4.0, shadowColor: nil, shadowOffset: nil, shadowOpacity: nil, shadowRadius: nil) as! UIButton
        button2.tag = 10003
        button2.addTarget(self, action: #selector(buttonClick(sender:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button2)
        
        //查询
        var button3 = LLJSUIKitHelper.LLJButton(title: "查询", titleColor: LLJBlackColor(), backGroundColor: LLJPurpleColor(), titleFont: LLJFont(18), frame: CGRect(x: 280, y: 300, width: 80, height: 40))
        button3 = LLJSUIKitHelper.LLJCView(subView: button3, cornerRadius: 4.0, shadowColor: nil, shadowOffset: nil, shadowOpacity: nil, shadowRadius: nil) as! UIButton
        button3.tag = 10004
        button3.addTarget(self, action: #selector(buttonClick(sender:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button3)
        
    }
    
    //按钮事件
    @objc private func buttonClick(sender: UIButton) {
        
        let countSring = (LLJSCoreDataHelper.helper.getRosource(entityName: "LLJSCommenModel", predicate: "name = 'ZanGezz'")).count

        switch sender.tag {
            case 10001:
                let model = LLJSCoreDataHelper.helper.createCoreDataModel(entityName: "LLJSCommenModel") as! LLJSCommenModel
                model.name = "ZanGezz"
                model.age  = String(20 + countSring)
                model.sex  = "男"
                LLJSCoreDataHelper.helper.insertRosource()
            case 10002:
                LLJSCoreDataHelper.helper.deleteRosource(entityName: "LLJSCommenModel", predicate: "sex = '男'")
            case 10003:
                let model = LLJSCoreDataHelper.helper.getModel(entityName: "LLJSCommenModel", predicate: "age = '22'") as! LLJSCommenModel
                model.sex = "女"
                LLJSCoreDataHelper.helper.updateRosource()
            case 10004:
                let array = LLJSCoreDataHelper.helper.getRosource(entityName: "LLJSCommenModel", predicate: "sex = '男'")
                LLJLog(array)
            default: break
        }
    }
}
