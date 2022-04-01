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
        tableView.register(LLJCycleLoadCell.self, forCellReuseIdentifier: "LLJCycleLoadCell")
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
    
    private lazy var zanView: LLJZanView = {
        let zanView = LLJZanView()
        return zanView
    }()
    
    private lazy var coverView: UIView = {
        let coverView = UIView()
        coverView.frame = kRootView.bounds
        coverView.isHidden = true
        kRootView.addSubview(coverView)
        return coverView
    }()
    
    private lazy var loadingView: UIImageView = {
        let loadingView = UIImageView(image: UIImage(named: "jiazai"))
        loadingView.frame = CGRect(x: LLJDX(22), y: LLJDX(-30), width: LLJDX(27), height: LLJDX(27))
        self.view.addSubview(loadingView)
        return loadingView
    }()
    
    private lazy var alertItemList1: Array<LLJAlertModel> = {
        
        var alertItemList: Array<LLJAlertModel> = []
        
        var model = LLJAlertModel()
        model.title = "拍摄"
        model.subTitle = "照片或视频"
        
        var model1 = LLJAlertModel()
        model1.title = "从相册中选择"
        
        var model2 = LLJAlertModel()
        model2.title = "分享"
        
        if self.useModel!.userId == 100010001 {
            alertItemList.append(model)
            alertItemList.append(model1)
        } else {
            alertItemList.append(model2)
            alertItemList.append(model)
            alertItemList.append(model1)
        }
        return alertItemList
    }()
    
    private lazy var alertItemList2: Array<LLJAlertModel> = {
        var alertItemList: Array<LLJAlertModel> = []
        var model = LLJAlertModel()
        model.title = "更换相册封面"
        alertItemList.append(model)
        return alertItemList
    }()
    
    private lazy var deletePing: Array<LLJAlertModel> = {
        var deletePing: Array<LLJAlertModel> = []
        var model = LLJAlertModel()
        model.title = "删除"
        deletePing.append(model)
        return deletePing
    }()

    private var actionList: [Action] = []
        
    private var navView: UIView?
    private var backButton: UIButton?
    private var camButton: UIButton?
    private var offset_y: CGFloat = 0.0
    private var titleLabel: UILabel?
    
    private var angle: CGFloat = CGFloat.pi
    private var isLoading: Bool = false        //是否正在加载
    private var isPullDown: Bool = false       //是否正在下拉
    private var endDragging: Bool = false      //结束拖拽
    private var loadAll: Bool = false          //加载全部

    private var currentPage: Int = 1
    private var pageCount: Int = 10
    private var cycleSourceListArray: Array<Any> = []
    private var coreDataList: [Any] = []

    var useModel: LLJCycleUserModel?
    private var allUser: [LLJCycleUserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //UI
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    deinit {
        LLJLog("LLJFWeChatCycleController")
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
        
        if model.type == 10010 {
            //纯文字cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "LLJWCommenCell") as! LLJWCommenCell
            cell.setDataSource(sourceModel: model)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            commenCell = cell
        } else if model.type == 10011 {
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
            //加载更多
            let cell = tableView.dequeueReusableCell(withIdentifier: "LLJCycleLoadCell") as! LLJCycleLoadCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        
        //更多回调
        weak var weakSelf = self
        commenCell!.moreAction = { (zanView) in
            weakSelf!.zanView = zanView
        }
        //点赞和评论
        commenCell!.zanViewAction = { (type) in
            weakSelf!.zanAction(type: type, sourceindex: indexPath.row, pingIndex: 0)
        }
        //回复
        commenCell!.pingViewAction = { (index) in
            weakSelf!.zanAction(type: 10001012, sourceindex: indexPath.row, pingIndex: index)
        }
        //删除朋友圈
        commenCell!.deleteAction = {
            weakSelf!.alertShow(index: indexPath.row, source: [], type: .alert)
        }
        //点击头像
        commenCell!.headAction = {
            let model = weakSelf!.cycleSourceListArray[indexPath.row] as! LLJCycleMessageModel
            for item in self.allUser {
                if item.userId == model.userId {
                    weakSelf!.pushNewUser(userModel: item)
                    break
                }
            }
        }
        return commenCell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.isKind(of: LLJCycleLoadCell.self) {
            let loadCell = cell as! LLJCycleLoadCell
            loadCell.startLoading()
            self.coverView.isHidden = false
            self.perform(#selector(loadMore), with: "", afterDelay: 2.0)
        } else if cell.isKind(of: LLJCycleVideoCell.self) {
            let newCell = cell as! LLJCycleVideoCell
            let covertFrame = newCell.cycleVideoView.convert(newCell.cycleVideoView.frame, to: kRootView)
            autoPlay(covertFrame: covertFrame, cell: newCell)
        }
    }
}

//MARK: - UIScrollViewDelegate 代理 -
extension LLJFWeChatCycleController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.isPullDown = self.offset_y > scrollView.contentOffset.y ? true : false
        
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
        
        //下拉刷新
        if self.offset_y < -LLJTopHeight {
            if !self.isLoading {
                self.isLoading = true
                self.view.addSubview(self.loadingView)
                self.loadingView.transform = CGAffineTransform.identity
                self.coverView.isHidden = false
                UIView.animate(withDuration: 0.25) {
                    self.loadingView.alpha = 1
                    self.loadingView.frame = CGRect(x: LLJDX(22), y: LLJTopHeight+LLJDX(15), width: LLJDX(27), height: LLJDX(27))
                } completion: { (bool) in
                    if self.endDragging {
                        self.animationEnd()
                    }
                }
            } else {
                if self.isPullDown {
                    self.loadingView.transform = self.loadingView.transform.rotated(by: -0.05)
                } else {
                    self.loadingView.transform = self.loadingView.transform.rotated(by: 0.05)
                }
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.endDragging = false
    }
    
    //停止拖拽
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.endDragging = true
        
        if self.isLoading {
            animationEnd()
        }
        
        for item in self.tableView.visibleCells {
            if item.isKind(of: LLJCycleVideoCell.self) {
                let cell = item as! LLJCycleVideoCell
                let covertFrame = cell.cycleVideoView.convert(cell.cycleVideoView.frame, to: kRootView)
                autoPlay(covertFrame: covertFrame, cell: cell)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        for item in self.tableView.visibleCells {
            if item.isKind(of: LLJCycleVideoCell.self) {
                let cell = item as! LLJCycleVideoCell
                let covertFrame = cell.cycleVideoView.convert(cell.cycleVideoView.frame, to: kRootView)
                autoPlay(covertFrame: covertFrame, cell: cell)
            }
        }
    }
    
    //自动播放
    func autoPlay(covertFrame: CGRect, cell: LLJCycleVideoCell) {
        if covertFrame.origin.y > LLJDX(200) && covertFrame.origin.y < SCREEN_HEIGHT - LLJDX(200) {
            if !cell.cycleVideoView.videoPlaying == true {
                cell.cycleVideoView.videoPlay()
            }
        } else {
            cell.cycleVideoView.videoRelease()
        }
    }

    
    func animationEnd() {
        
        LLJSHelper.countDown(timeInterval: 0.01, totalTime: 2) { (timer, time) in
            self.loadingView.transform = self.loadingView.transform.rotated(by: 0.05)
        } completeHandler: {
            self.loadingView.transform = CGAffineTransform.identity
            UIView.animate(withDuration: 0.25) {
                self.loadingView.alpha = 0.1
                self.loadingView.frame = CGRect(x: LLJDX(22), y: -LLJDX(30), width: LLJDX(27), height: LLJDX(27))
            } completion: { (bool) in
                self.isLoading = false
                self.setCoreDataList()
                self.coverView.isHidden = true
            }
        }
    }
}

//MARK: - 删除朋友圈、点赞、评论、回复 -
extension LLJFWeChatCycleController {
    
    //删除朋友圈
    private func deleteMessage(index: Int) {
        let model = self.cycleSourceListArray[index] as! LLJCycleMessageModel
        for zanModel in model.zanList {
            let pre = String(format: "messageId = %ld", zanModel.messageId)
            let _ = LLJSCoreDataHelper().deleteRosource(entityName: "LLJCycleZanModel", predicate: pre)
        }
        for zanModel in model.pingList {
            let pre = String(format: "messageId = %ld", zanModel.messageId)
            let _ = LLJSCoreDataHelper().deleteRosource(entityName: "LLJCycleZanModel", predicate: pre)
        }
        let pre = String(format: "messageId = %ld", model.messageId)
        let _ = LLJSCoreDataHelper().deleteRosource(entityName: "LLJWeChatCycleModel", predicate: pre)
        
        self.cycleSourceListArray.remove(at: index)
        self.tableView.reloadData()
    }
    
    //处理zanView type = 10001010赞 10001011评论 10001012回复
    private func zanAction(type: Int64, sourceindex: Int, pingIndex: Int) {
     
        let model = self.cycleSourceListArray[sourceindex] as! LLJCycleMessageModel
        if model.hasZaned && type == 10001010 {
            let array = NSArray.init(array: model.zanList) as! [LLJPingListModel]
            for i in stride(from: 0, to: array.count, by: 1) {
                let zanModel = array[i]
                if zanModel.aUserId == self.useModel!.userId {
                    model.zanList.remove(at: i)
                    let pre = String(format: "timeInterval = %ld", zanModel.timeInterval)
                    let r = LLJSCoreDataHelper().deleteRosource(entityName: "LLJCycleZanModel", predicate: pre)
                    if r {
                        model.hasZaned = false
                    }
                    //刷新
                    self.updateSource(model: model)
                    break
                }
            }
        } else {
            
            if type == 10001010 {
                
                self.createNewZanModel(pingModel: LLJPingListModel(), type: type, content: "", model: model)
                
            } else if type == 10001011 {
                let inputView = LLJInputView()
                inputView.tableView = self.tableView
                inputView.index = sourceindex
                inputView.sourceList = self.cycleSourceListArray
                inputView.inputComplete = { (content) in
                    
                    self.createNewZanModel(pingModel: LLJPingListModel(), type: type, content: String(format: "%@: %@", self.useModel!.nickName,content), model: model)
                }
                self.view.addSubview(inputView)
            } else if type == 10001012 {
                
                let pingModel = model.pingList[pingIndex]
                if pingModel.aUserId == self.useModel!.userId {
                    //发布朋友圈
                    let model = self.deletePing.first
                    model!.predicate = "timeInterval = " + String(pingModel.timeInterval)
                    self.alertShow(index: sourceindex, source: self.deletePing, type: .sheet)
                } else {
                    let inputView = LLJInputView()
                    inputView.tableView = self.tableView
                    inputView.index = sourceindex
                    inputView.sourceList = self.cycleSourceListArray
                    inputView.inputComplete = { (content) in
                        //创建赞
                        self.createNewZanModel(pingModel: pingModel, type: type, content: String(format: "%@回复%@: %@",self.useModel!.nickName,pingModel.aUserName,content), model: model)
                    }
                    self.view.addSubview(inputView)
                }
            }
        }
    }
    
    private func createNewZanModel(pingModel: LLJPingListModel, type: Int64, content: String, model: LLJCycleMessageModel) {
        
        let zanModel = LLJSCoreDataHelper.helper.createCoreDataModel(entityName: "LLJCycleZanModel") as! LLJCycleZanModel
        zanModel.aUserId = self.useModel!.userId
        zanModel.aUserName = self.useModel!.nickName
        zanModel.bUserId = pingModel.aUserId
        zanModel.bUserName = pingModel.aUserName
        zanModel.timeInterval = LLJSHelper.getCurrentTimeInteval()
        zanModel.type = type
        zanModel.userId = self.useModel!.userId
        zanModel.messageId = model.messageId
        zanModel.content = content
        //刷新
        self.updateSource(model: model)
    }
    
    //刷新数据和页面
    private func updateSource(model: LLJCycleMessageModel) {
        let _ = LLJSCoreDataHelper.helper.insertRosource()
        LLJCellFrameManage.setCompnentsFrame(userModel: self.useModel!, item: model, value: self.actionList)
        self.tableView.reloadData()
    }
}


//MARK: - 设置数据 -
extension LLJFWeChatCycleController {
    
    //获取本地数据
    private func setCoreDataList() {
        //移除数据
        self.cycleSourceListArray.removeAll()
        //获取本地数据
        self.coreDataList = LLJSCoreDataHelper.helper.getRosource(entityName: "LLJWeChatCycleModel", predicate: "")
        //按时间排序
        self.coreDataList.sort { (item1, item2) -> Bool in
            let item1 = item1 as! LLJWeChatCycleModel
            let item2 = item2 as! LLJWeChatCycleModel
            return item1.timeInteval > item2.timeInteval
        }
        //处理本地数据
        setDataSource()
    }
    
    //加载更多
    @objc private func loadMore() {
        self.currentPage += 1
        self.setDataSource()
        self.coverView.isHidden = true
    }
    
    //处理本地数据
    private func setDataSource() {
       
        
        let listArray = self.coreDataList
        
        //先移除加载更多
        if self.cycleSourceListArray.count > 0 {
            self.cycleSourceListArray.removeLast()
        }

        var sourceArray: [Any] = []
        for i in stride(from: self.cycleSourceListArray.count, to: pageCount*currentPage, by: 1) {
            if i < listArray.count {
                LLJLog(i)
                let model = listArray[i]
                sourceArray.append(model)
            } else {
                break
            }
        }
        
        //添加message模型
        let newArray = LLJCellFrameManage.setSubViewFrame(userModel: self.useModel!, sourceList: sourceArray, value: self.actionList)
        for item in newArray {
            self.cycleSourceListArray.append(item)
        }
        
        //是否加载了全部
        if sourceArray.count < 10 {
            self.loadAll = true
        }
        
        //再添加加载更多
        if !self.loadAll {
            //self.tableView.mj_footer?.isHidden = true
            let model = LLJCycleMessageModel()
            model.type = 10014
            model.frameModel.rowHeight = LLJDX(50)
            self.cycleSourceListArray.append(model)
        }
        
        self.tableView.reloadData()
    }
}


//MARK: - 点击事件 -
extension LLJFWeChatCycleController {

    //富文本点击事件
    private func attrAction() {
        
        //富文本点击事件
        let zanAction = Action(tigger: .click) { (textResult) in
            
            guard let userId = textResult.bindObject as? Int64 else {
                return
            }
            
            for item in self.allUser {
                
                if item.userId == userId {
                    self.pushNewUser(userModel: item)
                    break
                }
            }
        }
        self.actionList.append(zanAction)
    }
    
    
    //按钮事件
    @objc private func buttonClick(sender: UIButton) {
        
        //返回
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func headImageClick() {

        //更换封面图片
        self.alertShow(index: 0, source: self.alertItemList2, type: .sheet)
    }
    
    //单机
    @objc private func tapClick() {

        //发布朋友圈
        self.alertShow(index: 0, source: self.alertItemList1, type: .sheet)
    }
    //长按
    @objc private func longTapClick() {

        let pushViewController = LLJCycleMessagePushController()
        pushViewController.type = .text
        pushViewController.model = self.useModel
        pushViewController.pushComplete = {
            self.setDataSource()
        }
        self.present(pushViewController, animated: true, completion: nil)
    }
    
    //alert事件
    private func alertAction(index: Int, model: LLJAlertModel) {

        if model.title == "更换相册封面" {
            return
        }
        
        let pushViewController = LLJCycleMessagePushController()
        switch model.title {
        case "从相册中选择":
            pushViewController.type = .image
        case "拍摄":
            pushViewController.type = .video
        case "删除":
            let r: Bool = LLJSCoreDataHelper().deleteRosource(entityName: "LLJCycleZanModel", predicate: model.predicate)
            if r {
                self.updateSource(model: self.cycleSourceListArray[index] as! LLJCycleMessageModel)
            }
            return
        case "分享":
            pushViewController.type = .link
        default:break
        }
        pushViewController.model = self.useModel
        weak var weakSelf = self
        pushViewController.pushComplete = {
            weakSelf!.setCoreDataList()
        }
        self.present(pushViewController, animated: true, completion: nil)
    }
    
    //跳转新用户
    private func pushNewUser(userModel: LLJCycleUserModel) {
        let controller = LLJFWeChatCycleController()
        controller.useModel = userModel
        controller.hiddenNavgationBarWhenPushIn = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UI -
extension LLJFWeChatCycleController {
   
    //UI
    private func setUpUI() {
        
        //所有用户
        setAllUserInfo()
        
        self.view.backgroundColor = LLJWhiteColor()
        //修改状态栏样式
        self.statusBarStyle = UIStatusBarStyle.lightContent
        //添加tableView
        self.view.addSubview(self.tableView)
        //设置head
        setUpHeadView()
        //富文本点击事件
        attrAction()
        //获取本地数据
        setCoreDataList()
    }
    
    //alertView
    private func alertShow(index: Int, source: Array<LLJAlertModel>, type: LLJAlertType) {
        let alertView = LLJAlertView(frame: CGRect.zero, type: type)
        weak var weakSelf = self
        alertView.selectRow = {(row, name, type) in
            if type == .sheet {
                weakSelf!.alertAction(index: index, model: source[row])
            } else {
                //删除朋友圈
                weakSelf!.deleteMessage(index: index)
            }
        }
        alertView.alertShow(itemList: source)
    }
    
    //头视图
    private func setUpHeadView() {
        
        let headView = UIView()
        headView.backgroundColor = LLJWhiteColor()
        headView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: LLJDX(260) + LLJTopHeight)
        self.tableView.tableHeaderView = headView
        
        let cycleHeadImage = UIImageView(image: UIImage(named: self.useModel!.headIamge))
        cycleHeadImage.contentMode = UIImageView.ContentMode.scaleAspectFill
        cycleHeadImage.backgroundColor = UIColor.red
        cycleHeadImage.layer.masksToBounds = true
        cycleHeadImage.isUserInteractionEnabled = true
        headView.addSubview(cycleHeadImage)
        cycleHeadImage.snp_makeConstraints { (make) in
            make.centerX.equalTo(headView.snp_centerX)
            make.top.equalTo(headView.snp_top).offset(-LLJTopHeight*2)
            make.bottom.equalTo(headView.snp_bottom).offset(-LLJTopHeight + LLJDX(20))
        }
        //单机
        let headImage = UITapGestureRecognizer(target: self, action: #selector(headImageClick))
        headImage.numberOfTouchesRequired = 1
        headImage.numberOfTapsRequired = 1
        cycleHeadImage.addGestureRecognizer(headImage)
        
        let perHeadImage = UIImageView(image: UIImage(named: self.useModel!.userImage))
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
        nickName.text = self.useModel!.nickName
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

//本地数据设置
extension LLJFWeChatCycleController {
    
    private func setAllUserInfo() {
        
        let nickName: [String] = ["赞歌","纳兰丹青","微微一笑很倾城","青年文摘","在路上","奥运健儿加油！","浪漫的土耳其","小红书","逻辑-小燕子","国家博物馆"]
        let headImageName: [String] = ["IMG_28","IMG_35","IMG_29","IMG_21","IMG_17","IMG_15","IMG_14","IMG_13","IMG_16","IMG_20"]
        let userImageName: [String] = ["head","nituwang","shejilushang","shejizhijia","shejipai","zhongguo","wall-haven","zitibao","siyuansheji","tuyiwang"]
        let userIds: [String] = ["100010001","100010002","100010003","100010004","100010005","100010006","100010007","100010008","100010009","1000100010"]

        self.allUser.removeAll()
        for i in stride(from: 0, to: nickName.count, by: 1) {
            let model = LLJCycleUserModel()
            model.nickName = nickName[i]
            model.headIamge = headImageName[i]
            model.userImage = userImageName[i]
            model.userId = Int64(userIds[i])!
            self.allUser.append(model)
        }
        
        if self.useModel == nil {
            let arm = LLJSHelper.arc4random(duration: 10)
            self.useModel = self.allUser[arm]
        }
    }
}
