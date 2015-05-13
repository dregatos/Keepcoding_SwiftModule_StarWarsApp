//
//  CharacterViewController.swift
//  StartWarsSwift
//
//  Created by David Regatos on 12/05/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    
    // MARK: Variables ***
    var character : StarWarsCharacter?
    
    @IBOutlet weak var photoImView: UIImageView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    
    
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
        let notKey = GlobalConstants.NotificationKey.CHARACTER_DID_SELECT
        let nc: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "characterDidChange", name: notKey, object: nil)
        
        self.view.backgroundColor = UIColor.grayColor()
        self.photoImView.contentMode = UIViewContentMode.ScaleAspectFill
    }
    
    override func viewWillAppear(animated: Bool) {
        syncViewWithModel()
    }
    
    // MARK: Helpers
    func syncViewWithModel() -> () {
        
        if let character = self.character {
            self.title = character.name
            if let image = character.photo {
                self.photoImView.image = image
            }
        }
    }
    
    // MARK: IBActions
    
    @IBAction func playBtnPressed(sender: AnyObject) {
        
    }
    
    @IBAction func wikiBtnPressed(sender: AnyObject) {
        
        if let character = self.character {
            let vc = WikiViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    
    
    
    
}
