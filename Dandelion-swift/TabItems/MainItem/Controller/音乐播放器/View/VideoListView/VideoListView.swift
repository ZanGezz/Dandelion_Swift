//
//  VideoListView.swift
//  Dandelion-swift
//
//  Created by liushuai on 2023/8/3.
//

import UIKit

class VideoListView: UIView {

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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 代理
extension VideoListView: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LLJDX(55)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var videoCell = tableView.dequeueReusableCell(withIdentifier: "videoCell") as? LLJVideoListCell
        if (videoCell == nil) {
            videoCell = LLJVideoListCell(style: .default, reuseIdentifier: "videoCell")
        }
        videoCell!.setDataSource(title: "我们的爱")
        return videoCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let url: String = Bundle.main.path(forResource: "ShapofYou", ofType: "mp3") ?? ""
        //self.player.release()
        //self.player = LLJVideoPlayer(url: url)
        //self.player!.play()
    }
}
