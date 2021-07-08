//
//  LLJFWeChatCycleController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/6/22.
//

import UIKit

class LLJFWeChatCycleController: LLJFViewController {
    
    //懒加载
    //MARK:懒加载属性
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - LLJTabBarHeight - LLJTopHeight), style: UITableView.Style.plain)
        tableView.register(LLJSMainCell.self, forCellReuseIdentifier: "MainCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //UI
        setUpUI()
    }
}

//MARK: - UI -
extension LLJFWeChatCycleController {
   
    //UI
    private func setUpUI() {
        
        self.view.backgroundColor = LLJWhiteColor()
        
    }
}

//MARK: - 代理 -
extension LLJFWeChatCycleController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
