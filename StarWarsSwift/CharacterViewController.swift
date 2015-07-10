//
//  CharacterViewController.swift
//  StartWarsSwift
//
//  Created by David Regatos on 12/05/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

import UIKit
import AVFoundation

class CharacterViewController: UIViewController, StarWarsUniverseViewControllerDelegate, AVAudioPlayerDelegate {
    
    // MARK: Variables ***
    var character : StarWarsCharacter?
    lazy var audioPlayer = AVAudioPlayer()
    
    var playBtn: UIBarButtonItem {
        get {
            return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: "playBtnPressed:")
        }
    }
    var stopBtn: UIBarButtonItem {
        get {
            return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Pause, target: self, action: "playBtnPressed:")
        }
    }
    var wikiBtn: UIBarButtonItem {
        get {
            return UIBarButtonItem(title: "Wiki", style: UIBarButtonItemStyle.Plain, target: self, action: "wikiBtnPressed:")
        }
    }
    var flexibleItem: UIBarButtonItem {
        get {
            return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        }
    }

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
        
        // UIToolbar
        self.toolbar.setItems([self.playBtn,self.flexibleItem,wikiBtn], animated: true)
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
            
            var error:NSError?
            audioPlayer = AVAudioPlayer(data: character.sound, error: &error)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        }
    }
    
    // MARK: IBActions
    
    @IBAction func playBtnPressed(sender: AnyObject) {
        
        if let character = self.character {
            if audioPlayer.playing == false {
                audioPlayer.play()
                self.toolbar.setItems([self.stopBtn,self.flexibleItem,wikiBtn], animated: true)

            } else {
                audioPlayer.stop()
                audioPlayer.currentTime = 0
                self.toolbar.setItems([self.playBtn,self.flexibleItem,wikiBtn], animated: true)

            }
        }
    }
    
    @IBAction func wikiBtnPressed(sender: AnyObject) {
        
        if let character = self.character {
            self.audioPlayer.stop()

            let vc = WikiViewController(character: character)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: StarWarsUniverseViewControllerDelegate ***
    
    func starWarsUniverseVC(swuvc: StarWarsUniverseVC, didSelectCharacter: StarWarsCharacter) {
        println("Character did selected -> \(didSelectCharacter.name)")
        
        self.character = didSelectCharacter
        self.audioPlayer.stop()
        
        syncViewWithModel()
    }
    
    
    // MARK: AVAudioPlayerDelegate ***
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        self.toolbar.setItems([self.playBtn,self.flexibleItem,wikiBtn], animated: true)
    }
}
