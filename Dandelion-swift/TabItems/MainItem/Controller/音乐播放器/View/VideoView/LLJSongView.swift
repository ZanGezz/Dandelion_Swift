//
//  LLJSongView.swift
//  Dandelion-swift
//
//  Created by liushuai on 2023/8/31.
//

import UIKit

class LLJSongView: UIView {

    //MARK:懒加载属性
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.register(LLJSongCell.self, forCellReuseIdentifier: "LLJSongCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        return tableView
    }()
    
    var dataSource: [LLJSongModel] = []
    
    init(dataSource: [LLJSongModel]) {
        super.init(frame: CGRect.zero)
        self.dataSource = dataSource
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LLJSongView {
    private func setUpUI() {
        self.addSubview(self.tableView)
        self.tableView.snp_makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}

extension LLJSongView: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //let model = self.dataSource[indexPath.row]
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let model = self.dataSource[indexPath.row]
                
        //纯文字cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "LLJSongCell") as! LLJSongCell
        cell.setDataSource(content: "我们都是好孩子，异想天开的孩子。")
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
}
