//
//  GuessHandler.swift
//  GuessGame
//
//  Created by Umut Öztunç on 12.10.2021.
//

import Foundation

class GuessHandler {
    var pickedNumber: Int = 0
    var tries: Int?
    
    var delegate : GuessGameProtocol?
    
    init () {}
    
    func pickNumber() {
        pickedNumber = Int.random(in: 1..<11)
    }

    func calculateWinner(guessedNumber : Int) -> Bool {
        
        let result = guessedNumber == pickedNumber ? true : false
        
        reduceTry()

        if (tries == 1 && !result) {
            self.delegate?.lastTry()
        }
        
        if (result) {
            tries = 0
        }
        
        return result
    }
    
    func isGuessBigger(guessedNumber : Int) -> Bool {
        if (guessedNumber > pickedNumber) {
            return true
        } else {
            return false
        }
    }
    
    func reduceTry() {
        tries! -= 1
    }
    
    func resetTries() {
        tries = 3
    }
}
