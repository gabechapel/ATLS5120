//
//  DetailViewController.swift
//  petitions
//
//  Created by Gabriel Chapel on 3/1/18.
//  Copyright © 2018 Gabriel Chapel. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var webSpinner: UIActivityIndicatorView!
    
    //web page begins to load
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webSpinner.startAnimating()
    }
    
    //web page successfully loaded
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webSpinner.stopAnimating()
    }
    
    func loadWebPage(_ urlString: String){
        //the urlString should be a prperly formed url
        //creates an NSURL object
        let url = URL(string: urlString)
        //create NSURLRequest object
        let request = URLRequest(url: url!)
        //load the NSURLRequest object in web view
        webView.load(request)
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let url = detailItem {
            if url != "null" {
                loadWebPage(url)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: String?


}

