//
//  LLJLunBoListViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/6/17.
//

import UIKit

class LLJLunBoListViewController: LLJFViewController {

    //MARK:懒加载属性
    private lazy var tableView: LLJTableView = {
        let tableView = LLJTableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - LLJTopHeight), style: UITableView.Style.plain)
        tableView.register(LLJSMainCell.self, forCellReuseIdentifier: "MainCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    //数据数组
    var sourceArray : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }

}

//MARK: - UI -
extension LLJLunBoListViewController {
    
    private func setUpUI() {
        
        sourceArray = ["正常轮播","缩放轮播","折叠样式","向上轮播","向下轮播","向左轮播","向右轮播","图片","自定义View"]
        
        self.view.addSubview(self.tableView)
    }
}

//MARK: - UITableViewDelegate -
extension LLJLunBoListViewController: UITableViewDelegate, UITableViewDataSource {
        
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
        cell.setDataSource(self.sourceArray![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let style = self.sourceArray![indexPath.row]
        let controller = LLJLunBoViewController()
        controller.name = style
        switch style {
        case "正常轮播":
            controller.mapViewStyle = .commen
            controller.contentViewStyle = .image
            controller.rollDirection = .right
        case "缩放轮播":
            controller.mapViewStyle = .zoom
            controller.contentViewStyle = .custom
            controller.rollDirection = .right
        case "折叠样式":
            controller.mapViewStyle = .fold
            controller.contentViewStyle = .image
            controller.rollDirection = .right
        case "向上轮播":
            controller.mapViewStyle = .zoom
            controller.contentViewStyle = .custom
            controller.rollDirection = .top
        case "向左轮播":
            controller.mapViewStyle = .zoom
            controller.contentViewStyle = .custom
            controller.rollDirection = .left
        case "向下轮播":
            controller.mapViewStyle = .zoom
            controller.contentViewStyle = .image
            controller.rollDirection = .bottom
        case "向右轮播":
            controller.mapViewStyle = .zoom
            controller.contentViewStyle = .custom
            controller.rollDirection = .right
        case "图片":
            controller.mapViewStyle = .commen
            controller.contentViewStyle = .image
            controller.rollDirection = .right
        case "自定义View":
            controller.mapViewStyle = .zoom
            controller.contentViewStyle = .custom
            controller.rollDirection = .right
        default:break
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
