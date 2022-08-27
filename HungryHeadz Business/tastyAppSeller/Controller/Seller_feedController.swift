//
//  Seller_feedController.swift
//  tastyAppSeller
//
//  Created by Rahul Patil on 15/08/22.
//

import UIKit
import WebKit

class Seller_feedController: UIViewController,WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var tabView: UIView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var home: UIImageView!
    
    @IBOutlet weak var promotion: UIImageView!
    
    @IBOutlet weak var gallery: UIImageView!
    
    @IBOutlet weak var detail: UIImageView!
    
    
    
    @IBOutlet weak var selectedView: UIView!
    
    var tabBarImages:[UIImageView]!
    var selectedButton = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedView.layer.cornerRadius = 15
        self.selectedView.isHidden = false
        
        
        
        
        let myUrl = URL(string: "https://tastee.inspeero.com/feed")!
        let myRequest = URLRequest(url: myUrl)
        webView.allowsBackForwardNavigationGestures = true
        
        self.tabBarImages = [home , promotion , gallery , detail]
        
        //        MARK: - observer for fetching url
        
        
        webView.load(myRequest)
        
        webView.navigationDelegate = self
        loadingIndicator.hidesWhenStopped = true
        

        
        webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        
    }
    
    private func setSelectedState(selectedImg:UIImageView){
        for each in self.tabBarImages{
            each.tintColor = .white
        }
        selectedImg.tintColor = .black
        self.animateBtn(view: selectedImg)
    }
    
    
    //    MARK: - button outlet action
    
    @IBAction func btnAction(_ sender: UIButton) {
        
        let tag = sender.tag

        selectedButton = tag
        self.selectedView.isHidden = false
        
        if selectedButton == 0 {
            
            let myUrl = URL(string: "https://tastee.inspeero.com/feed")!
            let myRequest = URLRequest(url: myUrl)
            webView.load(myRequest)
            
            
            self.setSelectedState(selectedImg: self.home)
            
        } else if selectedButton == 1 {
            
            let myUrl = URL(string: "https://tastee.inspeero.com/promotions/Promotions")!
            let myRequest = URLRequest(url: myUrl)
            tabView.isHidden = false
            webView.load(myRequest)
            
            self.setSelectedState(selectedImg: self.promotion)
            
            
        } else if selectedButton == 2 {
            
            let myUrl = URL(string: "https://tastee.inspeero.com/gallery/Food")!
            let myRequest = URLRequest(url: myUrl)
            tabView.isHidden = false
            webView.load(myRequest)
            
            
            self.setSelectedState(selectedImg: self.gallery)
            
        } else if selectedButton == 3 {
            
            let myUrl = URL(string: "https://tastee.inspeero.com/vendor_details/details")!
            let myRequest = URLRequest(url: myUrl)
            webView.load(myRequest)
            

            self.setSelectedState(selectedImg: self.detail)
            
        }
        
        
    }
    

    func showIndicator(show: Bool) {
        
        if show {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showIndicator(show: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showIndicator(show: false)
    }
    
}

// MARK: -  method for fetching urls

extension Seller_feedController {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
    
        
        if keyPath == #keyPath(WKWebView.url) {
            let url = webView.url
            
            self.selectedView.isHidden = false
            
            if url!.absoluteString == "https://tastee.inspeero.com/" {
                
                tabView.isHidden = true
                tabView.frame.size.height = 0
                
                let myUrl = URL(string: "https://tastee.inspeero.com/business_signup")!
                let myRequest = URLRequest(url: myUrl)
                webView.load(myRequest)
                
            } else if url!.absoluteString == "https://tastee.inspeero.com/feed" {
                
                self.setSelectedState(selectedImg: self.home)

                
            } else if url!.absoluteString == "https://tastee.inspeero.com/promotions/Promotions" {
                
                self.setSelectedState(selectedImg: self.promotion)
                
            } else if url!.absoluteString == "https://tastee.inspeero.com/gallery/Food" {
                
               
                self.setSelectedState(selectedImg: self.gallery)
                
                
            } else if url!.absoluteString == "https://tastee.inspeero.com/vendor_details/details" {
                
                self.setSelectedState(selectedImg: self.detail)
                
            } else {
                self.selectedView.isHidden = true
            }
        }
    }
}


extension Seller_feedController {
    
    func animateBtn(view: UIView) {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            self.selectedView.center = view.center
        } completion: { _ in
            
        }

        
    }
    
}
