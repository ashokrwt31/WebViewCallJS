//
//  JavaScript.swift
//  WebViewCallJS
//
//  Created by Ashok Rawat on 07/08/23.
//

import Foundation

class JavaScriptUtil{
    
    class func scriptForHTML(_ inputText: String) -> String {
        let data = ["message": inputText]
        let jsonData = try? JSONSerialization.data(withJSONObject: data, options: [])
        let jsonString = jsonData?.base64EncodedString()
        let javascript = "sendDataToHTML('\(jsonString ?? "")');"
        return javascript
    }
}


