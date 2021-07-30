//
//  LLJFWeChatCycleController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/6/22.
//

import UIKit

class LLJFWeChatCycleController: LLJFViewController {
    
    //MARK:懒加载属性
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: UITableView.Style.plain)
        tableView.register(LLJWCommenCell.self, forCellReuseIdentifier: "LLJWCommenCell")
        tableView.register(LLJWCycleImageCell.self, forCellReuseIdentifier: "LLJWCycleImageCell")
        tableView.register(LLJWebLinkCell.self, forCellReuseIdentifier: "LLJWebLinkCell")
        tableView.register(LLJCycleVideoCell.self, forCellReuseIdentifier: "LLJCycleVideoCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        return tableView
    }()
    
    private lazy var alertView: LLJAlertView = {
        let alertView = LLJAlertView()
        weak var weakSelf = self
        alertView.selectRow = {(row, name) in
            weakSelf!.alertAction(row: row, name: name)
        }
        return alertView
    }()
    
    private lazy var zanView: LLJZanView = {
        let zanView = LLJZanView()
        return zanView
    }()
    
    private lazy var alertItemList1: Array<LLJAlertModel> = {
        var alertItemList: Array<LLJAlertModel> = []
        var model = LLJAlertModel()
        model.title = "拍摄"
        model.subTitle = "照片或视频"
        alertItemList.append(model)
        var model1 = LLJAlertModel()
        model1.title = "从相册中选择"
        alertItemList.append(model1)
        return alertItemList
    }()
    
    private lazy var alertItemList2: Array<LLJAlertModel> = {
        var alertItemList: Array<LLJAlertModel> = []
        var model = LLJAlertModel()
        model.title = "更换相册封面"
        alertItemList.append(model)
        return alertItemList
    }()

    lazy var attrAction: ASAttributedString.Action = {
        weak var weakSelf = self
        let custom = ASAttributedString.Action(.click, highlights: [.background(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))]) { (result) in
            weakSelf!.attrAction(result: result)
        }
        return custom
    }()
    
    private var navView: UIView?
    private var backButton: UIButton?
    private var camButton: UIButton?
    private var offset_y: CGFloat = 0.0
    private var titleLabel: UILabel?
    private var currentPage: Int = 0
    private var pageCount: Int = 100
    
    private var cycleSourceListArray: Array<Any> = []

    var useModel: LLJCycleUserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //UI
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

//MARK: - UITableViewDelegate 代理 -
extension LLJFWeChatCycleController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.cycleSourceListArray[indexPath.row] as! LLJCycleMessageModel
        return model.frameModel.rowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cycleSourceListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.cycleSourceListArray[indexPath.row] as! LLJCycleMessageModel
        
        var commenCell: LLJWCommenCell?
        if model.type == 10011 {
            //图片cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "LLJWCycleImageCell") as! LLJWCycleImageCell
            cell.setSubDataSource(sourceModel: model)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            commenCell = cell
        } else if model.type == 10012 {
            //视频cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "LLJCycleVideoCell") as! LLJCycleVideoCell
            cell.setSubDataSource(sourceModel: model)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            commenCell = cell
        } else if model.type == 10013 {
            //网址cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "LLJWebLinkCell") as! LLJWebLinkCell
            cell.setSubDataSource(sourceModel: model)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            commenCell = cell
        } else {
            //纯文字cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "LLJWCommenCell") as! LLJWCommenCell
            cell.setDataSource(sourceModel: model)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            commenCell = cell
        }
        //更多回调
        weak var weakSelf = self
        commenCell!.moreAction = { (zanView) in
            weakSelf!.zanView = zanView
        }
        //点赞和评论
        commenCell!.zanViewAction = { (type) in
            weakSelf?.zanAction(type: type, index: indexPath.row)
        }
        
        return commenCell!
    }
}

//MARK: - 设置数据 -
extension LLJFWeChatCycleController {
    
    //按钮事件
    @objc private func buttonClick(sender: UIButton) {
        
        switch sender.tag {
        case 100001:
            //返回
            self.navigationController?.popViewController(animated: true)
        case 100002:
            //发布朋友圈
            self.alertView.alertShow(itemList: self.alertItemList1)
        default:break
        }
    }
    //单机
    @objc private func tapClick() {
        //发布朋友圈
        self.alertView.alertShow(itemList: self.alertItemList1)
    }
    //长按
    @objc private func longTapClick() {
        let pushViewController = LLJCycleMessagePushController()
        pushViewController.type = .text
        pushViewController.model = self.useModel
        pushViewController.pushComplete = {
            self.getDataSource()
        }
        self.present(pushViewController, animated: true, completion: nil)
    }
    
