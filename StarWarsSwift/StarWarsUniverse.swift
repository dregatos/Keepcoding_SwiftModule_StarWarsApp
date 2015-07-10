//
//  StarWatsUniverse.swift
//  StarWarsSwift
//
//  Created by David Regatos on 10/07/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

import Foundation

enum CharacterType {
    case Rebels, Imperials, Others
}

class StarWarsUniverse : Printable {
    
    // Variables ***
    private(set) var imperials = Array<StarWarsCharacter>()
    private(set) var rebels = Array<StarWarsCharacter>()
    private(set) var others = Array<StarWarsCharacter>()
    
    // Init ***
    init(imperials:Array<StarWarsCharacter>,rebels:Array<StarWarsCharacter>, others:Array<StarWarsCharacter>) {     //designated
        self.imperials = imperials;
        self.rebels = rebels;
        self.others = others
    }
    
    convenience init(){
        self.init(imperials: loadImperialCharacters(), rebels: loadRebelCharacters(), others:loadOtherCharacters())
    }
    
    // Methods ***
    func number(ofCharactersWithType type: CharacterType) -> Int {
        switch type {
        case .Rebels:
            return rebels.count
        case .Imperials:
            return imperials.count
        case .Others:
            return others.count
        default:
            return 0
        }
    }
    
    func character(ofType type: CharacterType, atIndex index: Int) -> StarWarsCharacter {
        switch type {
        case .Rebels:
            if rebels.count > index {
                return rebels[index]
            } else {
                return StarWarsCharacter()
            }
        case .Imperials:
            if imperials.count > index {
                return imperials[index]
            } else {
                return StarWarsCharacter()
            }
        case .Others:
            if others.count > index {
                return others[index]
            } else {
                return StarWarsCharacter()
            }
        default:
            return StarWarsCharacter()
        }
    }
    
    // Protocols ***
    // Printable
    var description : String {
        return "< *** Star Wars Universe ***\n Imperials count: \(imperials.count)\n Rebels count: \(rebels.count)\n Others count: \(others.count)\n"
    }
}