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
        tableView.register(LLJZanListCell.self, forCellReuseIdentifier: "LLJZanListCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        return tableView
    }()
    
    //collectionView
    lazy var collectionView: UICollectionView = {
        
        let flawLayout = UICollectionViewFlowLayout()
        flawLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flawLayout.minimumInteritemSpacing = LLJDX(5.0)
        flawLayout.minimumLineSpacing = LLJDX(5.0)
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flawLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.backgroundColor = LLJWhiteColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(LLJZanListCell.self, forCellWithReuseIdentifier: "LLJZanListCell")
        return collectionView
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = LLJColor(70, 70, 70, 1.0)
        return lineView
    }()
    
    private var zanContent: String?
    private var zanHeight: CGFloat = 0.0
    private var pingList: [LLJPingListModel] = []
    private var zanList: [LLJPingListModel] = []
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
        
        let model = self.pingList[indexPath.row]
        return model.rowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LLJPingListCell") as! LLJPingListCell
        cell.selectionStyle = .none
        
        let ping = self.pingList[indexPath.row]
        if self.pingList.count == 1 {
            //cell.setDataSource(content: self.zanContent!, imageHidden: false, lineHidden: true)
        } else if (self.pingList.count > 1) {
            if indexPath.row == 0 {
                //cell.setDataSource(content: ping.pingContent, imageHidden: false, lineHidden: false)
            } else {
                //cell.setDataSource(content: ping.pingContent, imageHidden: true, lineHidden: true)
            }
        }
        return cell
    }
}

//MARK - UICollectionViewDelegate -
extension LLJZanListView: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.zanList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LLJZanListCell", for: indexPath) as! LLJZanListCell
        //cell.setDataSource(imageName: self.zanList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension LLJZanListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return zanItemSize
    }
}

//MARK: - UI -
extension LLJZanListView {
    
    private func setUpUI() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = LLJDX(6.0)
        self.addSubview(self.tableView)
    }
    
    func setDataSource(sourceModel: LLJCycleMessageModel) {
        
        self.tableView.frame = self.bounds
        
        self.pingList = sourceModel.pingList
        self.zanContent = sourceModel.zanContent
        self.zanHeight = sourceModel.zanHeight
        self.tableView.reloadData()
    }
}
