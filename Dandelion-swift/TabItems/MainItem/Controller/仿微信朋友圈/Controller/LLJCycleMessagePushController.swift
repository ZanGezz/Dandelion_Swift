//
//  LLJCycleMessagePushController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/23.
//

import UIKit

enum LLJCycleMessagePushType {
    case text
    case image
    case video
    case link
}

class LLJCycleMessagePushController: LLJFViewController {

    typealias pushCompleteBlock = (() -> Void)

    //MARK:懒加载属性
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: LLJTopHeight, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - LLJTopHeight), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        return tableView
    }()
    
    private lazy var navView: UIView = {
        let navView = UIView()
        navView.backgroundColor = LLJWhiteColor()
        navView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: LLJTopHeight)
        return navView
    }()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton(type: .custom)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.tag = 100003
        cancelButton.setTitleColor(LLJBlackColor(), for: .normal)
        cancelButton.titleLabel?.font = LLJFont(17, "")
        cancelButton.addTarget(self, action: #selector(buttonClick(sender:)), for: UIControl.Event.touchUpInside)
        return cancelButton
    }()
    
    private lazy var pushButton: UIButton = {
        let pushButton = UIButton(type: .custom)
        pushButton.setTitle("发表", for: .normal)
        pushButton.isEnabled = false
        pushButton.tag = 100004
        pushButton.addTarget(self, action: #selector(buttonClick(sender:)), for: UIControl.Event.touchUpInside)
        pushButton.setTitleColor(LLJColor(179, 179, 179, 1), for: .normal)
        pushButton.titleLabel?.font = LLJBoldFont(17)
        pushButton.backgroundColor = LLJColor(239, 239, 239, 1)
        pushButton.layer.masksToBounds = true
        pushButton.layer.cornerRadius = 4.0
        return pushButton
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "发表文字"
        titleLabel.textColor = LLJBlackColor()
        titleLabel.font = LLJBoldFont(18)
        return titleLabel
    }()
    
    var model: LLJCycleUserModel?
    
    private var content: String = ""
    private var locationSelect: Bool = false
    private var itemList: [String] = ["所在位置","提醒谁看","谁可以看"]
    private var logoList: [String] = ["weizhi","tixingshuikan","yonghu"]
    private var imageList: [String] = ["IMG_1","IMG_2","IMG_3","IMG_4","IMG_5","IMG_6","IMG_7","IMG_8","IMG_9","IMG_10","IMG_11","IMG_12","IMG_13","IMG_14","IMG_15","IMG_16","IMG_17","IMG_18","IMG_19","IMG_20","IMG_21","IMG_22","IMG_23","IMG_24","IMG_25","IMG_26","IMG_27","IMG_28","IMG_29","IMG_30","IMG_31","IMG_32","IMG_33","IMG_34","IMG_35","IMG_36","IMG_37","IMG_38","IMG_39"]
    private var webList: [String] = ["驰援郑州！！一方有难八方支援，是我中华民族的传统美德！","喜讯！马龙战胜队友樊振东，成功卫冕男子单打奥运冠军，中国队包揽金银！！","喜讯！马龙战胜队友樊振东，成功卫冕男子单打奥运冠军，中国队包揽金银！！","封神！中国选手苏炳添以9秒83的成绩刷新亚洲纪录。","江苏新增本土确诊45例，全民抗疫，任重道远！"]
    private var locationList: [String] = ["北京市 · 中国国家博物馆","门头沟 · 欢乐大都会","昌平区 · 奥林匹克公园","丰台区 · 北京南站","西城区 · 天安门广场","西城区 · 故宫博物院"]
    var type: LLJCycleMessagePushType = .text
    var pushComplete: pushCompleteBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //UI
        setUpUI()
    }
}

//按钮事件
extension LLJCycleMessagePushController {
    
