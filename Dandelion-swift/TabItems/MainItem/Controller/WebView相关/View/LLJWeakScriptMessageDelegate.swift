//
//  LLJWeakScriptMessageDelegate.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/5.
//

import UIKit
import WebKit

class LLJWeakScriptMessageDelegate: NSObject, WKScriptMessageHandler {

    weak var scriptDelegate: WKScriptMessageHandler?
        
    init(_ scriptDelegate: WKScriptMessageHandler) {
        self.scriptDelegate = scriptDelegate
        super.init()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        scriptDelegate?.userContentController(userContentController, didReceive: message)
    }
    
    deinit {
        print("WeakScriptMessageDelegate is deinit")
    }
}
