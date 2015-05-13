//
//  CharacterViewController.swift
//  StartWarsSwift
//
//  Created by David Regatos on 12/05/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

import UIKit
import AVFoundation

class CharacterViewController: UIViewController, StarWarsUniverseViewControllerDelegate {
    
    // MARK: Variables ***
    var character : StarWarsCharacter?
    var audioPlayer = AVAudioPlayer()

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
        self.edgesForExtendedLayout = UIRectEdge.None
        self.view.backgroundColor = UIColor.blackColor()
        self.photoImView.contentMode = UIViewContentMode.ScaleAspectFill
        
        // show displayModeButton of UISplitVC
        // NOTE: it's not neccessary to implement UISplitViewControllerDelegate in Swift
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        navigationItem.leftItemsSupplementBackButton = true
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
        
        if let character = self.character {
            var error:NSError?
            audioPlayer = AVAudioPlayer(data: self.character?.sound, error: &error)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
    }
    
    @IBAction func wikiBtnPressed(sender: AnyObject) {
        
        if let character = self.character {
            let vc = WikiViewController(character: character)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: StarWarsUniverseViewControllerDelegate ***
    
    func starWarsUniverseVC(swuvc: StarWarsUniverseVC, didSelectCharacter: StarWarsCharacter) {
        println("Character did selected -> \(didSelectCharacter.name)")
        
        self.character = didSelectCharacter
        
        syncViewWithModel()
    }
    
    
    
    
    
    
}
