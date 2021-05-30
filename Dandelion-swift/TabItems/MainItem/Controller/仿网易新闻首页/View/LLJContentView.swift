//
//  LLJContentView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/5/26.
//

import UIKit

protocol LLJContentViewDelegate: NSObjectProtocol {
    //滚动到item
    func didScrollToItem(index: Int, percentage: CGFloat, isDraging: Bool)
    //向item滚动中 percentage: 滚动相对于当前view的百分比
    func scrollingToItem(index: Int, percentage: CGFloat, isDraging: Bool)
}

class LLJContentView: UIView {

    //collectionView
    lazy var collectionView: UICollectionView = {
        
        let flawLayout = UICollectionViewFlowLayout()
        flawLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        flawLayout.minimumInteritemSpacing = 0.0
        flawLayout.minimumLineSpacing = 0.0
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flawLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        return collectionView
    }()
    
    //itemSize
    private lazy var itemSize: CGSize = {
        return CGSize(width: self.bounds.width, height: self.bounds.height)
    }()
    //当前item index
    private var _currentItemIndex: Int = 0
    //下一个item index
    private var nextItemIndex: Int = 0
    //
    //x方向的offset差
    private var difference_x: CGFloat = 0.0
    //子视图
    private var _viewList: [UIView] = []
    //代理
    weak open var delegate: LLJContentViewDelegate?
    //手指开始触到view
    private var isViewDragBegin: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 计算属性 -
extension LLJContentView {
    
    var viewList: [UIView] {
        set {
            _viewList = newValue
            self.collectionView.reloadData()
        }
        get {
            return _viewList
        }
    }
    
    var currentItemIndex: Int {
        set {
            _currentItemIndex = newValue
            
            scrollToItem(index: newValue, animated: true)
        }
        get {
            return _currentItemIndex
        }
    }
}

//MARK: - UICollectionViewDataSource -
extension LLJContentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return _viewList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
}

//MARK: - UICollectionViewDelegate -
extension LLJContentView: UICollectionViewDelegate, UIScrollViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let view = _viewList[indexPath.row]
        view.frame = self.bounds
        cell.addSubview(view)
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

        isViewDragBegin = true
        _currentItemIndex = Int(scrollView.contentOffset.x/self.itemSize.width)
        LLJLog("scrollViewWillBeginDragging")
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //round函数 四舍五入
        nextItemIndex = Int(round(scrollView.contentOffset.x/self.bounds.width))
        self.delegate?.didScrollToItem(index: nextItemIndex, percentage: 1.0, isDraging: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isViewDragBegin {
            let _x = scrollView.contentOffset.x - CGFloat(_currentItemIndex)*self.itemSize.width
            if _x > 0 {
                self.delegate?.scrollingToItem(index: _currentItemIndex + 1, percentage: _x/self.itemSize.width, isDraging: true)
            } else {
                self.delegate?.scrollingToItem(index: (_currentItemIndex - 1) <= 0 ? 0 : (_currentItemIndex - 1), percentage: -_x/self.itemSize.width, isDraging: true)
            }
            
            if _x == 0 || _x == self.itemSize.width || _x == -self.itemSize.width {
                isViewDragBegin = false
            }
        }
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout -
extension LLJContentView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
}


//MARK: - UI -
extension LLJContentView {
    
    //UI
    private func setUpUI() {
        
        self.backgroundColor = LLJWhiteColor()
        self.collectionView.backgroundColor = LLJWhiteColor()
        self.addSubview(self.collectionView)
    }
    
    func scrollToItem(index: Int, animated: Bool) {
        //滚动到选中行
        LLJLog(index)
        let indexPath = IndexPath(row: index, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.left, animated: animated)
    }
}
