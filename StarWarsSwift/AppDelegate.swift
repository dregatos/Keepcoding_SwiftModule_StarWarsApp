//
//  AppDelegate.swift
//  StarWarsSwift
//
//  Created by David Regatos on 13/05/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Model
        let universe = StarWarsUniverse()
        println(universe.description)
        
        var rootVC : UIViewController?
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            rootVC = configureForPad(forModel: universe)
        } else {
            rootVC = configureForPhone(forModel: universe)
        }

        // Window
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.rootViewController = rootVC!
        self.window!.backgroundColor = UIColor.clearColor()
        self.window!.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    // MARK: Helpers
    
    func configureForPad(forModel model: StarWarsUniverse) -> UIViewController {
        // ViewControllers
        var tableVC = StarWarsUniverseVC(style: .Grouped, universe: model)
        var leftNavVC = UINavigationController(rootViewController: tableVC)
        
        var selectedCharacter = lastSelectedCharacter(inStarWarsUniverseVC: tableVC)
        var characterVC = CharacterViewController(character: selectedCharacter)
        var rightNavVC = UINavigationController(rootViewController: characterVC)
        
        // UISplitVC
        var splitVC = UISplitViewController()
        splitVC.viewControllers = [leftNavVC,rightNavVC]
        
        // delegates
        tableVC.delegate = characterVC
        
        return splitVC
    }
    
    func configureForPhone(forModel model: StarWarsUniverse) -> UIViewController {
        // ViewControllers
        var tableVC = StarWarsUniverseVC(style: .Grouped, universe: model)
        var navVC = UINavigationController(rootViewController: tableVC)
    
        // delegates
        tableVC.delegate = tableVC
        
        return navVC
    }
    

    func lastSelectedCharacter(inStarWarsUniverseVC universeVC: StarWarsUniverseVC) -> StarWarsCharacter {
        
        var def = NSUserDefaults.standardUserDefaults()
        var coords: Array<Int> = [0,0] // default
        if let storedCoord = def.objectForKey(GlobalConstants.Keys.LAST_SELECTED_CHARACTER) as? Array<Int> {
            coords = storedCoord
        }
        
        var indexPath = NSIndexPath(forRow: coords[1], inSection: coords[0])
        var character = universeVC.starWarsCharacter(atIndexPath: indexPath)

        if let selected = character {
            return selected
        } else {
            return universeVC.universe!.imperials[0]
        }
    }

}

