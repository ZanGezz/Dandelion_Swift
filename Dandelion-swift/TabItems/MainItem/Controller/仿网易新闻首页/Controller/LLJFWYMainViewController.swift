//
//  LLJFWYMainViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/5/20.
//

import UIKit

class LLJFWYMainViewController: LLJFViewController {

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
extension LLJFWYMainViewController {
    
    private func setUpUI() {
        
        sourceArray = ["moveAnimationCycle","moveAnimationNone","moveAnimationLiner","moveAnimationCaseInOut","moveAnimationDragLiner","moveAnimationDragCaseInOut"]
        
        self.view.addSubview(self.tableView)
    }
}

//MARK: - UITableViewDelegate -
extension LLJFWYMainViewController: UITableViewDelegate, UITableViewDataSource {
        
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
        let controller = LLJFContentController()
        controller.name = style
        switch style {
        case "moveAnimationCycle":
            controller.style = .moveAnimationCycle
            controller.statusBarStyle = .lightContent
            controller.statusBarAnimation = .fade
        case "moveAnimationNone":
            controller.style = .moveAnimationNone
            controller.statusBarStyle = .default
            controller.statusBarAnimation = .none
        case "moveAnimationLiner":
            controller.style = .moveAnimationLiner
            controller.statusBarStyle = .lightContent
            controller.statusBarAnimation = .slide
        case "moveAnimationCaseInOut":
            controller.style = .moveAnimationCaseInOut
            if #available(iOS 13.0, *) {
                controller.statusBarStyle = .darkContent
            } else {
                // Fallback on earlier versions
            }
            controller.statusBarAnimation = .slide
        case "moveAnimationDragLiner":
            controller.style = .moveAnimationDragLiner
            if #available(iOS 13.0, *) {
                controller.statusBarStyle = .darkContent
            } else {
                // Fallback on earlier versions
            }
            controller.statusBarAnimation = .fade
        case "moveAnimationDragCaseInOut":
            controller.style = .moveAnimationDragCaseInOut
            controller.statusBarStyle = .lightContent
            controller.statusBarAnimation = .slide
        default: break
        }
        controller.hiddenNavgationBarWhenPushIn = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


