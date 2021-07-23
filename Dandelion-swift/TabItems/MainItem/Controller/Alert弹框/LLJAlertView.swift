//
//  LLJAlertView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/23.
//

import UIKit

class LLJAlertView: UIView {

    //MARK:懒加载属性
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.bounces = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return button
    }()
    
    typealias selectBlock = ((Int, String) -> Void)
    
    private var _cancelText: String = "取消"
    private var _cancelFont: UIFont = LLJFont(18, "")
    private var _cancelTextColor: UIColor = LLJBlackColor()
    private var _contentFont: UIFont = LLJFont(18, "")
    private var _contentTextColor = LLJBlackColor()
    private var itemList: Array<Any> = []
    private var tableViewH: CGFloat = 0.0
    var selectRow: selectBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //UI
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        LLJLog("LLJAlertView")
    }
}

//MARK: - UI -
extension LLJAlertView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return LLJDX(8)
        } else {
            return 0.001
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LLJDX(62)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = LLJColor(248, 248, 248, 1.0)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let model = self.itemList[indexPath.row] as! LLJAlertModel
            var ident = "LLJAlertCell.commen"
            var type: AlertCellType = .commen
            if model.subTitle.count > 0 {
                ident = "LLJAlertCell.subTitle"
                type = .subTitle
            }
            var cell = tableView.dequeueReusableCell(withIdentifier: ident) as? LLJAlertCell
            if cell == nil {
                cell = LLJAlertCell.init(style: .default, reuseIdentifier: ident, type: type)
                cell?.selectionStyle = .none
            }
            cell!.setDataSource(model: model)
            cell!.titleLabel.textColor = _contentTextColor
            cell!.titleLabel.font = _contentFont
            return cell!
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "LLJAlertCell.commen") as? LLJAlertCell
            if cell == nil {
                cell = LLJAlertCell.init(style: .default, reuseIdentifier: "LLJAlertCell.commen", type: .commen)
                cell?.selectionStyle = .none
            }
            cell!.setCancelTitle(title: _cancelText)
            cell!.titleLabel.textColor = _cancelTextColor
            cell!.titleLabel.font = _cancelFont
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if selectRow != nil {
                let model = self.itemList[indexPath.row] as! LLJAlertModel
                selectRow!(indexPath.row, model.title)
            }
        }
        alertHidden()
    }
}

//MARK: - 计算属性 -
extension LLJAlertView {
    
    var contentTextColor: UIColor {
        set {
            _contentTextColor = newValue
            self.tableView.reloadData()
        }
        get {
            return _contentTextColor
        }
    }
    
    var contentFont: UIFont {
        set {
            _contentFont = newValue
            self.tableView.reloadData()
        }
        get {
            return _contentFont
        }
    }
    
    var cancelFont: UIFont {
        set {
            _cancelFont = newValue
            self.tableView.reloadData()
        }
        get {
            return _cancelFont
        }
    }
    
    var cancelTextColor: UIColor {
        set {
            _cancelTextColor = newValue
            self.tableView.reloadData()
        }
        get {
            return _cancelTextColor
        }
    }
}

//MARK: - UI -
extension LLJAlertView {
    
    private func setUpUI() {
        self.layer.masksToBounds = true
        self.addSubview(self.tableView)
        self.addSubview(self.clearButton)
    }
    
    //按钮事件
    @objc func buttonClick() {
        alertHidden()
    }
    
    //弹框
    func alertShow(superView: UIView, itemList: Array<Any>) {
        
        self.frame = superView.bounds
        superView.addSubview(self)
        
        self.itemList = itemList
        self.tableView.reloadData()
        
        self.backgroundColor = LLJColor(255, 255, 255, 0.0)
        tableViewH = CGFloat((itemList.count + 1)) * LLJDX(62) + LLJDX(8)
        self.clearButton.frame = CGRect(x: 0, y: 0, width: superView.bounds.width, height: superView.bounds.height - self.tableViewH)
        self.tableView.frame = CGRect(x: 0, y: superView.bounds.height, width: superView.bounds.width, height: self.tableViewH)
        LLJSUIKitHelper.LLJCView(subView: tableView, cornerRadius: [16,16,0,0])
        
        weak var weakSelf = self
        UIView.animate(withDuration: 0.25) {
            weakSelf!.backgroundColor = LLJColor(0, 0, 0, 0.4)
            weakSelf!.tableView.frame = CGRect(x: 0, y: superView.bounds.height - weakSelf!.tableViewH, width: superView.bounds.width, height: weakSelf!.tableViewH)
        } completion: { (complete) in
            
        }
    }
    //弹框
    func alertShow(itemList: Array<Any>) {
        alertShow(superView: kRootView, itemList: itemList)
    }
    //收起
    func alertHidden() {
        
        weak var weakSelf = self
        UIView.animate(withDuration: 0.25) {
            weakSelf!.backgroundColor = LLJColor(255, 255, 255, 0.0)
            weakSelf!.tableView.frame = CGRect(x: 0, y: weakSelf!.bounds.height, width: weakSelf!.bounds.width, height: weakSelf!.tableViewH)
        } completion: { (complete) in
            weakSelf!.removeFromSuperview()
        }
    }
}
