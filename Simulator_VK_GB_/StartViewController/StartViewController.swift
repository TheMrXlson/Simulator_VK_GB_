//
//  StartViewController.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 24.04.2022.
//

import UIKit
import WebKit
import Alamofire

class StartViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        vkLogin()
    }
    // MARK: - Standart SWIFT URLComponents
    private func vkLogin() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8039339"),
            URLQueryItem(name: "scope", value: "262148"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "user_id", value: "userId"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
