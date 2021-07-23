//
//  LLJMineViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/1/21.
//

import UIKit

class LLJMineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //获取本地数据
        getLocalTxtSource()
        //设置UI
        setUpUI()
    }
    
    //MARK:懒加载属性
    private lazy var myTableView: UITableView = {
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
    //数据数组
    var sourceArray: NSArray?
}

//MARK: - UITableViewDelegate -
extension LLJMineViewController: UITableViewDelegate, UITableViewDataSource {
        
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
        cell.setDataSource((self.sourceArray!.object(at: indexPath.row) as! Array<Any>).first as! String)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = LLJWebViewController()
        controller.webUrlString = (self.sourceArray!.object(at: indexPath.row) as! Array<Any>).last as! String
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK:设置UI + 布局
extension LLJMineViewController {
    
    //获取本地数据
    private func getLocalTxtSource() {
        //获取本地数据
        let path = Bundle.main.path(forResource: "LLJMyKnowledge", ofType: "txt")
        let local = LLJSHelper.getLocalSource(path: path!) as! Array<Any>
        var subArray: [Any] = Array()
        for sub in local {
            let sep = (sub as! NSString).components(separatedBy: "-")
            subArray.append(sep)
        }
        self.sourceArray = subArray as NSArray?
    }
    //设置UI
    private func setUpUI() {
        //背景色
        self.view.backgroundColor = LLJWhiteColor()
        //添加TableView
        self.view.addSubview(self.myTableView)
    }
}
