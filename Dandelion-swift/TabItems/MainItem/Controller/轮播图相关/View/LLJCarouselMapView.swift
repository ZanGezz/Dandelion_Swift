//
//  LLJCarouselMapView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/6/1.
//

import UIKit

//MARK: - 代理 -
protocol LLJCarouselMapViewDelegate: NSObjectProtocol {
    
    func didScorllToView(subView: UIView, index: Int) -> UIView
}

enum LLJCarouselMapViewStyle {
    case commen    //正常轮播
    case zoom      //缩放轮播
}

enum LLJCarouselMapContentViewStyle {
    case image      //图片
    case custom     //自定义view
}

class LLJCarouselMapView: UIView {

    //懒加载属性
    lazy var contentView: UIScrollView = {
        let contentView = UIScrollView()
        contentView.delegate = self
        contentView.bounces = false
        contentView.showsVerticalScrollIndicator = false
        contentView.showsHorizontalScrollIndicator = false
        contentView.isPagingEnabled = true
        return contentView
    }()
    
    lazy var leftView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    lazy var centerView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    lazy var rightView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    
    
    //左中心
    private var leftCenterPoint: CGPoint = CGPoint.zero
    //中中心
    private var centerCenterPoint: CGPoint = CGPoint.zero
    //右中心
    private var rightCenterPoint: CGPoint = CGPoint.zero
    //缩放比例
    private var zoomRate: CGFloat = 1.0
    //轮播view数据
    private var viewList: [UIView] = []
    //当前显示index
    private var currentIndex: Int = 0
    //轮播样式
    private var mapViewStyle: LLJCarouselMapViewStyle = .commen
    //内容样式
    private var contentViewStyle: LLJCarouselMapContentViewStyle = .image
    //滚动步距
    private var stepWidth: CGFloat = 0.0
    
    
    
