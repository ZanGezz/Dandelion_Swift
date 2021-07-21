//
//  LLJFWeChatCycleController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/6/22.
//

import UIKit

class LLJFWeChatCycleController: LLJFViewController {
    
    //懒加载
    //MARK:懒加载属性
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: UITableView.Style.plain)
        tableView.register(LLJWCommenCell.self, forCellReuseIdentifier: "LLJWCommenCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        return tableView
    }()
    
    private var navView: UIView?
    private var backButton: UIButton?
    private var camButton: UIButton?
    private var offset_y: CGFloat = 0.0
    private var titleLabel: UILabel?

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
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LLJWCommenCell")!
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
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
    }
    //头视图
    private func setUpHeadView() {
        
        let headView = UIView()
        headView.backgroundColor = LLJWhiteColor()
        headView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: LLJDX(260) + LLJTopHeight)
        self.tableView.tableHeaderView = headView
        
        let cycleHeadImage = UIImageView(image: UIImage(named: "cycle_head"))
        cycleHeadImage.contentMode = UIImageView.ContentMode.scaleAspectFit
        cycleHeadImage.backgroundColor = UIColor.red
        headView.addSubview(cycleHeadImage)
        cycleHeadImage.snp_makeConstraints { (make) in
            make.centerX.equalTo(headView.snp_centerX)
            make.top.equalTo(headView.snp_top).offset(-LLJTopHeight)
            make.bottom.equalTo(headView.snp_bottom).offset(-LLJTopHeight + LLJDX(10))
        }
        
        let perHeadImage = UIImageView(image: UIImage(named: "head"))
        perHeadImage.layer.masksToBounds = true
        perHeadImage.layer.cornerRadius = 8.0
        headView.addSubview(perHeadImage)
        perHeadImage.snp_makeConstraints { (make) in
            make.width.equalTo(LLJDX(60))
            make.right.equalTo(headView.snp_right).offset(LLJDX(-12))
            make.height.equalTo(LLJDX(60))
            make.bottom.equalTo(headView.snp_bottom).offset(LLJDX(6) - LLJTopHeight)
        }
        
        let nickName = UILabel()
        nickName.font = LLJBoldFont(20)
        nickName.text = "赞歌"
        nickName.textColor = LLJWhiteColor()
        headView.addSubview(nickName)
        nickName.snp_makeConstraints { (make) in
            make.right.equalTo(perHeadImage.snp_left).offset(-LLJDX(20))
            make.top.equalTo(perHeadImage.snp_top).offset(LLJDX(14))
        }
        
        let navView = UIView()
        navView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: LLJTopHeight)
        navView.backgroundColor = LLJColor(238.0, 238.0, 238.0, 0.0)
        self.view.addSubview(navView)
        self.navView = navView;
        
        let backButton = UIButton.init(type: UIButton.ButtonType.custom)
        backButton.setImage(UIImage(named: "fanhui_w"), for: UIControl.State.normal)
        backButton.setImage(UIImage(named: "fanhui_w"), for: UIControl.State.highlighted)
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

//MARK: - 设置数据 -
extension LLJFWeChatCycleController {
    
    private func setDataSource() {
        let model: LLJWeChatCycleModel = LLJSCoreDataHelper.helper.createCoreDataModel(entityName: "LLJWeChatCycleModel") as! LLJWeChatCycleModel
        model.imageModel?.imageList = "dkdaf;"
        
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
    }
}
