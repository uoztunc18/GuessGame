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
    var state = gameState.neutral
    
    var delegate : GuessGameProtocol?
    
    init () {}
    
    
    func pickNumber() {
        pickedNumber = Int.random(in: 1..<11)
    }

    func evaluateGuess(guessedNumber : Int) {
        
        let result = guessedNumber == pickedNumber ? true : false
        
        reduceTry()
        
        if (result) {
            self.state = gameState.win
            return
        } else if (tries == 0 && !result) {
            self.state = gameState.lost
            return
        } else if (isGuessBigger(guessedNumber: guessedNumber)) {
            self.delegate?.guessIsBig()
        } else {
            self.delegate?.guessIsSmall()
        }
        
        if (tries == 1 && !result) {
            self.delegate?.lastTry()
        }
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
