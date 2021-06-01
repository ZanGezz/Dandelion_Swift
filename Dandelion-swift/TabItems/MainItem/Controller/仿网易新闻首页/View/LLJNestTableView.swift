//
//  LLJNestTableView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/5/20.
//

import UIKit

protocol LLJNestTableViewDelegate {
    func open() -> String
}

class LLJNestTableView: UIView {
    
    //tableView
    private lazy var tableView: LLJTableView = {
        let tableView = LLJTableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    //头部view
    private var _headView: UIView?
    
    //导航view
    private var _segmentView: UIView?
    
    //间隔view
    private var _separatorView: UIView?
    
    //内容View
    private var _contentView: UIView?
    
    //底部view
    private var _footerView: UIView?
    
    
    //初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LLJNestTableView {
    
    //设置基础UI
    func setUpUI() {
       
        self.addSubview(self.tableView)
        self.tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

//MARK: - UITableViewDelegate -
extension LLJNestTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 && _segmentView != nil {
            return _segmentView!.bounds.height
        } else if (indexPath.row == 1 && _separatorView != nil) {
            return _separatorView!.bounds.height
        } else if (indexPath.row == 2 && _contentView != nil) {
            return _contentView!.bounds.height
        }
        return 0.001;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 && _segmentView != nil {
            //添加segmentView
            cell.contentView.addSubview(_segmentView!)
            
        } else if (indexPath.row == 1 && _separatorView != nil) {
            //添加separatorView
            cell.contentView.addSubview(_separatorView!)
            
        } else if (indexPath.row == 2 && _contentView != nil) {
            //添加contentView
            cell.contentView.addSubview(_contentView!)
        }
    }
}

//MARK: - UITableViewDataSource -
extension LLJNestTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "NestViewCell")
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
}


//MARK: - 设置各部分view并刷新 -
extension LLJNestTableView {
    
    //头部view
    var headView: UIView? {
        set {
            //副新值
            _headView = newValue
            _headView?.frame = newValue!.bounds
            //刷新tableView
            self.tableView.tableHeaderView = newValue
            self.tableView.reloadData()
        }
        get {
            return _headView ?? nil
        }
    }
    
    //导航view
    var segmentView: UIView? {
        set {
            //副新值
            _segmentView = newValue
            _segmentView?.frame = newValue!.bounds
            //刷新tableView
            self.tableView.reloadData()
        }
        get {
            return _segmentView ?? nil
        }
    }
    
    //间隔view
    var separatorView: UIView? {
        set {
            //副新值
            _separatorView = newValue
            _separatorView?.frame = newValue!.bounds
            //刷新tableView
            self.tableView.reloadData()
        }
        get {
            return _separatorView ?? nil
        }
    }
    
    //内容view
    var contentView: UIView? {
        set {
            //副新值
            _contentView = newValue
            _contentView?.frame = newValue!.bounds
            //刷新tableView
            self.tableView.reloadData()
        }
        get {
            return _contentView ?? nil
        }
    }
    
    //底部view
    var footerView: UIView? {
        set {
            //副新值
            _footerView = newValue
            _footerView?.frame = newValue!.bounds
            //刷新tableView
            self.tableView.tableFooterView = newValue
            self.tableView.reloadData()
        }
        get {
            return _footerView ?? nil
        }
    }
}
