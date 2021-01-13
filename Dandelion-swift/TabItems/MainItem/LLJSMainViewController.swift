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
    private lazy var myTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.lightGray
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView .dequeueReusableCell(withIdentifier: "MainCell")
        if (cell == nil) {
            cell = LLJMainCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "MainCell")
        }
        return cell!
    }
}

//MARK:设置UI + 布局
extension LLJSMainViewController {
    
    //获取本地数据
    private func getLocalTxtSource() {
        //获取本地数据
        let path = Bundle.main.path(forResource: "LLJSMainViewController", ofType: "txt")
        self.sourceArray = LLJSHelper.getLocalSource(path: path!) as? NSArray
    }
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
