//
//  LLJSTableViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/2/2.
//

import UIKit

class LLJSTableViewController: LLJFViewController {

    //数据数组
    var sourceArray: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setUpUI()
    }
}

//MARK:基础设置
extension LLJSTableViewController {
    
    //设置UI
    func setUpUI() {
        
        //获取数据
        self.sourceArray = LLJSCoreDataHelper.helper.getRosource(entityName: "LLJSCommenModel", predicate: "name = 'ZanGezz'") as NSArray
        //tableview
        self.myTableView.register(LLJSMainCell.self, forCellReuseIdentifier: "MainCell")
        self.myTableView.frame = self.view.bounds
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.view.addSubview(self.myTableView)
    }
}

//MARK:代理
extension LLJSTableViewController: UITableViewDelegate,UITableViewDataSource {
    
    //代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell") as! LLJSMainCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let model = self.sourceArray.object(at: indexPath.row) as! LLJSCommenModel
        cell.setDataSource(model.name! + model.sex! + model.age!)
        return cell
    }
}