    //按钮事件
    @objc private func buttonClick(sender: UIButton) {
        
        switch sender.tag {
        case 100003:
            //取消
            self.dismiss(animated: true, completion: nil)
        case 100004:
            self.view.endEditing(true)
            //发布朋友圈
            self.perform(#selector(addDataSource), with: "", afterDelay: 1.0)
        
        default:break
        }
    }
    
    //处理数据
    @objc private func addDataSource() {
        
        let model: LLJWeChatCycleModel = LLJSCoreDataHelper.helper.createCoreDataModel(entityName: "LLJWeChatCycleModel") as! LLJWeChatCycleModel
        
        model.headImageName = self.model!.userImage
        model.content = self.content
        model.nickName = self.model!.nickName
        model.userId = self.model!.userId
        model.timeInteval = LLJSHelper.getCurrentTimeInteval()
        //messageId
        var messageId = LLJUseDefaultHelper.getMessage(key: "messageId")
        messageId += 1
        LLJUseDefaultHelper.setMessage(object: messageId, key: "messageId")
        model.messageId = messageId
        //定位
        if self.locationSelect {
            let armNum1 = LLJSHelper.arc4random(duration: 6)
            let locationModel: LLJCycleLocationModel = LLJSCoreDataHelper.helper.createCoreDataModel(entityName: "LLJCycleLocationModel") as! LLJCycleLocationModel
            locationModel.name = self.locationList[armNum1]
            model.locationModel = locationModel
        }
        
        switch self.type {
        case .text:
            model.type = 10010
        case .image:
            model.type = 10011
            let imageModel: LLJCycleImageModel = LLJSCoreDataHelper.helper.createCoreDataModel(entityName: "LLJCycleImageModel") as! LLJCycleImageModel
            imageModel.imageList = getImageList()
            model.imageModel = imageModel
        case .video:
            model.type = 10012
            let videoModel: LLJCycleVideoModel = LLJSCoreDataHelper.helper.createCoreDataModel(entityName: "LLJCycleVideoModel") as! LLJCycleVideoModel
            videoModel.videoUrl = "video.mp4"
            videoModel.videoImage = getOneImage()
            model.videoModel = videoModel
        case .link:
            model.type = 10013
            
            let armNum1 = LLJSHelper.arc4random(duration: 5)
            let linkModel: LLJCycleWebLinkModel = LLJSCoreDataHelper.helper.createCoreDataModel(entityName: "LLJCycleWebLinkModel") as! LLJCycleWebLinkModel
            linkModel.webLinkUrl = "https://www.baidu.com"
            linkModel.webLinkImage = getOneImage()
            linkModel.webLinkContent = self.webList[armNum1]
            
            let armNum2 = LLJSHelper.arc4random(duration: 4)
            linkModel.webFromName = ["网易新闻","今日头条","哔哩哔哩","小红书"][armNum2]
            model.webLinkModel = linkModel
        }
        
        let _ = LLJSCoreDataHelper.helper.insertRosource()
        //取消
        self.dismiss(animated: true, completion: nil)
        //跳转完成
        if self.pushComplete != nil {
            self.pushComplete!()
        }
    }
    
    //随机获取1-9图片
    private func getImageList() -> String {
        
        var imageList: String = ""
        let armNum = LLJSHelper.arc4random(duration: 8)
        for i in stride(from: 0, to: armNum + 1, by: 1) {
            if i == 0 {
                imageList = getOneImage()
            } else {
                imageList = imageList + "," + getOneImage()
            }
        }
        return imageList
    }
    //随机获取1图片
    private func getOneImage() -> String {
        
        let armNum1 = LLJSHelper.arc4random(duration: 39)
        let imageList = self.imageList[armNum1]
        return imageList
    }
}

//MARK: - UITableViewDelegate 代理 -
extension LLJCycleMessagePushController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return LLJDX(184)
        }
        return LLJDX(55)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = LLJTextInputCell.init(style: .default, reuseIdentifier: "LLJTextInputCell")
            weak var weakSelf = self
            cell.textChange = { (content) in
                weakSelf!.content = content
                if content.count > 0 {
                    weakSelf!.pushButton.isEnabled = true
                    weakSelf!.pushButton.setTitleColor(LLJWhiteColor(), for: .normal)
                    weakSelf!.pushButton.backgroundColor = LLJColor(46, 201, 114, 1)
                } else {
                    weakSelf!.pushButton.isEnabled = false
                    weakSelf!.pushButton.setTitleColor(LLJColor(179, 179, 179, 1), for: .normal)
                    weakSelf!.pushButton.backgroundColor = LLJColor(239, 239, 239, 1)
                }
            }
            return cell
        } else {
            let cell = LLJLocationCell.init(style: .default, reuseIdentifier: "LLJLocationCell")
            cell.setDataSource(content: self.itemList[indexPath.row - 1], image: self.logoList[indexPath.row - 1])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            self.locationSelect = true
        }
    }
}

//MARK: - UI -
extension LLJCycleMessagePushController {
    
    //UI
    func setUpUI() {
        self.view.addSubview(self.navView)
        self.navView.addSubview(self.cancelButton)
        self.navView.addSubview(self.pushButton)
        self.navView.addSubview(self.titleLabel)
        self.view.addSubview(self.tableView)
        
        self.cancelButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.navView.snp_left).offset(LLJDX(16))
            make.bottom.equalTo(self.navView.snp_bottom).offset(LLJDX(-8))
            make.width.equalTo(LLJDX(38))
            make.height.equalTo(LLJDX(20))
        }
        
        self.titleLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.navView.snp_centerX)
            make.centerY.equalTo(self.cancelButton.snp_centerY)
        }
        
        self.pushButton.snp_makeConstraints { (make) in
            make.right.equalTo(self.navView.snp_right).offset(LLJDX(-14))
            make.centerY.equalTo(self.cancelButton.snp_centerY)
            make.width.equalTo(LLJDX(60))
            make.height.equalTo(LLJDX(33))
        }
    }
}

