//
//  LLJFALiMainViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/4/13.
//

import UIKit

class LLJWChatMainViewController: LLJFViewController {

    //数据
    var dataArray: [[LLJWChatModel]] = []
    lazy var centerView: UILabel = {
        let centerView = UILabel()
        centerView.textColor = LLJBlackColor()
        centerView.font = LLJMediumFont(18)
        centerView.textAlignment = NSTextAlignment.center
        return centerView
    }()
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
        self.title = ""
        self.view.backgroundColor = LLJColor(238, 238, 238, 1)
        self.view.addSubview(self.myTableView)
        self.myTableView.backgroundColor = LLJColor(238, 238, 238, 1)
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.bounces = true
        self.myTableView.register(LLJWChatFirstCell.self, forCellReuseIdentifier: "LLJWChatFirstCell")
        self.myTableView.frame = CGRect(x: 0, y: LLJTopHeight, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - LLJTopHeight)
        
        
        let navi = UIView()
        navi.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: LLJTopHeight)
        self.view.addSubview(navi)
        
        let leftView = UIImageView.init(image: UIImage.init(named: "msg"))
        navi.addSubview(leftView)
        leftView.snp.makeConstraints { (make) in
            make.left.equalTo(navi.snp_left).offset(20)
            make.bottom.equalTo(navi.snp_bottom).offset(-6)
            make.width.equalTo(26)
            make.height.equalTo(26)
        }
        
        let rightView = UIImageView.init(image: UIImage.init(named: "shezhi"))
        navi.addSubview(rightView)
        rightView.snp.makeConstraints { (make) in
            make.right.equalTo(navi.snp_right).offset(-20)
            make.bottom.equalTo(navi.snp_bottom).offset(-6)
            make.width.equalTo(34)
            make.height.equalTo(34)
        }
        
        navi.addSubview(self.centerView)
        self.centerView.snp.makeConstraints { (make) in
            make.centerX.equalTo(navi.snp_centerX)
            make.centerY.equalTo(leftView.snp_centerY)
        }
        setDataSource()
    }
    
    func setDataSource() {
        
        var model1 = LLJWChatModel()
        model1.title = "读书排行榜"
        model1.subContent = "1时16分 可兑换1天无限卡"
        model1.content = "第 1 名"
        model1.redPointShow = true
        
        var model2 = LLJWChatModel()
        model2.title = "关注"
        model2.content = "39 人关注我"
        model2.subContent = "已关注33人 读书小队23分"
        model2.redPointShow = false

        var model3 = LLJWChatModel()
        model3.title = "福利场"
        model3.subContent = "得10本好书"
        model3.content = "免费图书馆"
        model3.redPointShow = false

        var model4 = LLJWChatModel()
        model4.title = "笔记"
        model4.subContent = ""
        model4.content = "83 个笔记"
        model4.redPointShow = false

        var model5 = LLJWChatModel()
        model5.title = "读过和订阅"
        model5.subContent = ""
        model5.content = "405 个阅读记录"
        model5.redPointShow = false
        
        self.dataArray = [[model1],[model1,model2],[model3],[model4,model5]]

        self.myTableView.reloadData()
    }
}

//MARK: - TableViewDelegate -
extension LLJWChatMainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        //组切圆角
        //方法一 判断第一个cell, 切出左上和又上圆角, 最后一个cell, 切出左下和右下圆角
        //方法二 使用带圆角的图片模拟
        let subArray = self.dataArray[indexPath.section]

        //切圆角
        if subArray.count == 1 {
            LLJSUIKitHelper.LLJCView(subView: cell, cornerRadius: [12,12,12,12])
        } else {
            if indexPath.row == 0 {
                LLJSUIKitHelper.LLJCView(subView: cell, cornerRadius: [12,12,0,0])
            } else if (indexPath.row == subArray.count - 1) {
                LLJSUIKitHelper.LLJCView(subView: cell, cornerRadius: [0,0,12,12])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

//MARK: - TableViewDataSource -
extension LLJWChatMainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LLJWChatFirstCell") as! LLJWChatFirstCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.setDataSource()
            return cell
        } else if indexPath.section == 3 {
            let model = self.dataArray[indexPath.section][indexPath.row]
            var cell = tableView.dequeueReusableCell(withIdentifier: "LLJWChatSecondCellTypeTwo") as? LLJWChatSecondCell
            if cell == nil {
                cell = LLJWChatSecondCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "LLJWChatSecondCellTypeTwo", type: LLJWChatSecondCellType.two)
            }
            cell!.setDataSource(title: model.title, content: model.content, subContent: model.subContent, redPointShow: model.redPointShow)
            return cell!
        } else {
            let model = self.dataArray[indexPath.section][indexPath.row]
            var cell = tableView.dequeueReusableCell(withIdentifier: "LLJWChatSecondCellTypeOne") as? LLJWChatSecondCell
            if cell == nil {
                cell = LLJWChatSecondCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "LLJWChatSecondCellTypeOne", type: LLJWChatSecondCellType.one)
            }
            cell!.setDataSource(title: model.title, content: model.content, subContent: model.subContent, redPointShow: model.redPointShow)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return LLJDX(265)
        } else {
            return LLJDX(70)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = self.dataArray[section]
        return array.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
}

extension LLJWChatMainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = self.myTableView.contentOffset
        
        if offset.y > LLJTopHeight {
            self.centerView.text = "赞歌"
        } else {
            self.centerView.text = ""
        }
    }
}

