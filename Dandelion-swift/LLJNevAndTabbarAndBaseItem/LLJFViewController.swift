//
//  LLJFViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/1/18.
//

import UIKit

class LLJFViewController: UIViewController {
    
    /*
     * 禁止左滑返回默认 不禁止 可以返回
     */
    var forbidGesturePopViewController: Bool = false
    /*
     * 进入页面隐藏状态栏 默认不隐藏
     */
    var hiddenStatusBarWhenPushIn: Bool = false
    /*
     * 进入页面隐藏导航栏 默认不隐藏
     */
    var hiddenNavgationBarWhenPushIn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setUpUI()
    }
}

extension LLJFViewController {
        
    //设置按钮
    private func setUpUI() {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage.init(named: "back_white"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(buttonClick(_ :)), for: UIControl.Event.touchUpInside)
        let leftItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    //按钮事件
    @objc private func buttonClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    //返回按钮触发事件(在子类重写该方法触发事件)
    func backAction() {
        LLJLog("点击了返回")
    }
}
