//
//  Models.swift
//  StarWarsSwift
//
//  Created by David Regatos on 13/05/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

import Foundation
import UIKit

func loadImperialCharacters () -> Array<StarWarsCharacter> {
    // Imperials **
    // Vader
    var vaderURL = NSURL(string: "http://en.wikipedia.org/wiki/Darth_Vader")
    var vaderIm = UIImage(named: "darthVader.jpg")
    var vaderSound : NSData? = nil
    if let resourceUrl = NSBundle.mainBundle().URLForResource("vader", withExtension: "caf") {
        if NSFileManager.defaultManager().fileExistsAtPath(resourceUrl.path!) {
            vaderSound = NSData(contentsOfURL: resourceUrl)
        }
    }
    var vader = StarWarsCharacter(name: "Anakyn Skywalker",
                                alias: "Darth Vader",
                                photo: vaderIm,
                                wikiURL: vaderURL,
                                sound: vaderSound)
    
    // Tarkin
    var tarkinURL = NSURL(string: "http://en.wikipedia.org/wiki/Grand_Moff_Tarkin")
    var tarkinIm = UIImage(named: "tarkin.jpg")
    var tarkinSound : NSData? = nil
    if let resourceUrl = NSBundle.mainBundle().URLForResource("tarkin", withExtension: "caf") {
        if NSFileManager.defaultManager().fileExistsAtPath(resourceUrl.path!) {
            tarkinSound = NSData(contentsOfURL: resourceUrl)
        }
    }
    var tarkin = StarWarsCharacter(name: "Wilhuf Tarkin",
                                    alias: "Grand Moff Tarkin",
                                    photo: tarkinIm,
                                    wikiURL: tarkinURL,
                                    sound: tarkinSound)
    
    // Palpatine
    var palpatineURL = NSURL(string: "http://en.wikipedia.org/wiki/Palpatine")
    var palpatineIm = UIImage(named: "palpatine.jpg")
    var palpatineSound : NSData? = nil
    if let resourceUrl = NSBundle.mainBundle().URLForResource("palpatine", withExtension: "caf") {
        if NSFileManager.defaultManager().fileExistsAtPath(resourceUrl.path!) {
            palpatineSound = NSData(contentsOfURL: resourceUrl)
        }
    }
    var palpatine = StarWarsCharacter(name: "Palpatine",
                                    alias: "Darth Sidious",
                                    photo: palpatineIm,
                                    wikiURL: palpatineURL,
                                    sound: palpatineSound)
    
    
    return Array<StarWarsCharacter>(arrayLiteral: vader,tarkin,palpatine)
}

func loadRebelCharacters () -> Array<StarWarsCharacter> {
    // Rebels **
    // Chewbacca
    var chewieURL = NSURL(string: "http://en.wikipedia.org/wiki/Chewbacca")
    var chewieIm = UIImage(named: "chewbacca.jpg")
    var chewieSound : NSData? = nil
    if let resourceUrl = NSBundle.mainBundle().URLForResource("chewbacca", withExtension: "caf") {
        if NSFileManager.defaultManager().fileExistsAtPath(resourceUrl.path!) {
            chewieSound = NSData(contentsOfURL: resourceUrl)
        }
    }
    var chewie = StarWarsCharacter(name: "Chewbacca",
                                photo: chewieIm,
                                wikiURL: chewieURL,
                                sound: chewieSound)
    
    // C-3PO
    var c3poURL = NSURL(string: "http://en.wikipedia.org/wiki/C-3PO")
    var c3poIm = UIImage(named: "c3po.jpg")
    var c3poSound : NSData? = nil
    if let resourceUrl = NSBundle.mainBundle().URLForResource("c3po", withExtension: "caf") {
        if NSFileManager.defaultManager().fileExistsAtPath(resourceUrl.path!) {
            c3poSound = NSData(contentsOfURL: resourceUrl)
        }
    }
    var c3po = StarWarsCharacter(name: "C-3PO",
                                photo: c3poIm,
                                wikiURL: c3poURL,
                                sound: c3poSound)
    
    // Yoda
    var yodaURL = NSURL(string: "http://en.wikipedia.org/wiki/Yoda")
    var yodaIm = UIImage(named: "yoda.jpg")
    var yodaSound : NSData? = nil
    if let resourceUrl = NSBundle.mainBundle().URLForResource("yoda", withExtension: "caf") {
        if NSFileManager.defaultManager().fileExistsAtPath(resourceUrl.path!) {
            yodaSound = NSData(contentsOfURL: resourceUrl)
        }
    }
    var yoda = StarWarsCharacter(name: "Minch Yoda",
                                alias: "Master Yoda",
                                photo: yodaIm,
                                wikiURL: yodaURL,
                                sound: yodaSound)
    
    // R2-D2
    var r2d2URL = NSURL(string: "http://en.wikipedia.org/wiki/R2-D2")
    var r2d2Im = UIImage(named: "r2-d2.jpg")
    var r2d2Sound : NSData? = nil
    if let resourceUrl = NSBundle.mainBundle().URLForResource("r2-d2", withExtension: "caf") {
        if NSFileManager.defaultManager().fileExistsAtPath(resourceUrl.path!) {
            r2d2Sound = NSData(contentsOfURL: resourceUrl)
        }
    }
    var r2d2 = StarWarsCharacter(name: "R2-D2",
                                photo: r2d2Im,
                                wikiURL: r2d2URL,
                                sound: r2d2Sound)
    
    
    return Array<StarWarsCharacter>(arrayLiteral: chewie,c3po,yoda,r2d2)
}

func loadOtherCharacters () -> Array<StarWarsCharacter> {
    return Array<StarWarsCharacter>()
}