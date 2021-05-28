//
//  LLJSegmentView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/5/25.
//

import UIKit


enum LLJSegmentViewBottomLineScorllStyle {
    case cycle                      //仿网易新闻圆圈
    case moveAnimationNone          //无动画直接移动    针对底线
    case moveAnimationLiner         //动画匀速移动      针对底线
    case moveAnimationCaseInOut     //变速移动         针对底线
    case moveAnimationDragLiner     //拖拽动画匀速移动   针对底线 需要配合LLJContentViewDelegate：func scrollingToItem(index: Int, percentage: Double)方法
    case moveAnimationDragCaseInOut //拖拽变速移动      针对底线  需要配合LLJContentViewDelegate：func scrollingToItem(index: Int, percentage: Double)方法
}

protocol LLJSegmentViewDelegate: NSObjectProtocol {
    
    func didSelectItem(index: Int)
}

class LLJSegmentView: UIView {

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
        collectionView.register(LLJSegmentViewCell.self, forCellWithReuseIdentifier: "SegmentViewCell")
        collectionView.register(LLJSegmentViewCell.self, forCellWithReuseIdentifier: "SegmentViewCell_firstCell")
        return collectionView
    }()
    
    lazy var bottomLine: UIView = {
        let bottomLine = UIView()
        bottomLine.frame = CGRect.zero
        return bottomLine
    }()
    
    //标题数组
    private var _itemTitles: [String] = []
    //模型数组
    private var itemModels: [LLJSegmentModel] = []
    //正常标题字体
    private var _itemFont: UIFont = LLJFont(16)
    //选中标题字体
    private var _selectItemFont: UIFont = LLJBoldFont(18)
    //正常字体颜色
    private var _itemTitleColor: UIColor = LLJColor(50, 50, 50, 1)
    //选中字体颜色
    private var _selectItemTitleColor: UIColor = UIColor.black
    //item背景颜色
    private var _itemBackColor: UIColor = LLJWhiteColor()
    //选中行
    private var _currentSelectItem: Int = 0
    //上一个选中行
    private var lastSelectItem: Int = 0
    //第一个item距离左边距离
    private var _firstItemLeftOffSet: CGFloat = 0.0
    //item间距
    private var _itemSpace: CGFloat = 20.0
    //底线相对title的宽 默认1:1
    private var _bottomLineWidthRatio: CGFloat = 1.0
    //底线高 默认2.0
    private var _bottomLineHeight: CGFloat = 2.0
    //底线圆角 默认0.0
    private var _bottomLineConnerRadius: CGFloat = 0.0
    //底线颜色
    private var _bottomLineColor: UIColor = LLJRandomColor()
    //底线距离底部距离
    private var _bottomLineBottomOffSet: CGFloat = 2.0
    //底线样式及动画 默认圆圈
    private var _lineStyle: LLJSegmentViewBottomLineScorllStyle = .cycle
    //动画时间
    var animationDuration: Double = 0.3
    //使用时动画时间
    var userAnimationDuration: Double = 0.0
    //底线高
    private var bottomLine_y: CGFloat = 0.0;
    //
    private var cycleConerRadius: CGFloat = 4;
    
    private var currentCell: LLJSegmentViewCell?;
    private var lastCell: LLJSegmentViewCell?;

    //代理
    weak open var delegate: LLJSegmentViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 计算属性 -
extension LLJSegmentView {
    
    //标题数组
    var itemTitles: [String] {
        set {
            
            _itemTitles = newValue
            //先移除
            itemModels.removeAll()
            //在添加
            for title in _itemTitles {
                let model = LLJSegmentModel()
                model.title = title
                itemModels.append(model)
            }
            //设置itemSize
            setItemSize()
            //滚到默认位置
            if itemModels.count > 0 {
                //底线滚动到选中item
                bottomLineScrollToItem(index: self.currentSelectItem, percentage: 1.0)
            }
        }
        get {
            return _itemTitles
        }
    }
    
    //正常标题字体
    var itemFont: UIFont {
        set {
            _itemFont = newValue
            //设置itemSize
            setItemSize()
        }
        get {
            return _itemFont
        }
    }
    
    //选中标题字体
    var selectItemFont: UIFont {
        set {
            _selectItemFont = newValue
            self.collectionView.reloadData()
        }
        get {
            return _selectItemFont
        }
    }
    
