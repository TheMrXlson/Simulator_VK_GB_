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
    
    let network = NetworkServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.load(network.vkLogin())
    }
}
