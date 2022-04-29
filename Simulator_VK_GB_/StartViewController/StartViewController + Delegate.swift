//
//  StartViewController + Delegate.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 29.04.2022.
//

import WebKit

extension StartViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") } .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        guard let token = params["access_token"], let userId = params["user_id"] else { return }
        Session.shared.userId = userId
        Session.shared.token = token
        
        performSegue(withIdentifier: "loginOk", sender: nil)
        
        decisionHandler(.cancel)
    }
}
