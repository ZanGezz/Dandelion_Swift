//
//  LLJWebViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/5.
//

import UIKit

class LLJWebViewController: LLJFViewController {

    lazy var webView: LLJWKWebView = {
        let webView = LLJWKWebView(frame: self.view.bounds, messgaeHandlerArray: self.messgaeHandlerArray)
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
        
        self.messgaeHandlerArray = ["backToViewController"]
        self.view.addSubview(self.webView)
        
        
        //self.webUrlString = Bundle.main.path(forResource: "WKWebViewText", ofType: "html")!
        
        let req = URLRequest(url: URL(string: self.webUrlString)!)
        self.webView.load(req)
        
        dealWithWebEvent()
    }
    
    
    private func dealWithWebEvent() {
        
        self.webView.webAction = { (status, message) in
            
            if status == .receiveMessage {
                LLJLog(message.name)
            }
        }
    }
}
