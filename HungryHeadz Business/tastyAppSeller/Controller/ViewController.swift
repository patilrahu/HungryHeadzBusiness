//
//  ViewController.swift
//  tastyAppSeller
//
//  Created by Rahul Patil on 10/08/22.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let myUrl = URL(string: "https://tastee.inspeero.com/business_signup")!
        let myRequest = URLRequest(url: myUrl)
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        webView.load(myRequest)
        
        //        MARK: - dismiss keyboard method
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }
    //    MARK: - func for dismiss keyboard
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
        
    }
    
}

extension ViewController {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.url) {
            let url = webView.url
            if url!.absoluteString == "https://tastee.inspeero.com/feed" {
                
                self.performSegue(withIdentifier: "show", sender: nil)
            } 
        }
    }
}


