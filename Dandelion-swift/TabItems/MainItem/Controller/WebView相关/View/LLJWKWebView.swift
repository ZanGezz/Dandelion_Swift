//
//  LLJWKWebView.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/5.
//

import UIKit
import WebKit

enum LLJWKWebViewStatus {
    case loadFinish
    case loadFail
    case receiveMessage
}

class LLJWKWebView: WKWebView {
    
    //注册方法名数组
    private var messgaeHandlerArray: [String] = []
    //回调闭包
    typealias LLJWebAction = ((LLJWKWebViewStatus, WKScriptMessage) -> Void)
    //回调
    var webAction: LLJWebAction?
    //父试图
    private var superViewController: UIViewController?
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
        print("WKWebViewController is deinit")
    }
}

extension LLJWKWebView {
    
    //MARK: - 便利构造器 -
    convenience init(frame: CGRect, messgaeHandlerArray: [String]) {
        
        self.init(frame: frame, configuration: WKWebViewConfiguration())

        self.messgaeHandlerArray = messgaeHandlerArray
        
        initConfigure()
    }
    
    private func initConfigure() {
        
        let configuration = self.configuration
        configuration.userContentController.add(LLJWeakScriptMessageDelegate.init(self), name: "")
        
        addHanders()
    }
    
    private func addHanders() {
        
        removeHanders()
        for item in self.messgaeHandlerArray {
            self.configuration.userContentController.add(LLJWeakScriptMessageDelegate.init(self), name: item)
        }
    }
    
    private func removeHanders() {
        
        for item in self.messgaeHandlerArray {
            self.configuration.userContentController.removeScriptMessageHandler(forName: item)
        }
    }
    
    private func getSuperViewController() -> UIViewController? {
        
        var viewController: UIResponder? = self.next
        while viewController != nil {
            if ((self.next?.isKind(of: UIViewController.self)) != nil) {
                viewController = self.next
                break
            }
            viewController = viewController?.next
        }
        return viewController as? UIViewController
    }
}

extension LLJWKWebView: WKUIDelegate {
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
        let alertController = UIAlertController(title: prompt, message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField) in
            textField.text = defaultText
        }
        let action = UIAlertAction(title: "知道了", style: UIAlertAction.Style.default) { (action) in
            completionHandler(alertController.textFields?[0].text)
        }
        alertController.addAction(action)
        self.getSuperViewController()?.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "取消", style: UIAlertAction.Style.default) { (action) in
            completionHandler(false)
        }
        let action1 = UIAlertAction(title: "确认", style: UIAlertAction.Style.default) { (action) in
            completionHandler(true)
        }
        alertController.addAction(action)
        alertController.addAction(action1)
        self.getSuperViewController()?.present(alertController, animated: true, completion: nil)
    }
}

extension LLJWKWebView: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if self.webAction != nil {
            self.webAction!(.loadFinish, WKScriptMessage())
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if self.webAction != nil {
            self.webAction!(.loadFail, WKScriptMessage())
        }
    }
}

extension LLJWKWebView: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if self.webAction != nil {
            self.webAction!(.receiveMessage, message)
        }
    }
}

