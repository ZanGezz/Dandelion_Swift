//
//  LLJSMainViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2020/12/18.
//

import UIKit

class LLJSMainViewController: UIViewController {

    private lazy var myTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: UITableView.Style.plain)
        tableView.backgroundColor = UIColor.lightGray
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setUpUI()
    }

}


//MARK:设置UI + 布局
extension LLJSMainViewController {
    
    //设置UI
    private func setUpUI() {
        //背景色
        self.view.backgroundColor = LLJWhiteColor()
        //添加TableView
        self.view.addSubview(self.myTableView)
    }
    //布局
    private func layoutSubView() {
        
    }
}