    //alert事件
    private func alertAction(row: Int, name: String) {
        let pushViewController = LLJCycleMessagePushController()
        if row == 1 {
            pushViewController.type = .image
        } else {
            let array: [LLJCycleMessagePushType] = [.video,.link]
            let armnum = LLJSHelper.arc4random(duration: 2)
            pushViewController.type = array[armnum]
        }
        pushViewController.model = self.useModel
        weak var weakSelf = self
        pushViewController.pushComplete = {
            weakSelf!.currentPage = 0
            weakSelf!.cycleSourceListArray.removeAll()
            weakSelf!.getDataSource()
        }
        self.present(pushViewController, animated: true, completion: nil)
    }
    
    //获取数据
    private func getDataSource() {
       
        let listArray = LLJSCoreDataHelper.helper.getRosource(entityName: "LLJWeChatCycleModel", predicate: "")
        var sourceArray: [Any] = []
        for i in stride(from: 0, to: listArray.count, by: 1) {
            if i < listArray.count {
                let model = listArray[i]
                sourceArray.append(model)
            } else {
                break
            }
        }
        //排序
        sourceArray.sort { (item1, item2) -> Bool in
            let item1 = item1 as! LLJWeChatCycleModel
            let item2 = item2 as! LLJWeChatCycleModel
            return item1.timeInteval > item2.timeInteval
        }
        self.cycleSourceListArray = LLJCellFrameManage.setSubViewFrame(sourceList: sourceArray, value: self.attrAction)
        self.tableView.reloadData()
        currentPage += 1
    }
    
    
    //处理zanView
    private func zanAction(type: Int64, index: Int) {
        
        if type == 10001010 {
            let model = self.cycleSourceListArray[index] as! LLJCycleMessageModel
            let zanModel = LLJSCoreDataHelper.helper.createCoreDataModel(entityName: "LLJCycleZanModel") as! LLJCycleZanModel
            zanModel.aUserId = self.useModel!.userId!
            zanModel.aUserName = self.useModel!.nickName!
            zanModel.timeInterval = LLJSHelper.getCurrentTimeInteval()
            zanModel.type = type
            zanModel.userId = self.useModel!.userId!
            zanModel.messageId = model.messageId!
            LLJSCoreDataHelper.helper.insertRosource()
            
            getDataSource()
        } else {
            
        }
    }
    
    //富文本点击事件
    private func attrAction(result: ASAttributedString.Attribute.Result) {
        switch result.content {
        case .string(let value):
            print("按住了文本: \n\(value) \nrange: \(result.range)")
            
        case .attachment(let value):
            print("按住了附件: \n\(value) \nrange: \(result.range)")
        }
    }
}


//MARK: - UI -
extension LLJFWeChatCycleController {
   
    //UI
    private func setUpUI() {
        
        
        self.view.backgroundColor = LLJWhiteColor()
        //修改状态栏样式
        self.statusBarStyle = UIStatusBarStyle.lightContent
        //添加tableView
        self.view.addSubview(self.tableView)
        //设置head
        setUpHeadView()
        //获取本地数据
        getDataSource()
    }
    //头视图
    private func setUpHeadView() {
        
        let headView = UIView()
        headView.backgroundColor = LLJWhiteColor()
        headView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: LLJDX(260) + LLJTopHeight)
        self.tableView.tableHeaderView = headView
        
        let cycleHeadImage = UIImageView(image: UIImage(named: self.useModel!.headIamge!))
        cycleHeadImage.contentMode = UIImageView.ContentMode.scaleAspectFit
        cycleHeadImage.backgroundColor = UIColor.red
        headView.addSubview(cycleHeadImage)
        cycleHeadImage.snp_makeConstraints { (make) in
            make.centerX.equalTo(headView.snp_centerX)
            make.top.equalTo(headView.snp_top).offset(-LLJTopHeight)
            make.bottom.equalTo(headView.snp_bottom).offset(-LLJTopHeight + LLJDX(20))
        }
        
        let perHeadImage = UIImageView(image: UIImage(named: self.useModel!.userImage!))
        perHeadImage.layer.masksToBounds = true
        perHeadImage.layer.cornerRadius = 8.0
        headView.addSubview(perHeadImage)
        perHeadImage.snp_makeConstraints { (make) in
            make.width.equalTo(LLJDX(70))
            make.right.equalTo(headView.snp_right).offset(LLJDX(-13))
            make.height.equalTo(LLJDX(70))
            make.bottom.equalTo(headView.snp_bottom).offset(-LLJTopHeight + LLJDX(40))
        }
        
