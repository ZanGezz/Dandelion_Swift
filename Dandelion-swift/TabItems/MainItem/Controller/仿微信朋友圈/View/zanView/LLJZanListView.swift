//
//  LLJZanListView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/26.
//

import UIKit

class LLJZanListView: UIView {

    typealias selectPingItemBlock = ((Int) -> Void)
    //MARK:懒加载属性
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.register(LLJPingListCell.self, forCellReuseIdentifier: "LLJPingListCell")
        tableView.register(LLJZanListCell.self, forCellReuseIdentifier: "LLJZanListCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        return tableView
    }()
    
    private var attrContent: LJTextString = LJTextString(content: "")
    private var zanHeight: CGFloat = 0.0
    private var model: LLJCycleMessageModel = LLJCycleMessageModel()
    private var zanItemSize: CGSize = CGSize.zero
    var selectPingItem: selectPingItemBlock?
    override init(frame: CGRect) {
        super.init(frame: frame)
        //UI
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UITableViewDelegate 代理 -
extension LLJZanListView: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return self.model.zanHeight
        } else {
            let model = self.model.pingList[indexPath.row]
            return model.rowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if self.model.zanHeight == 0 {
                return 0
            } else {
                return 1
            }
        } else {
            return self.model.pingList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LLJZanListCell") as! LLJZanListCell
            cell.selectionStyle = .none
            if self.model.pingList.count == 0 {
                cell.setDataSource(content: self.model.attrContent, bottomLineHidden: true)
            } else {
                cell.setDataSource(content: self.model.attrContent, bottomLineHidden: false)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LLJPingListCell") as! LLJPingListCell
            cell.selectionStyle = .none
            let ping = self.model.pingList[indexPath.row]
            cell.setDataSource(content: ping.attrContent)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selectPingItem != nil && indexPath.section == 1 {
            self.selectPingItem!(indexPath.row)
        }
    }
}

//MARK: - UI -
extension LLJZanListView {
    
    private func setUpUI() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = LLJDX(5.0)
        self.addSubview(self.tableView)
    }
    
    func setDataSource(sourceModel: LLJCycleMessageModel) {
        
        self.model = sourceModel

        self.tableView.frame = self.bounds
        self.tableView.reloadData()
    }
}
