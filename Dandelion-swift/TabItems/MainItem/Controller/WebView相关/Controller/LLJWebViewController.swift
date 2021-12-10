//
//  LLJWebViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/5.
//

import UIKit
import WebKit

class LLJWebViewController: LLJFViewController {

    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: self.view.bounds)
        webView.backgroundColor = UIColor.red
        return webView
    }()
    
    var messgaeHandlerArray: [String] = []
    
    var webUrlString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

//MARK: - UI -
extension LLJWebViewController {
    
    private func setUpUI() {
        
        
        self.view.backgroundColor = LLJWhiteColor()
        
        self.title = self.titleName
        //self.messgaeHandlerArray = ["backToViewController"]
        
        
        //self.webUrlString = Bundle.main.path(forResource: "WKWebViewText", ofType: "html")!
        
        let req = URLRequest(url: URL(string: self.webUrlString)!)
        self.webView.load(req)
        self.view.addSubview(self.webView)

        //dealWithWebEvent()
    }
    
    
    private func dealWithWebEvent() {
        
//        self.webView.webAction = { (status, message) in
//
//            if status == .receiveMessage {
//                LLJLog(message.name)
//            }
//        }
    }
}