    //正常字体颜色
    var itemTitleColor: UIColor {
        set {
            _itemTitleColor = newValue
            self.collectionView.reloadData()
        }
        get {
            return _itemTitleColor
        }
    }
    
    //选中字体颜色
    var selectItemTitleColor: UIColor {
        set {
            _selectItemTitleColor = newValue
            self.collectionView.reloadData()
        }
        get {
            return _selectItemTitleColor
        }
    }
    
    //item背景颜色
    var itemBackColor: UIColor {
        set {
            _itemBackColor = newValue
            self.backgroundColor = newValue
            self.collectionView.backgroundColor = newValue
            self.collectionView.reloadData()
        }
        get {
            return _itemBackColor
        }
    }
    
    //底线宽
    var bottomLineWidthRatio: CGFloat {
        set {
            _bottomLineWidthRatio = newValue
            //设置itemSize
            setItemSize()
        }
        get {
            return _bottomLineWidthRatio
        }
    }
    
    //底线高
    var bottomLineHeight: CGFloat {
        set {
            _bottomLineHeight = newValue
            //设置itemSize
            setItemSize()
        }
        get {
            return _bottomLineHeight
        }
    }
    
    //底线颜色
    var bottomLineColor: UIColor {
        set {
            _bottomLineColor = newValue
            self.bottomLine.backgroundColor = newValue
        }
        get {
            return _bottomLineColor
        }
    }
    
    //底线圆角
    var bottomLineConnerRadius: CGFloat {
        set {
            _bottomLineConnerRadius = newValue
            self.bottomLine.layer.cornerRadius = newValue
            //设置itemSize
            setItemSize()
        }
        get {
            return _bottomLineConnerRadius
        }
    }
    
    //底线距离底部距离
    var bottomLineBottomOffSet: CGFloat {
        set {
            _bottomLineBottomOffSet = newValue
            //设置itemSize
            setItemSize()
        }
        get {
            return _bottomLineBottomOffSet
        }
    }
    
    //底线样式及动画
    var lineStyle: LLJSegmentViewBottomLineScorllStyle {
        set {
            _lineStyle = newValue
            //设置itemSize
            setItemSize()
            //滚到默认位置
            if itemModels.count > 0 {
                //底线滚动到选中item
                bottomLineScrollToItem(index: self.currentSelectItem, percentage: 1.0)
            }
        }
        get {
            return _lineStyle
        }
    }
    
    //默认选中行
    var currentSelectItem: Int {
        set {
            _currentSelectItem = newValue
            //设置选中项
            setSelectItem(index: newValue)
            //滚到默认位置
            if itemModels.count > 0 {
                //底线滚动到选中item
                bottomLineScrollToItem(index: self.currentSelectItem, percentage: 1.0)
            }
            //刷新
            self.collectionView.reloadData()
        }
        get {
            return _currentSelectItem
        }
    }
    
    //第一个item距离左边距离
    var firstItemLeftOffSet: CGFloat {
        set {
            _firstItemLeftOffSet = newValue
            //设置itemSize
            setItemSize()
        }
        get {
            return _firstItemLeftOffSet
        }
    }
    
    //item间距
    var itemSpace: CGFloat {
        set {
            _itemSpace = newValue
            //设置itemSize
            setItemSize()
        }
        get {
            return _itemSpace
        }
    }
    
    //计算itemSize
    private func setItemSize() {
        
        if self.itemModels.count == 0 {
            return
        }
        
        for i in stride(from: 0, to: self.itemModels.count, by: 1) {
            
            let model = self.itemModels[i]
            let W = LLJSHelper.getStringSize(subString: model.title, font: self.itemFont, width: 0.0).width
            if i == 0 {
                model.itemSize = CGSize(width: W + self.itemSpace + self.firstItemLeftOffSet, height: self.bounds.height)
            } else {
                model.itemSize = CGSize(width: W + self.itemSpace, height: self.bounds.height)
            }
            model.titleWidth = W
        }
        
        self.collectionView.reloadData()
        //计算bottomLineFrame
        setBottomLineFrame()
    }
    
    //计算选中item
    private func setSelectItem(index: Int) {
        
        for i in stride(from: 0, to: self.itemModels.count, by: 1) {
            
            let model = self.itemModels[i]
            if i == index {
                model.isCurrentSelected = true
            } else {
                model.isCurrentSelected = false
            }
        }
        //刷新
        collectionView.reloadData()
    }
    
