//
//  WikiViewController.swift
//  StartWarsSwift
//
//  Created by David Regatos on 13/05/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

import UIKit

class WikiViewController: UIViewController {
    
    @IBOutlet weak var wikiViewer: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.wikiViewer.backgroundColor = UIColor.blueColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
