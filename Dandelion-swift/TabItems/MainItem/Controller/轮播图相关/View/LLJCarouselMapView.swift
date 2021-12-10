//
//  LLJCarouselMapView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/6/1.
//

import UIKit

//MARK: - 代理 -
protocol LLJCarouselMapViewDelegate: NSObjectProtocol {
    
    func didSelectItem(superView: UIView, subView: UIView?, currentIndex: Int)
    func didScorllToView(superView: UIView, subView: UIView, index: Int, currentIndex: Int) -> UIView
}

enum LLJCarouselMapViewStyle {
    case commen    //正常轮播
    case zoom      //缩放轮播
    case fold      //折叠轮播
}

//内容是图片还是自定义view
enum LLJCarouselMapContentViewStyle {
    case image      //图片
    case custom     //自定义view
}

//滚动方向
enum LLJCarouselMapViewRollDirection {
    case top        //上
    case left       //左
    case bottom     //下
    case right      //右
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
    
    lazy var leftLeftView: UIImageView = {
        let contentView = UIImageView()
        contentView.isUserInteractionEnabled = true
        return contentView
    }()
    
    lazy var leftView: UIImageView = {
        let contentView = UIImageView()
        contentView.isUserInteractionEnabled = true
        return contentView
    }()
    
    lazy var centerView: UIImageView = {
        let contentView = UIImageView()
        contentView.frame = CGRect.zero
        contentView.isUserInteractionEnabled = true
        return contentView
    }()
    
    lazy var rightView: UIImageView = {
        let contentView = UIImageView()
        contentView.isUserInteractionEnabled = true
        return contentView
    }()
    
    lazy var rightRightView: UIImageView = {
        let contentView = UIImageView()
        contentView.isUserInteractionEnabled = true
        return contentView
    }()
    
    //定时器
    var timer: DispatchSourceTimer?
    
    
    
    //左左中心
    private var leftLeftCenterPoint: CGPoint = CGPoint.zero
    //左中心
    private var leftCenterPoint: CGPoint = CGPoint.zero
    //中中心
    private var centerCenterPoint: CGPoint = CGPoint.zero
    //右中心
    private var rightCenterPoint: CGPoint = CGPoint.zero
    //右右中心
    private var rightRightCenterPoint: CGPoint = CGPoint.zero
    //缩放比例
    private var zoomRate: CGFloat = 1.0
    //当前显示index
    private var currentIndex: Int = 0
    //轮播样式
    private var mapViewStyle: LLJCarouselMapViewStyle = .commen
    //内容样式
    private var contentViewStyle: LLJCarouselMapContentViewStyle = .image
    //滚动方向
    private var rollDirection: LLJCarouselMapViewRollDirection = .right
    //滚动步距
    private var stepWidth: CGFloat = 0.0
    //offset_y
    private var offset_y: CGFloat = 0.0
    //手势开始
    private var animationStart: Bool = false
    //左路线
    private var leftPath: UIBezierPath?
    //右路线
    private var rightPath: UIBezierPath?
    //左动画
    private var leftAnimation: CAKeyframeAnimation?
    //右动画
    private var rightAnimation: CAKeyframeAnimation?

    
    
    
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
    //默认开启自动轮播
    private var _autoScrollEnable: Bool = true
    //自动滚动间隔
    private var _autoScorllSpaceTime: CFTimeInterval = 2.0
    //viewTag
    private var _viewTag: Int = 0
    //圆角
    private var _contentViewCornerRadius: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setUpUI()
    }
    
    init(frame: CGRect, mapViewStyle: LLJCarouselMapViewStyle, contentViewStyle: LLJCarouselMapContentViewStyle, rollDirection: LLJCarouselMapViewRollDirection) {
        super.init(frame: frame)
        
        self.mapViewStyle = mapViewStyle
        self.contentViewStyle = contentViewStyle
        self.rollDirection = rollDirection

        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //释放
    deinit {
        self.timer?.cancel()
    }
}

//MARK: - 计算属性 -
extension LLJCarouselMapView {
    
    //轮播数据
    var imageArray: [Any] {
        set {
            
            _imageArray = newValue
            
            if self.contentViewStyle == .image {
                _sourceCount = self.imageArray.count
            }
            
            reloadData()
        }
        get {
            return _imageArray
        }
    }
    
