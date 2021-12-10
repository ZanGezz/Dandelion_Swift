//
//  LLJAlertView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/23.
//

import UIKit

enum LLJAlertType {
    case sheet
    case alert
}

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
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        button.tag = 100100010
        return button
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8.0
        view.backgroundColor = LLJWhiteColor()
        return view
    }()
    
    lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.textColor = LLJBlackColor()
        contentLabel.font = LLJBoldFont(18)
        contentLabel.textAlignment = .center
        contentLabel.text = "删除该朋友圈?"
        return contentLabel
    }()
    
    private lazy var lineView1: UIView = {
        let view = UIView()
        view.backgroundColor = LLJColor(243, 243, 243, 1.0)
        return view
    }()
    
    private lazy var lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = LLJColor(243, 243, 243, 1.0)
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("取消", for: UIControl.State.normal)
        button.setTitleColor(LLJBlackColor(), for: UIControl.State.normal)
        button.titleLabel?.font = LLJBoldFont(18)
        button.tag = 100100011
        button.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var sureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("确定", for: UIControl.State.normal)
        button.setTitleColor(LLJColor(216, 66, 65, 1.0), for: UIControl.State.normal)
        button.titleLabel?.font = LLJBoldFont(18)
        button.tag = 100100012
        button.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        return button
    }()
    
    typealias selectBlock = ((Int, String, LLJAlertType) -> Void)
    
    private var _cancelText: String = "取消"
    private var _cancelFont: UIFont = LLJFont(18, "")
    private var _cancelTextColor: UIColor = LLJBlackColor()
    private var _contentFont: UIFont = LLJFont(18, "")
    private var _contentTextColor = LLJBlackColor()
    private var itemList: Array<Any> = []
    private var tableViewH: CGFloat = 0.0
    var selectRow: selectBlock?
    var type: LLJAlertType = .sheet
    
    init(frame: CGRect, type: LLJAlertType) {
        super.init(frame: frame)
        
        self.type = type
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
                selectRow!(indexPath.row, model.title, .sheet)
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
        
        if self.type == .sheet {
            self.addSubview(self.tableView)
            self.addSubview(self.clearButton)
        } else {
            self.addSubview(self.contentView)
            self.contentView.snp_makeConstraints { (make) in
                make.centerX.equalTo(self.snp_centerX)
                make.centerY.equalTo(self.snp_centerY)
                make.width.equalTo(LLJDX(320))
                make.height.equalTo(LLJDX(160))
            }
            self.contentView.addSubview(self.contentLabel)
            self.contentLabel.snp_makeConstraints { (make) in
                make.centerX.equalTo(self.snp_centerX)
                make.top.equalTo(self.contentView.snp_top).offset(LLJDX(43))
                make.left.equalTo(self.contentView.snp_left)
                make.right.equalTo(self.contentView.snp_right)
            }
            self.contentView.addSubview(self.lineView1)
            self.lineView1.snp_makeConstraints { (make) in
                make.height.equalTo(0.5)
                make.top.equalTo(self.contentView.snp_top).offset(LLJDX(104))
                make.left.equalTo(self.contentView.snp_left)
                make.right.equalTo(self.contentView.snp_right)
            }
            self.contentView.addSubview(self.cancelButton)
            self.cancelButton.snp_makeConstraints { (make) in
                make.bottom.equalTo(self.contentView.snp_bottom)
                make.top.equalTo(self.lineView1.snp_bottom)
                make.left.equalTo(self.contentView.snp_left)
                make.right.equalTo(self.contentView.snp_centerX)
            }
            self.contentView.addSubview(self.lineView2)
            self.lineView2.snp_makeConstraints { (make) in
                make.bottom.equalTo(self.contentView.snp_bottom)
                make.top.equalTo(self.lineView1.snp_bottom)
                make.left.equalTo(self.cancelButton.snp_right)
                make.width.equalTo(0.5)
            }
            self.contentView.addSubview(self.sureButton)
            self.sureButton.snp_makeConstraints { (make) in
                make.bottom.equalTo(self.contentView.snp_bottom)
                make.top.equalTo(self.lineView1.snp_bottom)
                make.left.equalTo(self.lineView2.snp_right)
                make.right.equalTo(self.contentView.snp_right)
            }
        }
    }
    
    //按钮事件
    @objc func buttonClick(sender: UIButton) {
        switch sender.tag {
        case 100100010:break
        case 100100011:break
        case 100100012:
            //确定
            if self.selectRow != nil {
                self.selectRow!(0,"确定",.alert)
            }
        default:break
            
        }
        //收回
        alertHidden()
    }
    
    //弹框
    func alertShow(superView: UIView, itemList: Array<Any>) {
        
        self.frame = superView.bounds
        superView.addSubview(self)
        
        if self.type == .sheet {
            self.itemList = itemList
            self.tableView.reloadData()
            
            self.backgroundColor = LLJColor(255, 255, 255, 0.0)
            tableViewH = CGFloat((itemList.count + 1)) * LLJDX(62) + LLJDX(8)
            self.clearButton.frame = CGRect(x: 0, y: 0, width: superView.bounds.width, height: superView.bounds.height - self.tableViewH)
            self.tableView.frame = CGRect(x: 0, y: superView.bounds.height, width: superView.bounds.width, height: self.tableViewH)
            LLJSUIKitHelper.LLJCView(subView: tableView, cornerRadius: [16,16,0,0])
            
        }
        
        weak var weakSelf = self
        UIView.animate(withDuration: 0.25) {
            weakSelf!.backgroundColor = LLJColor(0, 0, 0, 0.4)
            if weakSelf!.type == .sheet {
                weakSelf!.tableView.frame = CGRect(x: 0, y: superView.bounds.height - weakSelf!.tableViewH, width: superView.bounds.width, height: weakSelf!.tableViewH)
            }
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
            if self.type == .sheet {
                weakSelf!.tableView.frame = CGRect(x: 0, y: weakSelf!.bounds.height, width: weakSelf!.bounds.width, height: weakSelf!.tableViewH)
            } else {
                self.contentView.alpha = 0
            }
        } completion: { (complete) in
            weakSelf!.removeFromSuperview()
        }
    }
}