        let nickName = UILabel()
        nickName.font = LLJBoldFont(20)
        nickName.text = self.useModel!.nickName!
        nickName.textColor = LLJWhiteColor()
        headView.addSubview(nickName)
        nickName.snp_makeConstraints { (make) in
            make.right.equalTo(perHeadImage.snp_left).offset(-LLJDX(22))
            make.top.equalTo(perHeadImage.snp_top).offset(LLJDX(16))
        }
        
        let navView = UIView()
        navView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: LLJTopHeight)
        navView.backgroundColor = LLJColor(238.0, 238.0, 238.0, 0.0)
        self.view.addSubview(navView)
        self.navView = navView;
        
        let backButton = UIButton.init(type: UIButton.ButtonType.custom)
        backButton.setImage(UIImage(named: "fanhui_w"), for: UIControl.State.normal)
        backButton.setImage(UIImage(named: "fanhui_w"), for: UIControl.State.highlighted)
        backButton.addTarget(self, action: #selector(buttonClick(sender:)), for: UIControl.Event.touchUpInside)
        backButton.tag = 100001
        self.backButton = backButton
        self.navView?.addSubview(backButton)
        backButton.snp_makeConstraints { (make) in
            make.left.equalTo(navView.snp_left).offset(LLJDX(10))
            make.bottom.equalTo(navView.snp_bottom).offset(LLJDX(-8))
            make.height.equalTo(22)
            make.width.equalTo(22)
        }
        
        let camButton = UIButton.init(type: UIButton.ButtonType.custom)
        camButton.setImage(UIImage(named: "xiangji_w"), for: UIControl.State.normal)
        camButton.setImage(UIImage(named: "xiangji_w"), for: UIControl.State.highlighted)
        //单机
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        camButton.addGestureRecognizer(tap)
        //长按
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(longTapClick))
        camButton.addGestureRecognizer(longTap)
        self.camButton = camButton
        self.navView?.addSubview(camButton)
        camButton.snp_makeConstraints { (make) in
            make.right.equalTo(navView.snp_right).offset(-LLJDX(10))
            make.centerY.equalTo(backButton.snp_centerY)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        let titleLabel = UILabel()
        titleLabel.font = LLJBoldFont(18)
        titleLabel.text = "朋友圈"
        titleLabel.textColor = LLJBlackColor()
        titleLabel.isHidden = true
        self.titleLabel = titleLabel
        self.navView?.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(navView.snp_centerX)
            make.centerY.equalTo(backButton.snp_centerY)
        }
    }
}

//MARK: - UIScrollViewDelegate 代理 -
extension LLJFWeChatCycleController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.offset_y = scrollView.contentOffset.y
        if self.offset_y >= LLJDX(270) - LLJTopHeight {
            
            self.backButton?.isHidden = true
            self.camButton?.isHidden = true
            self.navView?.backgroundColor = LLJColor(238.0, 238.0, 238.0, 1.0)
            self.navView?.alpha = 0.0
            

            if self.offset_y > LLJDX(272) - LLJTopHeight {
                
                self.backButton?.isHidden = false
                self.camButton?.isHidden = false
                self.titleLabel?.isHidden = false
                
                self.camButton?.setImage(UIImage(named: "xiangji_b"), for: UIControl.State.normal)
                self.camButton?.setImage(UIImage(named: "xiangji_b"), for: UIControl.State.highlighted)
                self.backButton?.setImage(UIImage(named: "fanhui_b"), for: UIControl.State.normal)
                self.backButton?.setImage(UIImage(named: "fanhui_b"), for: UIControl.State.highlighted)
                
                //修改状态栏样式
                self.statusBarStyle = UIStatusBarStyle.default
                
                let dy = self.offset_y - LLJDX(272) + LLJTopHeight
                let newAlpha = dy/10 > 1.0 ? 1.0 : dy/10
                self.navView?.alpha = newAlpha
            }
            
        } else {
            
            //修改状态栏样式
            self.statusBarStyle = UIStatusBarStyle.lightContent
            
            self.camButton?.setImage(UIImage(named: "xiangji_w"), for: UIControl.State.normal)
            self.camButton?.setImage(UIImage(named: "xiangji_w"), for: UIControl.State.highlighted)
            self.backButton?.setImage(UIImage(named: "fanhui_w"), for: UIControl.State.normal)
            self.backButton?.setImage(UIImage(named: "fanhui_w"), for: UIControl.State.highlighted)
            
            self.titleLabel?.isHidden = true

            self.navView?.alpha = 1
            self.navView?.backgroundColor = LLJColor(238.0, 238.0, 238.0, 0.0)
            self.backButton?.isHidden = false
            self.camButton?.isHidden = false
        }
        
        //处理zanView
        if !self.zanView.isHidden {
            self.zanView.isHidden = true
        }
    }
}
