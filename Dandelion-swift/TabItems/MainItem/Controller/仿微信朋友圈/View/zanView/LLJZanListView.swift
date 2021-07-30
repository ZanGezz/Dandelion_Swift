//
//  LLJZanListView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/26.
//

import UIKit

class LLJZanListView: UIView {

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
    
    private var attrContent: ASAttributedString = ASAttributedString(string: "")
    private var zanHeight: CGFloat = 0.0
    private var model: LLJCycleMessageModel = LLJCycleMessageModel()
    private var zanItemSize: CGSize = CGSize.zero

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.model.attrContent.length > 0 && indexPath.row == 0 {
            return self.model.zanHeight
        } else {
            let model = self.model.pingList[indexPath.row]
            return model.rowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.model.attrContent.length > 0 {
            return self.model.pingList.count + 1
        }
        return self.model.pingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.model.attrContent.length > 0 && indexPath.row == 0 {
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
            cell.setDataSource(content: self.model.attrContent)
            return cell
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