    var sourceCount: Int {
        set {
            
            if self.contentViewStyle == .custom {
                _sourceCount = newValue
            }
            
            reloadData()
        }
        get {
            return _sourceCount
        }
    }
    
    var contentSubViewClass: AnyClass {
        set {
            _contentSubViewClass = newValue

            reloadData()
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
    
    var autoScrollEnable: Bool {
        set {
            _autoScrollEnable = newValue
            //重设定时器
            reSetTimer(autoScrollEnable: _autoScrollEnable)
        }
        get {
            return _autoScrollEnable
        }
    }
    
    var autoScorllSpaceTime: CFTimeInterval {
        set {
            _autoScorllSpaceTime = newValue
            //重设定时器
            reSetTimer(autoScrollEnable: _autoScrollEnable)
        }
        get {
            return _autoScorllSpaceTime
        }
    }
    
    var viewTag: Int {
        set {
            _viewTag = newValue
            //刷新数据
            reloadData()
        }
        get {
            return _viewTag
        }
    }
    
    var contentViewCornerRadius: CGFloat {
        set {
            _contentViewCornerRadius = newValue
            //设置圆角
            setContentViewCornerRadius()
        }
        get {
            return _contentViewCornerRadius
        }
    }
}

//MARK: - UI -
extension LLJCarouselMapView {
    
    //UI + 计算各默认值
    private func setUpUI() {
        
        switch self.mapViewStyle {
        case .commen:
            
            switch self.rollDirection {
            case .left,.right:
                
                //scrollview frame
                contentView.frame = self.bounds
                //滚动步距
                stepWidth = self.contentView.frame.size.width
                //contentSize
                contentView.contentSize = CGSize(width: stepWidth*5, height: self.bounds.size.height)
                //offset_y
                offset_y = self.contentView.contentOffset.y
                //滚动到居中位置
                contentView.setContentOffset(CGPoint(x: stepWidth*2, y: offset_y), animated: false)
                
                _largeSize = self.contentView.bounds.size
                _smallSize = self.contentView.bounds.size
                _itemSpace = 0.0
                zoomRate = 0.0
                
                self.leftLeftCenterPoint = CGPoint(x: stepWidth/2.0, y: self.largeSize.height/2.0)
                self.leftCenterPoint = CGPoint(x: stepWidth*3/2.0, y: self.largeSize.height/2.0)
                self.centerCenterPoint = CGPoint(x: stepWidth*5/2.0, y: self.largeSize.height/2.0)
                self.rightCenterPoint = CGPoint(x: stepWidth*7/2.0, y: self.largeSize.height/2.0)
                self.rightRightCenterPoint = CGPoint(x: stepWidth*9/2.0, y: self.largeSize.height/2.0)
                
            case .top,.bottom:
                
                //scrollview frame
                contentView.frame = self.bounds
                //滚动步距
                stepWidth = self.contentView.frame.size.height
                //contentSize
                contentView.contentSize = CGSize(width: self.bounds.height, height: stepWidth*5)
                //offset_x
                offset_y = self.contentView.contentOffset.x
                //滚动到居中位置
                contentView.setContentOffset(CGPoint(x: offset_y, y: stepWidth*2), animated: false)
                
                _largeSize = self.contentView.bounds.size
                _smallSize = self.contentView.bounds.size
                _itemSpace = 0.0
                zoomRate = 0.0
                
                self.leftLeftCenterPoint = CGPoint(x: self.largeSize.width/2.0, y: stepWidth/2.0)
                self.leftCenterPoint = CGPoint(x: self.largeSize.width/2.0, y: stepWidth*3/2.0)
                self.centerCenterPoint = CGPoint(x: self.largeSize.width/2.0, y: stepWidth*5/2.0)
                self.rightCenterPoint = CGPoint(x: self.largeSize.width/2.0, y: stepWidth*7/2.0)
                self.rightRightCenterPoint = CGPoint(x: self.largeSize.width/2.0, y: stepWidth*9/2.0)
            }
            
        case .zoom:
            
            if self.largeSize.width == 0 || self.smallSize.width == 0 {
                return
            }
            self.contentView.layer.masksToBounds = false
            self.layer.masksToBounds = true
            
            switch self.rollDirection {
            case .left,.right:
                
                //contentSize
                let contentSize_width = ((self.largeSize.width - self.smallSize.width)/2.0 + itemSpace)*6 + self.smallSize.width*5
                //滚动步距
                stepWidth = contentSize_width/5.0
                //scrollview frame
                contentView.frame = CGRect(x: 0, y: 0, width: stepWidth, height: self.largeSize.height)
                contentView.center = CGPoint(x: self.bounds.width/2.0, y: self.bounds.height/2.0)
                contentView.contentSize = CGSize(width: contentSize_width, height: self.largeSize.height)
                //offset_y
                offset_y = self.contentView.contentOffset.y
                //滚动到居中位置
                contentView.setContentOffset(CGPoint(x: stepWidth*2, y: offset_y), animated: false)
                //zoomRate
                zoomRate = self.largeSize.width/self.smallSize.width
                
                self.leftLeftCenterPoint = CGPoint(x: stepWidth/2.0, y: self.largeSize.height/2.0)
                self.leftCenterPoint = CGPoint(x: stepWidth*3/2.0, y: self.largeSize.height/2.0)
                self.centerCenterPoint = CGPoint(x: stepWidth*5/2.0, y: self.largeSize.height/2.0)
                self.rightCenterPoint = CGPoint(x: stepWidth*7/2.0, y: self.largeSize.height/2.0)
                self.rightRightCenterPoint = CGPoint(x: stepWidth*9/2.0, y: self.largeSize.height/2.0)
                
            case .top,.bottom:

                //contentSize
                let contentSize_width = ((self.largeSize.height - self.smallSize.height)/2.0 + itemSpace)*6 + self.smallSize.height*5
                //滚动步距
                stepWidth = contentSize_width/5.0
                //scrollview frame
                contentView.frame = CGRect(x: 0, y: 0, width: self.largeSize.width, height: stepWidth)
                contentView.center = CGPoint(x: self.bounds.width/2.0, y: self.bounds.height/2.0)
                contentView.contentSize = CGSize(width: self.largeSize.width, height: contentSize_width)
                //offset_y
                offset_y = self.contentView.contentOffset.x
                //滚动到居中位置
                contentView.setContentOffset(CGPoint(x: offset_y, y: stepWidth*2), animated: false)
                //zoomRate
                zoomRate = self.largeSize.height/self.smallSize.height
                
                self.leftLeftCenterPoint = CGPoint(x: self.largeSize.width/2.0, y: stepWidth/2.0)
                self.leftCenterPoint = CGPoint(x: self.largeSize.width/2.0, y: stepWidth*3/2.0)
                self.centerCenterPoint = CGPoint(x: self.largeSize.width/2.0, y: stepWidth*5/2.0)
                self.rightCenterPoint = CGPoint(x: self.largeSize.width/2.0, y: stepWidth*7/2.0)
                self.rightRightCenterPoint = CGPoint(x: self.largeSize.width/2.0, y: stepWidth*9/2.0)
            }
            
        case .fold:
            
            if self.largeSize.width == 0 || self.smallSize.width == 0 {
                return
            }
            self.contentView.layer.masksToBounds = false
            self.layer.masksToBounds = true
            
            //滚动步距
            stepWidth = itemSpace
            //contentSize
            let contentSize_width = self.largeSize.height + stepWidth*4
            //scrollview frame
            contentView.frame = CGRect(x: 0, y: 0, width: self.largeSize.width, height: self.largeSize.height)
            contentView.center = CGPoint(x: self.bounds.width/2.0, y: self.bounds.height/2.0)
            contentView.contentSize = CGSize(width: self.largeSize.width, height: contentSize_width)
            contentView.isScrollEnabled = false
            //offset_y
            offset_y = self.contentView.contentOffset.x
            //滚动到居中位置
            contentView.setContentOffset(CGPoint(x: offset_y, y: 0.0), animated: false)
            //zoomRate
            zoomRate = self.largeSize.height/self.smallSize.height
            
            self.rightRightCenterPoint = CGPoint(x: self.largeSize.width/2.0, y: self.largeSize.height/2.0)
            self.rightCenterPoint = CGPoint(x: self.largeSize.width/2.0, y: self.largeSize.height/2.0 + stepWidth/2.0)
            self.centerCenterPoint = CGPoint(x: self.largeSize.width/2.0, y: self.largeSize.height/2.0 + stepWidth)
            self.leftCenterPoint = CGPoint(x: self.largeSize.width/2.0, y: self.largeSize.height/2.0 + stepWidth*3/2.0)
            self.leftLeftCenterPoint = CGPoint(x: self.largeSize.width/2.0, y: self.largeSize.height/2.0 + stepWidth*2.0)

            
            addGesRecognizier(subView: self.rightRightView)
        }
        
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.leftLeftView)
        self.contentView.addSubview(self.leftView)
        self.contentView.addSubview(self.centerView)
        self.contentView.addSubview(self.rightView)
        self.contentView.addSubview(self.rightRightView)
        
        //布局
        layoutSubview(zoomRate: 0.0)
        //刷新数据
        reloadData()
        //开启定时器
        self.autoScrollEnable = true
    }
    
    //布局子视图
    private func layoutSubview(zoomRate: CGFloat) {
        
        switch self.mapViewStyle {
         
        case .commen: //普通样式
            
            if self.centerView.frame.size.width == 0 {
                switch self.rollDirection {
                case .left,.right:
                    
                    self.leftLeftView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width, height: self.smallSize.height)
                    self.leftView.frame = CGRect(x: stepWidth, y: 0, width: self.smallSize.width, height: self.smallSize.height)
                    self.centerView.frame = CGRect(x: stepWidth*2, y: 0, width: self.largeSize.width, height: self.largeSize.height)
                    self.rightView.frame = CGRect(x: stepWidth*3, y: 0, width: self.smallSize.width, height: self.smallSize.height)
                    self.rightRightView.frame = CGRect(x: stepWidth*4, y: 0, width: self.smallSize.width, height: self.smallSize.height)
                    
                case .top,.bottom:
                    
                    self.leftLeftView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width, height: self.smallSize.height)
                    self.leftView.frame = CGRect(x: 0, y: stepWidth, width: self.smallSize.width, height: self.smallSize.height)
                    self.centerView.frame = CGRect(x: 0, y: stepWidth*2, width: self.largeSize.width, height: self.largeSize.height)
                    self.rightView.frame = CGRect(x: 0, y: stepWidth*3, width: self.smallSize.width, height: self.smallSize.height)
                    self.rightRightView.frame = CGRect(x: 0, y: stepWidth*4, width: self.smallSize.width, height: self.smallSize.height)
                }
            }

        case .zoom: //缩放样式
            
            switch self.rollDirection {
            case .left,.right:
                
                self.centerView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width*(self.zoomRate - abs(zoomRate)), height: self.smallSize.height*(self.zoomRate - abs(zoomRate)))
                if zoomRate > 0 {
                    self.rightRightView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width, height: self.smallSize.height)
                    self.rightView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width*(1 + zoomRate), height: self.smallSize.height*(1 + zoomRate))
                    self.leftView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width, height: self.smallSize.height)
                    self.leftLeftView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width, height: self.smallSize.height)

                } else {
                    self.rightRightView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width, height: self.smallSize.height)
                    self.rightView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width, height: self.smallSize.height)
                    self.leftView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width*(1 - zoomRate), height: self.smallSize.height*(1 - zoomRate))
                    self.leftLeftView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width, height: self.smallSize.height)
                }
                
            case .top,.bottom:
                
                self.centerView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width*(self.zoomRate - abs(zoomRate)), height: self.smallSize.height*(self.zoomRate - abs(zoomRate)))
                if zoomRate > 0 {
                    self.rightRightView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width, height: self.smallSize.height)
                    self.rightView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width*(1 + zoomRate), height: self.smallSize.height*(1 + zoomRate))
                    self.leftView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width, height: self.smallSize.height)
                    self.leftLeftView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width, height: self.smallSize.height)

                } else {
                    self.rightRightView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width, height: self.smallSize.height)
                    self.rightView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width, height: self.smallSize.height)
                    self.leftView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width*(1 - zoomRate), height: self.smallSize.height*(1 - zoomRate))
                    self.leftLeftView.frame = CGRect(x: 0, y: 0, width: self.smallSize.width, height: self.smallSize.height)
                }
                
            }
            
        case .fold:
            
            self.rightRightView.frame = CGRect(x: 0, y: 0, width: self.largeSize.width, height: self.largeSize.height)
            self.rightView.frame = CGRect(x: 0, y: 0, width: self.largeSize.width - self.itemSpace*(1 - zoomRate), height: self.largeSize.height)
            self.centerView.frame = CGRect(x: 0, y: 0, width: self.largeSize.width - self.itemSpace - self.itemSpace*(1 - zoomRate), height: self.largeSize.height)
            self.leftView.frame = CGRect(x: 0, y: 0, width: self.largeSize.width - 2*self.itemSpace, height: self.largeSize.height)
            self.leftLeftView.frame = CGRect(x: 0, y: 0, width: self.largeSize.width - 2*self.itemSpace, height: self.largeSize.height)
            self.leftView.alpha = zoomRate
            LLJLog(self.leftView.alpha)
            self.leftLeftView.alpha = 0.0
        }
        
        self.leftLeftView.center = self.leftLeftCenterPoint
        self.rightRightView.center = self.rightRightCenterPoint
        self.leftView.center = self.leftCenterPoint
        self.centerView.center = self.centerCenterPoint
        self.rightView.center = self.rightCenterPoint
    }
    
    //圆角
    private func setContentViewCornerRadius() {

        setCornerRadius(subView: self.leftLeftView)
        setCornerRadius(subView: self.leftView)
        setCornerRadius(subView: self.centerView)
        setCornerRadius(subView: self.rightView)
        setCornerRadius(subView: self.rightRightView)
    }
    private func setCornerRadius(subView: UIView?) {
        
        subView?.layer.masksToBounds = true
        subView?.layer.cornerRadius = self.contentViewCornerRadius
    }
    
    //添加手势
    private func addGesRecognizier(subView: UIView?) {
        
        subView?.gestureRecognizers?.removeAll()
        let leftSwipe = UISwipeGestureRecognizer()
        leftSwipe.direction = .left
        leftSwipe.addTarget(self, action: #selector(swipeAction))
        subView?.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer()
        rightSwipe.direction = .right
        rightSwipe.addTarget(self, action: #selector(swipeAction))
        subView?.addGestureRecognizer(rightSwipe)
    }
}

//MARK: - 设置数据 -
extension LLJCarouselMapView {
    
    //刷新数据
    private func reloadData() {
        
        if _sourceCount == 0 {
            return
        }
        
        var leftLeftIndex: Int = 0
        var leftIndex: Int = 0
        var centerIndex: Int = 0
        var rightIndex: Int = 0
        var rightRightIndex: Int = 0

        if self.mapViewStyle == .fold {
            
            leftLeftIndex = self.reSetIndex(index: currentIndex + 4)
            leftIndex = self.reSetIndex(index: currentIndex + 3)
            centerIndex = self.reSetIndex(index: currentIndex + 2)
            rightIndex = self.reSetIndex(index: currentIndex + 1)
            rightRightIndex = self.reSetIndex(index: currentIndex)
            
        } else{
            
            leftLeftIndex = self.reSetIndex(index: currentIndex - 2)
            leftIndex = self.reSetIndex(index: currentIndex - 1)
            centerIndex = self.reSetIndex(index: currentIndex)
            rightIndex = self.reSetIndex(index: currentIndex + 1)
            rightRightIndex = self.reSetIndex(index: currentIndex + 2)
        }
        
        setDataSource(subView: self.leftLeftView, index: leftLeftIndex)
        setDataSource(subView: self.leftView, index: leftIndex)
        setDataSource(subView: self.centerView, index: centerIndex)
        setDataSource(subView: self.rightView, index: rightIndex)
        setDataSource(subView: self.rightRightView, index: rightRightIndex)
    }
    
    //设置数据
    private func setDataSource(subView: UIView, index: Int) {
        
        subView.subviews.forEach {$0.removeFromSuperview()}
        subView.subviews.forEach {$0.snp.removeConstraints()}

        if self.contentViewStyle == .image {
            //图片设置数据
            let subView = subView as! UIImageView
            let item = self.imageArray[index]
            if item is String {
                let item = item as! String
                if item.hasPrefix("http") {
                    //let url = URL(string: item)
                    subView.image = LLJSHelper.getImageByColorAndSize(LLJRandomColor(), subView.bounds.size)
                    //subView.kf.setImage(with: url, placeholder: LLJSHelper.getImageByColorAndSize(LLJRandomColor(), subView.bounds.size), options:nil , progressBlock: nil, completionHandler: nil)
                } else if item.hasPrefix("file") {
                    //let url = URL(fileURLWithPath: item)
                    subView.image = LLJSHelper.getImageByColorAndSize(LLJRandomColor(), subView.bounds.size)
                    //subView.kf.setImage(with: url, placeholder: LLJSHelper.getImageByColorAndSize(LLJRandomColor(), subView.bounds.size), options:nil , progressBlock: nil, completionHandler: nil)
                }
            } else if item is UIImage {
                let item = item as! UIImage
                subView.image = item
            }
        } else {
            //自定义view设置数据
            let subClass = self.contentSubViewClass as! UIView.Type
            var subContentView = subClass.init()
            if ((self.delegate?.didScorllToView(superView: self, subView: subContentView, index: index, currentIndex: currentIndex)) != nil) {
                subContentView = self.delegate?.didScorllToView(superView: self, subView: subContentView, index: index, currentIndex: currentIndex) ?? UIView()
            }

            subView.addSubview(subContentView)
            subContentView.snp_makeConstraints { (make) in
                make.edges.equalTo(subView)
            }
        }
        
        let selectButton = UIButton(type: UIButton.ButtonType.custom)
        selectButton.addTarget(self, action: #selector(buttonClick), for: UIControl.Event.touchUpInside)
        subView.addSubview(selectButton)
        selectButton.snp_makeConstraints { (make) in
            make.edges.equalTo(subView)
        }
    }
    
    //重新计算index
    private func reSetIndex(index: Int) -> Int {
        
        if index < 0 {
            return index + _sourceCount
        } else if (index > _sourceCount - 1) {
            return index - _sourceCount
        } else {
            return index
        }
    }
}

//MARK: - ScrollViewDelegate -
extension LLJCarouselMapView: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

        reSetTimer(autoScrollEnable: false)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        reSetTimer(autoScrollEnable: _autoScrollEnable)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var _x: CGFloat = 0.0
        var _rx: CGFloat = 0.0
        
        if self.mapViewStyle == .fold {
            
            _rx = scrollView.contentOffset.y/(stepWidth/2) > 1.0 ? 1.0 : scrollView.contentOffset.y/(stepWidth/2)

            layoutSubview(zoomRate: _rx)

            if _rx == 1 {
                
                if self.currentIndex == _sourceCount - 1 {
                    self.currentIndex = 0
                } else {
                    self.currentIndex += 1
                }
                
                //刷新数据
                reloadData()
                //重设offset
                self.rightRightView.layer.removeAllAnimations()
                self.contentView.setContentOffset(CGPoint(x: offset_y, y: 0.0), animated: false)
                //重新布局
                layoutSubview(zoomRate: 0.0)
                animationStart = false
            }
        } else {
            
            switch self.rollDirection {
            case .left,.right:
                
                _x = scrollView.contentOffset.x - stepWidth*2
                
            case .top,.bottom:
                
                _x = scrollView.contentOffset.y - stepWidth*2
            }
            
            _rx = _x/self.stepWidth
            
            //重新布局
            if self.mapViewStyle == .zoom {
                layoutSubview(zoomRate: _rx*(self.zoomRate - 1))
            }
            
            //刷新数据
            if abs(_rx) >= 0.99 && _sourceCount > 0 {
                
                if _x > 0 {
                    if self.currentIndex == _sourceCount - 1 {
                        self.currentIndex = 0
                    } else {
                        self.currentIndex += 1
                    }
                } else {
                    if self.currentIndex == 0 {
                        self.currentIndex = _sourceCount - 1
                    } else {
                        self.currentIndex -= 1
                    }
                }
                
                //刷新数据
                reloadData()
                //重设offset
                switch self.rollDirection {
                case .left,.right:
                    
                    self.contentView.setContentOffset(CGPoint(x: stepWidth*2, y: offset_y), animated: false)

                case .top,.bottom:
                    
                    self.contentView.setContentOffset(CGPoint(x: offset_y, y: stepWidth*2), animated: false)
                }
                //重新布局
                layoutSubview(zoomRate: 0.0)
            }
        }
    }
}

