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
    /*
     * 标题title
     */
    var titleName: String = ""
    
    /*
     * 状态栏样式
     */
    var _statusBarStyle: UIStatusBarStyle = .default
    
    /*
     * 状态栏动画
     */
    var statusBarAnimation: UIStatusBarAnimation = .none
    
    lazy var myTableView: LLJTableView = {
        let tableView = LLJTableView(frame: CGRect.zero, style: UITableView.Style.plain)
        return tableView
    }()
    
    //重写init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        //隐藏tabbar
        self.hidesBottomBarWhenPushed = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //设置代理
        self.navigationController?.delegate = self;
    }
    
    /*
     * 状态栏样式
     */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return _statusBarStyle
    }
    
    /*
     * 状态栏动画
     */
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return statusBarAnimation
    }
    
    //返回按钮触发事件(在子类重写该方法触发事件)
    func backAction() {
        LLJLog("点击了返回")
    }
}

extension LLJFViewController {
        
    //设置按钮
    private func setUpUI() {
        //左侧返回按钮
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage.init(named: "back_white"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(backButtonClick(sender:)), for: UIControl.Event.touchUpInside)
        let leftItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftItem
        //标题
        self.title = self.titleName;
        //自适应安全区
        if #available(iOS 11.0, *) {
            self.myTableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        };
        //present 全屏
        self.modalPresentationStyle = UIModalPresentationStyle.fullScreen
    }
    //按钮事件
    @objc private func backButtonClick(sender: UIButton) {
        //pop返回
        self.navigationController?.popViewController(animated: true)
        //触发返回事件
        backAction()
    }
}

extension LLJFViewController: UINavigationControllerDelegate {
    //代理
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let hidden = self.isKind(of: viewController.classForCoder) && self.hiddenNavgationBarWhenPushIn
        self.navigationController?.setNavigationBarHidden(hidden, animated: true)
    }
}

//技术属性
extension LLJFViewController {
    //代理
    var statusBarStyle: UIStatusBarStyle {
        set {
            _statusBarStyle = newValue
            
            self.setNeedsStatusBarAppearanceUpdate()
        }
        get {
            return _statusBarStyle
        }
    }
}
