//
//  WikiViewController.swift
//  StartWarsSwift
//
//  Created by David Regatos on 13/05/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

import UIKit

class WikiViewController: UIViewController, UIWebViewDelegate {
    
    // MARK: Variables ***
    var character : StarWarsCharacter?
    var canLoad : Bool = true

    @IBOutlet weak var wikiViewer: UIWebView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: Lifecycle ***
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(character: StarWarsCharacter) {
        self.init(nibName: nil, bundle: nil)
        self.character = character
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View events

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Wikipedia"
        self.wikiViewer.backgroundColor = UIColor.blueColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.wikiViewer.delegate = self
        syncViewWithModel()
        registerForNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        unregisterForNotifications()
    }
    
    // MARK: Helpers
    func syncViewWithModel() {
        
        if let url = self.character?.wikiURL {
            self.canLoad = true
            self.wikiViewer.loadRequest(NSURLRequest(URL: url))
        }
    }
    
    // MARK: Notifications
    
    func registerForNotifications() {
        let notKey = GlobalConstants.NotificationName.CHARACTER_DID_SELECT
        let nc: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "characterDidChange:", name: notKey, object: nil)
    }
    
    func unregisterForNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func characterDidChange(notification: NSNotification) {
        println("StarWarsUniverse notify character did change")

        let userInfo: Dictionary<String,StarWarsCharacter!> = notification.userInfo as! Dictionary<String,StarWarsCharacter!>
        let newCharacter = userInfo[GlobalConstants.NotificationKey.CHARACTER]
        self.character = newCharacter
        syncViewWithModel()
    }
    
    // MARK: UIWebViewDelegate
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return self.canLoad
    }
    func webViewDidStartLoad(webView: UIWebView) {
        self.loadingIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.canLoad = false
        self.loadingIndicator.stopAnimating()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        self.loadingIndicator.stopAnimating()
        showLoadingErrorAlert()
    }
    
    func showLoadingErrorAlert() {
        let titleAlert = "Loading failed"
        let messageAlert = "Do you want to try again?"
        let alertController = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // ...
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // ...
            self.syncViewWithModel()
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            // completion
        }
    }
}