    //设置line样式
    private func setBottomLineFrame() {
        
        var bottom_x: CGFloat = 0.0
        var itemOffSet: CGFloat = 0.0
        
        switch self.lineStyle {
        
        case .cycle:
            
            //圆形
            for index in stride(from: 0, to: self.itemModels.count, by: 1) {
                
                let model = self.itemModels[index]
                model.bottomLineStaticFrame = CGRect(x: 0, y: 0, width: 4, height: 4)
            }
        
        case .moveAnimationNone,.moveAnimationLiner,.moveAnimationCaseInOut,.moveAnimationDragLiner,.moveAnimationDragCaseInOut:
            
            //线
            bottomLine_y = self.bounds.height - self.bottomLineHeight - self.bottomLineBottomOffSet
            
            for index in stride(from: 0, to: self.itemModels.count, by: 1) {
                
                let model = self.itemModels[index]
                
                self.bottomLine.backgroundColor = _bottomLineColor
                self.bottomLine.layer.cornerRadius = _bottomLineConnerRadius
                let bottom_w = model.titleWidth*self.bottomLineWidthRatio
                let bottom_w_l = (model.itemSize.width - model.titleWidth*self.bottomLineWidthRatio)/2.0
                bottom_x = itemOffSet + bottom_w_l
                if index == 0 {
                    model.bottomLineStaticFrame = CGRect(x: bottom_x + self.firstItemLeftOffSet/2.0, y: bottomLine_y, width: bottom_w, height: self.bottomLineHeight)
                } else {
                    model.bottomLineStaticFrame = CGRect(x: bottom_x, y: bottomLine_y, width: bottom_w, height: self.bottomLineHeight)
                }
                itemOffSet += model.itemSize.width
            }
            self.bottomLine.frame = self.itemModels[self.currentSelectItem].bottomLineStaticFrame
        }
    }
}

//MARK: - UICollectionViewDataSource -
extension LLJSegmentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return _itemTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var Identifier = "SegmentViewCell"
        if indexPath.row == 0 {
            Identifier = "SegmentViewCell_firstCell"
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier, for: indexPath) as! LLJSegmentViewCell
        if indexPath.row == 0 {
            cell.firstItemLeftOffSet = self.firstItemLeftOffSet
        }
        cell.backgroundColor = self.itemBackColor
        return cell
    }
}

//MARK: - UICollectionViewDelegate -
extension LLJSegmentView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let model = self.itemModels[indexPath.row]
        let newCell = cell as! LLJSegmentViewCell
        if model.isCurrentSelected {
            newCell.setDataSource(title: model.title, textColor: self.selectItemTitleColor, textFont: self.selectItemFont)
        } else {
            newCell.setDataSource(title: model.title, textColor: self.itemTitleColor, textFont: self.itemFont)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
        self.lastCell = self.currentCell
        self.currentCell = collectionView.cellForItem(at: indexPath) as? LLJSegmentViewCell
        //设置选中项
        setSelectItem(index: indexPath.row)
        //底线滚动到选中item
        bottomLineScrollToItem(index: indexPath.row, percentage: 1.0)
        //发送代理
        delegate?.didSelectItem(index: indexPath.row)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout -
extension LLJSegmentView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = self.itemModels[indexPath.row]
        return model.itemSize
    }
}

//MARK: - UI -
extension LLJSegmentView {
    
    //UI
    private func setUpUI() {
        
        self.backgroundColor = self.itemBackColor
        self.collectionView.backgroundColor = self.itemBackColor
        self.addSubview(self.collectionView)
        self.collectionView.addSubview(self.bottomLine)
    }
}

//MARK: - item 滚动到指定位置 -
extension LLJSegmentView {
    
