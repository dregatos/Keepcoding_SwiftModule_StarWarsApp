    //
//  StarWarsUniverseVC.swift
//  StartWarsSwift
//
//  Created by David Regatos on 11/05/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

import UIKit

// MARK: PROTOCOLS ***

protocol StarWarsUniverseViewControllerDelegate {
    
    func starWarsUniverseVC(swuvc: StarWarsUniverseVC, didSelectCharacter: StarWarsCharacter)
}

// MARK: StarWarsUniverseVC ***
class StarWarsUniverseVC: UITableViewController, StarWarsUniverseViewControllerDelegate {
    
    // MARK: constants ***
    let IMPERIALS_SECTION_INDEX = 0
    let REBELS_SECTION_INDEX = 1
    let OTHERS_SECTION_INDEX = 2   // NOT USED
    
    let cellIdentifier = "Cell"
    
    // MARK: variables ***
    var universe : StarWarsUniverse?
    var delegate:StarWarsUniverseViewControllerDelegate! = nil

    // MARK: Lifecycle ***
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
        self.title = "StarWars Universe";
    }
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(style: UITableViewStyle, universe: StarWarsUniverse) {
        self.init(style: style)
        self.universe = universe
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View events ***
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: - Table view data source and delegates ***
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let universe = self.universe {
            return universe.number(ofCharactersWithType: starWarsCharacterType(forSection: section))
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Regular cell
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "CELL")
        }
        
        // Custom cell
        //        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        if let character = starWarsCharacter(atIndexPath: indexPath) {
            // Configure the cell...
            cell!.textLabel?.text = character.name
            cell!.detailTextLabel?.text = character.alias
            cell!.imageView?.image = character.photo
            cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == IMPERIALS_SECTION_INDEX {
            return "Imperials"
        } else if section == REBELS_SECTION_INDEX {
            return "Rebels"
        }
        
        return "Others"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let var selected = starWarsCharacter(atIndexPath: indexPath) {
            
            // Call our delegate
            delegate?.starWarsUniverseVC(self, didSelectCharacter: selected)
            
            // Send notification
            let notKey = GlobalConstants.NotificationName.CHARACTER_DID_SELECT
            let dic = [GlobalConstants.NotificationKey.CHARACTER : selected]
            NSNotificationCenter.defaultCenter().postNotificationName(notKey, object: self, userInfo:dic)
            
            // Save last selected character
            var coords: Array<Int> = [indexPath.section,indexPath.row]
            var def = NSUserDefaults.standardUserDefaults()
            def.setObject(coords, forKey: GlobalConstants.Keys.LAST_SELECTED_CHARACTER)
            def.synchronize()
        }
    }
    
    // MARK: Helpers ***
    
    func starWarsCharacterType(forSection section: Int) -> CharacterType {
        
        if section == REBELS_SECTION_INDEX {
            return .Rebels
        } else if section == IMPERIALS_SECTION_INDEX {
            return .Imperials
        }
        
        return .Others
    }
    
    func starWarsCharacter(atIndexPath indexPath: NSIndexPath) -> StarWarsCharacter? {
        let type = starWarsCharacterType(forSection: indexPath.section)
        let character = self.universe?.character(ofType: type, atIndex: indexPath.row)
        return character
    }
    
    // MARK: StarWarsUniverseViewControllerDelegate ***
    
    func starWarsUniverseVC(swuvc: StarWarsUniverseVC, didSelectCharacter: StarWarsCharacter) {
        println("Character did selected -> \(didSelectCharacter.name)")
        
        let vc = CharacterViewController(character: didSelectCharacter)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