//MARK: - 定时器 -
extension LLJCarouselMapView {
    
    private func reSetTimer(autoScrollEnable: Bool) {
        
        if self.mapViewStyle == .fold {
            return
        }
        
        //先取消
        timerCancel()
        //取消延时发送的方法
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        if autoScrollEnable {
            self.perform(#selector(timerSetUp), with: nil, afterDelay: 1.0)
        }
    }
    
    @objc private func timerSetUp() {
        
        var offset: CGPoint = CGPoint.zero
        switch self.rollDirection {
        case .left:
            offset = CGPoint(x: self.stepWidth*3, y: self.offset_y)
        case .right:
            offset = CGPoint(x: self.stepWidth, y: self.offset_y)
        case .top:
            offset = CGPoint(x: offset_y, y: self.stepWidth*3)
        case .bottom:
            offset = CGPoint(x: offset_y, y: self.stepWidth)
        }
        
        weak var weakSelf = self
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer.schedule(deadline: .now(), repeating: self.autoScorllSpaceTime)
        timer.setEventHandler {
            DispatchQueue.main.async {
                weakSelf?.contentView.setContentOffset(offset, animated: true)
            }
        }
        self.timer = timer
        self.timer?.resume()
    }
    
    private func timerCancel() {
        self.timer?.cancel()
        self.timer = nil
    }
}

//MARK: - 点击事件 -
extension LLJCarouselMapView: CAAnimationDelegate {
    