    //滚动到选中item
    func scrollToItem(index: Int, animated: Bool) {
        
        let indexPath = IndexPath(row: index, section: 0)
        //滚动到选中item
        self.collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: animated)
        //刷新选中
        setSelectItem(index: index)
        self.collectionView.reloadData()
    }
    
    //底线滚动到选中item
    func bottomLineScrollToItem(index: Int, percentage: CGFloat) {
                
        switch self.lineStyle {
        case .cycle:
            
            if self.currentSelectItem != index {
                
                self.currentSelectItem = index
                
                //toItem
                self.itemModels[self.currentSelectItem].bottomLineDragFrame = CGRect(x: 0, y: 0, width: 4*percentage, height: 4*percentage)
                self.currentCell?.setCycleViewFrame(model: self.itemModels[self.currentSelectItem], color: LLJRandomColor())

                //lastItem
                self.itemModels[self.currentSelectItem].bottomLineDragFrame = CGRect(x: 0, y: 0, width: 4*(1-percentage), height: 4*(1-percentage))
                self.lastCell?.setCycleViewFrame(model: self.itemModels[self.lastSelectItem], color: LLJRandomColor())
                
                if percentage == 1.0 {
                    self.lastSelectItem = self.currentSelectItem
                }
            }
            
        case .moveAnimationNone:
            
            _currentSelectItem = index

            if percentage == 1.0 {
                
                lastSelectItem = _currentSelectItem
                
                self.bottomLine.frame = self.itemModels[index].bottomLineStaticFrame
                //滚动到指定item
                scrollToItem(index: self.currentSelectItem, animated: true)
            }
            
        case .moveAnimationLiner:
            
            _currentSelectItem = index

            if percentage >= 0.6 {
                //滚动到指定item
                self.scrollToItem(index: self.currentSelectItem, animated: true)
            }
            
            if percentage == 1.0 {
                                
                UIView.setAnimationCurve(UIView.AnimationCurve.linear)
                UIView.animate(withDuration: self.animationDuration) {
                    self.bottomLine.frame = self.itemModels[self.currentSelectItem].bottomLineStaticFrame
                } completion: { (completion) in
                    
                    self.lastSelectItem = self.currentSelectItem
                    //滚动到指定item
                    self.scrollToItem(index: self.currentSelectItem, animated: true)
                }
            }
            
        case .moveAnimationCaseInOut:
                   
            _currentSelectItem = index

            if percentage == 1.0 {
                                
                var bottom_move_w: CGFloat = 0.0
                let bottom_y: CGFloat = self.bounds.height - self.bottomLineHeight - self.bottomLineBottomOffSet
                let bottom_w = self.itemModels[self.lastSelectItem].titleWidth*self.bottomLineWidthRatio
                let bottom_next_w = self.itemModels[self.currentSelectItem].titleWidth*self.bottomLineWidthRatio
                
                var currentStaticFrame: CGRect = CGRect.zero
                var movingFrame: CGRect = CGRect.zero

                if self.currentSelectItem >= self.lastSelectItem {
                    
                    bottom_move_w = self.itemModels[self.currentSelectItem].bottomLineStaticFrame.origin.x - self.itemModels[self.lastSelectItem].bottomLineStaticFrame.origin.x + bottom_next_w
                    currentStaticFrame = self.itemModels[self.currentSelectItem].bottomLineStaticFrame
                    movingFrame = CGRect(x: self.itemModels[self.lastSelectItem].bottomLineStaticFrame.origin.x, y: bottom_y, width: bottom_move_w, height: self.bottomLineHeight)
                } else {
                    
                    bottom_move_w = self.itemModels[self.lastSelectItem].bottomLineStaticFrame.origin.x - self.itemModels[self.currentSelectItem].bottomLineStaticFrame.origin.x + bottom_w
                    currentStaticFrame = self.itemModels[self.currentSelectItem].bottomLineStaticFrame
                    movingFrame = CGRect(x: self.itemModels[self.currentSelectItem].bottomLineStaticFrame.origin.x, y: bottom_y, width: bottom_move_w, height: self.bottomLineHeight)
                }
                
                UIView.setAnimationCurve(UIView.AnimationCurve.easeInOut)
                UIView.animate(withDuration: self.animationDuration) {
                    self.bottomLine.frame = movingFrame
                } completion: { (completion) in
                    
                    self.bottomLine.frame = currentStaticFrame
                    self.lastSelectItem = self.currentSelectItem
                    //滚动到指定item
                    self.scrollToItem(index: self.currentSelectItem, animated: true)
                }
            }
            
        case .moveAnimationDragLiner:

            _currentSelectItem = index

            var bottom_move_x: CGFloat = 0.00
            var X: CGFloat = 0.00
            var W: CGFloat = 0.00
            if _currentSelectItem >= lastSelectItem {
                bottom_move_x = self.itemModels[self.currentSelectItem].bottomLineStaticFrame.origin.x - self.itemModels[self.lastSelectItem].bottomLineStaticFrame.origin.x
                X = self.itemModels[self.lastSelectItem].bottomLineStaticFrame.origin.x + bottom_move_x*percentage
                W = self.itemModels[self.lastSelectItem].bottomLineStaticFrame.size.width
                if percentage > 0.8 {
                    W = self.itemModels[self.currentSelectItem].bottomLineStaticFrame.size.width
                }
            } else {
                bottom_move_x = self.itemModels[self.lastSelectItem].bottomLineStaticFrame.origin.x - self.itemModels[self.currentSelectItem].bottomLineStaticFrame.origin.x
                X = self.itemModels[self.lastSelectItem].bottomLineStaticFrame.origin.x - bottom_move_x*percentage
                W = self.itemModels[self.lastSelectItem].bottomLineStaticFrame.size.width
                if percentage > 0.8 {
                    W = self.itemModels[index].bottomLineStaticFrame.size.width
                }
            }
            let frame = CGRect(x: X, y: bottomLine_y, width: W, height: self.bottomLineHeight)
            
            //计算动画时间
            if percentage < 1.0 {
                self.bottomLine.frame = frame
                self.userAnimationDuration = (self.animationDuration - self.animationDuration*Double(percentage)) <= 0.0001 ? 0.0001 : (self.animationDuration - self.animationDuration*Double(percentage))
            }
            
            if percentage >= 0.7 {
                self.scrollToItem(index: self.currentSelectItem, animated: true)
            }
            
            if percentage == 1.0 {
                
                UIView.setAnimationCurve(UIView.AnimationCurve.linear)
                UIView.animate(withDuration: self.userAnimationDuration) {
                    self.bottomLine.frame = self.itemModels[self.currentSelectItem].bottomLineStaticFrame
                } completion: { (completion) in
                    
                    self.lastSelectItem = self.currentSelectItem
                    //滚动到指定item
                    self.scrollToItem(index: self.currentSelectItem, animated: true)
                    self.userAnimationDuration = self.animationDuration
                }
            }
            
        case .moveAnimationDragCaseInOut:
            
            _currentSelectItem = index

            var bottom_move_w: CGFloat = 0.0
            let bottom_y: CGFloat = self.bounds.height - self.bottomLineHeight - self.bottomLineBottomOffSet
            let bottom_w = self.itemModels[self.lastSelectItem].titleWidth*self.bottomLineWidthRatio
            let bottom_next_w = self.itemModels[self.currentSelectItem].titleWidth*self.bottomLineWidthRatio
            
            var currentStaticFrame: CGRect = CGRect.zero
            var movingFrame: CGRect = CGRect.zero

            if self.currentSelectItem >= self.lastSelectItem {
                
                bottom_move_w = (self.itemModels[self.currentSelectItem].bottomLineStaticFrame.origin.x - self.itemModels[self.lastSelectItem].bottomLineStaticFrame.origin.x + bottom_next_w - bottom_w)*percentage + bottom_w
                currentStaticFrame = self.itemModels[self.currentSelectItem].bottomLineStaticFrame
                movingFrame = CGRect(x: self.itemModels[self.lastSelectItem].bottomLineStaticFrame.origin.x, y: bottom_y, width: bottom_move_w, height: self.bottomLineHeight)
                
            } else {
                
                bottom_move_w = (self.itemModels[self.lastSelectItem].bottomLineStaticFrame.origin.x - self.itemModels[self.currentSelectItem].bottomLineStaticFrame.origin.x)*percentage + bottom_w
                currentStaticFrame = self.itemModels[self.currentSelectItem].bottomLineStaticFrame
                let X = self.itemModels[self.lastSelectItem].bottomLineStaticFrame.origin.x - bottom_move_w + bottom_w
                movingFrame = CGRect(x: X, y: bottom_y, width: bottom_move_w, height: self.bottomLineHeight)
            }
            
            //计算动画时间
            if percentage < 1.0 {
                self.bottomLine.frame = movingFrame
                self.userAnimationDuration = (self.animationDuration - self.animationDuration*Double(percentage)) <= 0.0001 ? 0.0001 : (self.animationDuration - self.animationDuration*Double(percentage))
                LLJLog(self.animationDuration*Double(percentage))
            }

            if percentage == 1.0 {
                                
                UIView.setAnimationCurve(UIView.AnimationCurve.easeInOut)
                UIView.animate(withDuration: self.userAnimationDuration) {
                    self.bottomLine.frame = movingFrame
                } completion: { (completion) in
                    
                    self.bottomLine.frame = currentStaticFrame
                    self.lastSelectItem = self.currentSelectItem
                    //滚动到指定item
                    self.scrollToItem(index: self.currentSelectItem, animated: true)
                    self.userAnimationDuration = self.animationDuration
                }
            }
            
        }
    }
}