    //轮播数据个数 自定义轮播视图时使用
    private var _sourceCount: Int = 0
    //轮播数据
    private var _imageArray: [Any] = []
    //自定义view类型
    private var _contentSubViewClass: AnyClass = UIImageView.self
    //代理
    weak open var delegate: LLJCarouselMapViewDelegate?
    //放大时的size
    private var _largeSize: CGSize = CGSize.zero
    //缩小时的size
    private var _smallSize: CGSize =  CGSize.zero
    //item间距
    private var _itemSpace: CGFloat =  0.0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setUpUI()
    }
    
    init(frame: CGRect, mapViewStyle: LLJCarouselMapViewStyle, contentViewStyle: LLJCarouselMapContentViewStyle) {
        super.init(frame: frame)
        
        self.mapViewStyle = mapViewStyle
        self.contentViewStyle = contentViewStyle

        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 计算属性 -
extension LLJCarouselMapView {
    
    //轮播数据
    var iamgeArray: [Any] {
        set {
            _imageArray = newValue
            
            setDataSource()
        }
        get {
            return _imageArray
        }
    }
    
    var sourceCount: Int {
        set {
            _sourceCount = newValue
            
            setDataSource()
        }
        get {
            return _sourceCount
        }
    }
    
    var contentSubViewClass: AnyClass {
        set {
            _contentSubViewClass = newValue

            setDataSource()
        }
        get {
            return _contentSubViewClass
        }
    }
    
    var largeSize: CGSize {
        set {
            _largeSize = newValue
            
            setUpUI()
        }
        get {
            return _largeSize
        }
    }
    
    var smallSize: CGSize {
        set {
            _smallSize = newValue
            
            setUpUI()
        }
        get {
            return _smallSize
        }
    }
    
    var itemSpace: CGFloat {
        set {
            _itemSpace = newValue
            
            setUpUI()
        }
        get {
            return _itemSpace
        }
    }
}

//MARK: - UI -
extension LLJCarouselMapView {
    
    //UI
    private func setUpUI() {
        
        
        switch self.mapViewStyle {
        
        case .commen:
            
            self.contentView.frame = self.bounds
            self.stepWidth = self.contentView.frame.size.width

            
        case .zoom: break
            
        }
        
        self.addSubview(self.contentView)
        
        
        self.contentView.addSubview(self.leftView)
        self.contentView.addSubview(self.centerView)
        self.contentView.addSubview(self.rightView)
        
        self.contentView.contentSize = CGSize(width: self.bounds.size.width*3, height: self.bounds.size.height)
        let offset_y = self.contentView.contentOffset.y
        self.contentView.setContentOffset(CGPoint(x: self.bounds.size.width, y: offset_y), animated: false)

        layoutSubview(zoomRate: 0.0)
    }
    
    //布局子视图
    private func layoutSubview(zoomRate: CGFloat) {
        
        let sizeWidth = self.bounds.size.width
        let sizeHeight = self.bounds.size.height
        
        self.leftCenterPoint = CGPoint(x: sizeWidth/2.0, y: sizeHeight/2.0)
        self.centerCenterPoint = CGPoint(x: sizeWidth*3/2.0, y: sizeHeight/2.0)
        self.rightCenterPoint = CGPoint(x: sizeWidth*5/2.0, y: sizeHeight/2.0)
        
        switch self.mapViewStyle {
         
        case .commen: //普通样式
            
            self.leftView.frame = CGRect(x: 0, y: 0, width: sizeWidth, height: sizeHeight)
            self.centerView.frame = CGRect(x: sizeWidth, y: 0, width: sizeWidth, height: sizeHeight)
            self.rightView.frame = CGRect(x: sizeWidth*2, y: 0, width: sizeWidth, height: sizeHeight)
            
            self.leftView.center = self.leftCenterPoint
            self.centerView.center = self.centerCenterPoint
            self.rightView.center = self.rightCenterPoint

        case .zoom: //缩放样式
            
            self.layer.masksToBounds = false
            self.contentView.layer.masksToBounds = false
            self.leftView.layer.masksToBounds = false
            self.centerView.layer.masksToBounds = false
            self.rightView.layer.masksToBounds = false

            self.centerView.frame = CGRect(x: 0, y: 0, width: sizeWidth*(self.zoomRate - abs(zoomRate)), height: sizeHeight*(self.zoomRate - abs(zoomRate)))
            if zoomRate > 0 {
                self.rightView.frame = CGRect(x: sizeWidth, y: 0, width: sizeWidth*(1 + zoomRate), height: sizeHeight*(1 + zoomRate))
            } else {
                self.leftView.frame = CGRect(x: sizeWidth*2, y: 0, width: sizeWidth*(1 - zoomRate), height: sizeHeight*(1 - zoomRate))
            }
            
            self.leftView.center = self.leftCenterPoint
            self.centerView.center = self.centerCenterPoint
            self.rightView.center = self.rightCenterPoint
        }
    }
}

//MARK: - 设置数据 -
extension LLJCarouselMapView {
    
    //设置数据
    private func setDataSource() {
        
        self.viewList.removeAll()
        
        switch self.contentViewStyle {
        
        case .image:
            
            if self.iamgeArray.count == 0 {
                return
            }
            
            for item in self.iamgeArray {
                
                let subView = UIImageView(frame: self.bounds)
                
                if item is String {
                    let item = item as! String
                    if item.hasPrefix("http") {
                        let url = URL(string: item)
                        subView.kf.setImage(with: url, placeholder: LLJSHelper.getImageByColorAndSize(LLJRandomColor(), subView.bounds.size), options:nil , progressBlock: nil, completionHandler: nil)
                    } else if item.hasPrefix("file") {
                        let url = URL(fileURLWithPath: item)
                        subView.kf.setImage(with: url, placeholder: LLJSHelper.getImageByColorAndSize(LLJRandomColor(), subView.bounds.size), options:nil , progressBlock: nil, completionHandler: nil)
                    }
                } else if item is UIImage {
                    let item = item as! UIImage
                    subView.image = item
                }
                
                self.viewList.append(subView)
            }
            //刷新
            reloadData()
            
        case .custom:
            
            if _sourceCount == 0 {
                return
            }
            
            for _ in stride(from: 0, to: _sourceCount, by: 1) {
                
                let subClass = self.contentSubViewClass as! UIView.Type
                let subView: UIView = subClass.init()
                subView.frame = self.bounds
                self.viewList.append(subView)
            }
            //刷新
            reloadData()
        }
    }
    
    //刷新数据
    private func reloadData() {
                
        var leftIndex: Int?
        var centerIndex: Int?
        var rightIndex: Int?
        
        if currentIndex == 0 {
            
            leftIndex = self.viewList.count - 1
            centerIndex = currentIndex
            rightIndex = currentIndex + 1
        } else if (currentIndex == self.viewList.count - 1) {
    
            leftIndex = currentIndex - 1
            centerIndex = currentIndex
            rightIndex = 0
        } else {
            
            leftIndex = currentIndex - 1
            centerIndex = currentIndex
            rightIndex = currentIndex + 1
        }
        
        self.leftView.subviews.forEach {$0.removeFromSuperview()}
        self.centerView.subviews.forEach {$0.removeFromSuperview()}
        self.rightView.subviews.forEach {$0.removeFromSuperview()}

        let leftView = self.delegate?.didScorllToView(subView: self.viewList[leftIndex!], index: leftIndex!) ?? UIView();
        let centerView = self.delegate?.didScorllToView(subView: self.viewList[centerIndex!], index: centerIndex!) ?? UIView();
        let rightView = self.delegate?.didScorllToView(subView: self.viewList[rightIndex!], index: rightIndex!) ?? UIView();

        self.leftView.addSubview(leftView)
        self.centerView.addSubview(centerView)
        self.rightView.addSubview(rightView)
        
        leftView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.leftView)
        }
        centerView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.centerView)
        }
        rightView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.rightView)
        }
    }
}

//MARK: - ScrollViewDelegate -
extension LLJCarouselMapView: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        scrollView.canCancelContentTouches = true;
        let _x = scrollView.contentOffset.x - self.stepWidth
        let _rx = _x/self.stepWidth
        //重新布局
        if self.mapViewStyle == .zoom {
            layoutSubview(zoomRate: _rx*(self.zoomRate - 1))
        }
        //刷新数据
        if (_x == self.stepWidth || _x == -self.stepWidth) && self.viewList.count > 0 {
            
            let _x = scrollView.contentOffset.x - self.stepWidth
            if _x > 0 {
                if self.currentIndex == self.viewList.count - 1 {
                    self.currentIndex = 0
                } else {
                    self.currentIndex += 1
                }
            } else {
                if self.currentIndex == 0 {
                    self.currentIndex = self.viewList.count - 1
                } else {
                    self.currentIndex -= 1
                }
            }
            
            //刷新数据
            reloadData()
            //重设offset
            let offset_y = self.contentView.contentOffset.y
            self.contentView.setContentOffset(CGPoint(x: self.bounds.size.width, y: offset_y), animated: false)
            scrollView.canCancelContentTouches = true;
        }
    }
}