    //点击事件
    @objc private func buttonClick() {
        
        var selectView: UIView?
        if self.contentViewStyle == .image {
            selectView = self.centerView
        } else if self.contentViewStyle == .custom {
            selectView = self.centerView.subviews.first
        }
        self.delegate?.didSelectItem(superView: self, subView: selectView, currentIndex: currentIndex)
    }
    
    //平移事件
    @objc private func swipeAction(ges: UISwipeGestureRecognizer) {
        
        if !animationStart {
            
            animationStart = true
            var path: UIBezierPath?
            var animation: CAKeyframeAnimation?
            
            switch ges.direction {
            case .left:
                if (self.leftAnimation == nil) {
                    path = LLJBezierPath.drawoQuadCurve(startPoint: self.rightRightView.center, endPoint: CGPoint(x: -SCREEN_WIDTH, y: self.rightRightCenterPoint.y - 50), controlPoint: CGPoint(x: 100, y: 10))
                    
                    animation = LLJAnimation.keyframeAnimation(keyPath: "position", values: nil, path: path!.cgPath, keyTimes: nil, duration: 0.25, timingFunctions: [CAMediaTimingFunction(name: .easeIn)], fillMode: CAMediaTimingFillMode.forwards, removedOnCompletion: false)
                    animation?.delegate = self
                    self.leftAnimation = animation
                }
                self.rightRightView.layer.add(self.leftAnimation!, forKey: "keyAniamtion")
                
            case .right:
                if self.rightAnimation == nil {
                    path = LLJBezierPath.drawoQuadCurve(startPoint: self.rightRightView.center, endPoint: CGPoint(x: SCREEN_WIDTH + self.rightRightView.bounds.width, y: self.rightRightCenterPoint.y - 50), controlPoint: CGPoint(x: SCREEN_WIDTH - 100, y: 10))
                    
                    animation = LLJAnimation.keyframeAnimation(keyPath: "position", values: nil, path: path!.cgPath, keyTimes: nil, duration: 0.25, timingFunctions: [CAMediaTimingFunction(name: .easeIn)], fillMode: CAMediaTimingFillMode.forwards, removedOnCompletion: false)
                    animation?.delegate = self
                    self.rightAnimation = animation
                }
                self.rightRightView.layer.removeAllAnimations()
                self.rightRightView.layer.add(self.rightAnimation!, forKey: "keyAniamtion")
                
            default:break
            }
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
                
        self.contentView.setContentOffset(CGPoint(x: offset_y, y: stepWidth/2.0), animated: true)
    }
}
