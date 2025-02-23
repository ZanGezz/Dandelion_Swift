//
//  LLJSMainViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2020/12/18.
//

import UIKit

class LLJSMainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //获取本地数据
        getLocalTxtSource()
        //设置UI
        setUpUI()
    }
    
    //MARK:懒加载属性
    private lazy var mTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - LLJTabBarHeight), style: UITableView.Style.plain)
        tableView.register(LLJSMainCell.self, forCellReuseIdentifier: "MainCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        return tableView
    }()
    //数据数组
    var sourceArray : NSArray?
}

//MARK: - UITableViewDelegate -
extension LLJSMainViewController: UITableViewDelegate, UITableViewDataSource {
        
    //UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceArray!.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LLJDX(80);
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell") as! LLJSMainCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setDataSource(self.sourceArray!.object(at: indexPath.row) as! String)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sub = (self.sourceArray!.object(at: indexPath.row) as! NSString).components(separatedBy: ":")
        let viewController: LLJFViewController? = LLJSHelper.getClassFromString(sub.last!)
        if viewController != nil {
            viewController!.titleName = sub.first!
            if sub.last! == "LLJWChatMainViewController" || sub.last! == "LLJFWeChatCycleController" || sub.last! == "LLJVideoController" {
                viewController!.hiddenNavgationBarWhenPushIn = true
            }
            //viewController?.addTransitionAinamition(animationType: .CurlDown, pushType: .push, duration: 0.35)
            if (sub.last! == "LLJVideoController") {
                viewController!.presentFullfullScreen()
                self.present(viewController!, animated: true)
            } else {
                self.navigationController?.pushViewController(viewController!, animated: true)
            }
            //let _ = LLJTransition.init(add: .CurlDown, pushType: .dismiss, duration: 0.35, destinationContrller: viewController!)
            //self.present(viewController!, animated: true, completion: nil)
        }
    }
}

//MARK:设置UI + 布局
extension LLJSMainViewController {
    
    //获取本地数据
    private func getLocalTxtSource() {
        //获取本地数据
        let path = Bundle.main.path(forResource: "LLJMainSource", ofType: "txt")
        self.sourceArray = LLJSHelper.getLocalSource(path: path!) as? NSArray
    }
    //设置UI
    private func setUpUI() {
        
        //背景色
        self.view.backgroundColor = LLJWhiteColor()
        //添加TableView
        self.view.addSubview(self.mTableView)
        //设置导航条
        let naviController = self.navigationController as! LLJNaviController
        naviController.statusBarStyle = .lightContent
        //网络请求
        //loadData()
    }
    //网络请求
    private func loadData() {
        
        LLJNetHelper.loadData(target: LLJMainReq.mainList, model: LLJMainModel.self) { (decode) in
            
        } failure: { (int, string) in
            
        }
    }
}
