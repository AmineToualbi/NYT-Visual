//
//  ArticleWebVC.swift
//  NYT Instant
//
//  Created by Mieczkowski, Elizabeth on 7/18/19.
//  Copyright © 2019 Toualbi, Amine. All rights reserved.
//

import UIKit

class ArticleWebVC: UIViewController {

    var articleURL: String
    
    init(articleURL: String) {
        self.articleURL = articleURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ArticleWebVC.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        let webV: UIWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        webV.loadRequest(NSURLRequest(url: NSURL(string: articleURL)! as URL) as URLRequest)
//        webV.delegate = self
        self.view.addSubview(webV)
    }
    
    @objc func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
    }

}
