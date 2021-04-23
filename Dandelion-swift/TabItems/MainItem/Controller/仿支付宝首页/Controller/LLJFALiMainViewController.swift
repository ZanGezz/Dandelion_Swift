//
//  LLJFALiMainViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/4/13.
//

import UIKit

class LLJFALiMainViewController: LLJFViewController {

    //数据
    var dataArray: [[String]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI
        setUpUI()
    }
}

//MARK: - UI + 布局 -
extension LLJFALiMainViewController {
    //UI
    private func setUpUI() {
        //tableVeiw
        self.title = "TableView组切圆角"
        self.view.backgroundColor = LLJWhiteColor()
        self.view.addSubview(self.myTableView)
        self.myTableView.frame = CGRect(x: 0, y: LLJTopHeight, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - LLJTopHeight)
        
        self.dataArray = [["甲","乙","丙","丁","哈"],["甲","乙","丙","丁","哈"],["甲","乙","丙","丁","哈"],["甲","乙","丙","丁","哈"],["甲","乙","丙","丁","哈"]]
    }
}

//MARK: - TableViewDelegate -
extension LLJFALiMainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let mainCell = cell as! LLJSMainCell
        let subArray = self.dataArray![indexPath.section]
        mainCell.setDataSource(subArray[indexPath.row])
    }
}

//MARK: - TableViewDataSource -
extension LLJFALiMainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "LLJMainCell")
        if cell == nil {
            cell = LLJSMainCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "LLJMainCell")
            cell!.selectionStyle = UITableViewCell.SelectionStyle.none
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
