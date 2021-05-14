//
//  LLJFALiMainViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/4/13.
//

import UIKit

class LLJWChatMainViewController: LLJFViewController {

    //数据
    var dataArray: [[String]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI
        setUpUI()
    }
}

//MARK: - UI + 布局 -
extension LLJWChatMainViewController {
    //UI
    private func setUpUI() {
        //tableVeiw
        self.title = "TableView组切圆角"
        self.view.backgroundColor = LLJColor(238, 238, 238, 1)
        self.view.addSubview(self.myTableView)
        self.myTableView.backgroundColor = LLJColor(238, 238, 238, 1)
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - LLJTopHeight)
        
        self.dataArray = [["甲","乙","丙","丁","哈"],["甲","乙","丙","丁","哈"],["甲","乙","丙","丁","哈"],["甲","乙","丙","丁","哈"],["甲","乙","丙","丁","哈"]]
    }
}

//MARK: - TableViewDelegate -
extension LLJWChatMainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let mainCell = cell as! LLJSMainCell
        let subArray = self.dataArray![indexPath.section]
        mainCell.setDataSource(subArray[indexPath.row])
        
        //组切圆角
        //方法一 判断第一个cell, 切出左上和又上圆角, 最后一个cell, 切出左下和右下圆角
        //方法二 使用带圆角的图片模拟
        if indexPath.row == 0 {
            LLJSUIKitHelper.LLJCView(subView: cell, cornerRadius: [20,20,0,0])
        } else if (indexPath.row == subArray.count - 1) {
            LLJSUIKitHelper.LLJCView(subView: cell, cornerRadius: [0,0,20,20])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

//MARK: - TableViewDataSource -
extension LLJWChatMainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "LLJMainCell")
        if cell == nil {
            cell = LLJSMainCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "LLJMainCell")
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LLJDX(80)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
}
