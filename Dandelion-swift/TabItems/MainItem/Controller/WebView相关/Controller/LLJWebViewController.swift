//
//  LLJWebViewController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/5.
//

import UIKit
import WebKit

class LLJWebViewController: LLJFViewController,WKNavigationDelegate,WKScriptMessageHandler {
   
    lazy var webView: WKWebView = {
        
            let preferences = WKPreferences()

            let configuration = WKWebViewConfiguration()
            configuration.preferences = preferences
            configuration.userContentController = WKUserContentController()
            configuration.userContentController.add(self, name: "AppModel")

            var webView = WKWebView(frame: self.view.frame, configuration: configuration)
            webView.scrollView.bounces = true
            webView.scrollView.alwaysBounceVertical = true
            webView.navigationDelegate = self
            return webView
    }()

    
    var messgaeHandlerArray: [String] = []
    
    var webUrlString: String = "g"
    
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
        let req = URLRequest(url: URL(string: self.webUrlString)!)
        self.webView.load(req)
        self.view.addSubview(self.webView)
    }
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
}
