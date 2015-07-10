//
//  StarWarsCharacter.swift
//  StarWarsSwift
//
//  Created by David Regatos on 10/07/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

import Foundation
import UIKit

class StarWarsCharacter : Printable {
    
    // Variables ***
    private(set) var name = "Unknown";
    private(set) var alias = "Unknown";
    private(set) var photo : UIImage? = nil;
    private(set) var wikiURL : NSURL? = nil;
    private(set) var sound : NSData? = nil;
    
    // Init ***
    init(){}                //default init
    
    init(name:String,alias:String,photo:UIImage?,wikiURL:NSURL?,sound:NSData?) {     //designated
        self.name = name;
        self.alias = alias;
        self.photo = photo;
        self.wikiURL = wikiURL;
        self.sound = sound;
    }
    
    init(name:String,photo:UIImage?,wikiURL:NSURL?,sound:NSData?) {     //designated
        self.name = name;
        self.alias = "Unknown";
        self.photo = photo;
        self.wikiURL = wikiURL;
        self.sound = sound;
    }
    
    // Protocols ***
    // Printable
    var description : String {
        return "< *** Star Wars Character ***\n Name: \(name)\n Alias: \(alias)\n Photo file: \(photo)\n wikiURL: \(wikiURL)\n sound: \(sound)\n"
    }
}