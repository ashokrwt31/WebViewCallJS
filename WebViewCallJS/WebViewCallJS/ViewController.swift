//
//  ViewController.swift
//  WebViewCallJS
//
//  Created by Ashok Rawat on 04/08/23.
//

import UIKit
import WebKit

let MessageHandlerForiOS = "messageHandlerForiOS"

class ViewController: UIViewController {

    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.configuration.userContentController.add(self, name: MessageHandlerForiOS)
        
        // Load the HTML file into the web view
        if let htmlURL = Bundle.main.url(forResource: "index", withExtension: "html") {
            let baseURL = Bundle.main.bundleURL
            webView.loadFileURL(htmlURL, allowingReadAccessTo: baseURL)
        }
        #if DEBUG
        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        }
        #endif
    }
    
    @IBAction func sendDataToHTML(_ sender: Any) {
        guard let text = inputText.text, !text.isEmpty else {
            return
        }
        
        let javaScriptCode = JavaScriptUtil.scriptForHTML(text)
        webView.evaluateJavaScript(javaScriptCode) { (result, error) in
            if let error = error {
                print("Error evaluating JavaScript code:", error.localizedDescription)
            } else {
                self.inputText.text = ""
            }
        }
    }
    
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == MessageHandlerForiOS, let data = message.body as? [String: Any] {
            inputText.text = data["message"] as? String
        }
    }
}

