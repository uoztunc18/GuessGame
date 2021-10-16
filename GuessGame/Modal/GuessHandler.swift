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
        
//        if tries == 1 {
//            self.delegate?.lastTry()
//        }
//
//        if guessedNumber == pickedNumber {
//            self.delegate?.lastTry()
//        }
        
        reduceTry()
        
        if (tries == 0) {
            self.delegate?.resetButton()
        }
        
        return guessedNumber == pickedNumber ? true : false
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
