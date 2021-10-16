//
//  ViewController.swift
//  GuessGame
//
//  Created by Umut Öztunç on 12.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var advice: UILabel!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var goButton: UIButton!
    
    let guessHandler = GuessHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessHandler.pickNumber()
        guessHandler.resetTries()
        guessHandler.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func makeGuess(_ sender: Any) {
        
//        if guessHandler.tries == 0 || textLabel.text == "Congratulations" {
//            resetGame()
//            textLabel.text = "Good luck"
//        } else {
//
//            guard let input = field.text else {
//                fatalError("error")
//            }
//
//            guard let intInput = Int(input) else {
//                fatalError("error")
//            }
//
//            print("Entered number: \(intInput)")
//
//            if guessHandler.calculateWinner(guessedNumber: intInput) {
//                textLabel.text = "Congratulations"
//            } else {
//                if guessHandler.tries == 0 {
//                    textLabel.text = "You lost"
//                } else {
//                    if (guessHandler.isGuessBigger(guessedNumber : intInput)) {
//                        textLabel.text = "Go down"
//                    } else {
//                        textLabel.text = "Go up"
//                    }
//                    // textLabel.text = "Try again"
//                }
//            }
//        }
        
        if (guessHandler.tries != 0) {
            guard let input = field.text else {
                fatalError("error")
            }

            guard let intInput = Int(input) else {
                fatalError("error")
            }
            
            print("Entered number: \(intInput)")
            
            if (guessHandler.calculateWinner(guessedNumber: intInput)) {
                win()
                guessHandler.tries = 0
            } else {
                if (guessHandler.tries == 0) {
                    lost()
                } else {
                    if (guessHandler.isGuessBigger(guessedNumber : intInput)) {
                        advice.text = "Go down"
                    } else {
                        advice.text = "Go up"
                    }
                    textLabel.text = "Try again"
                }
            }
            
//            if (guessHandler.tries == 0) {
//                goButton.setTitle("Play again", for: .normal)
//            }
            
        } else {
            resetGame()
        }
        
    }
                    
    func win() {
        textLabel.text = "Congratulations"
        advice.text = ""
        goButton.setTitle("Play again", for: .normal)
    }
    
    func lost() {
        textLabel.text = "You lost"
        advice.text = ""
        goButton.setTitle("Play again", for: .normal)
    }
    
    func resetGame() {
        guessHandler.resetTries()
        textLabel.text = "Good luck"
        goButton.setTitle("Go", for: .normal)
        guessHandler.pickNumber()
        
        print("Picked number: \(guessHandler.pickedNumber)")
    }
}

extension ViewController : GuessGameProtocol {
    func lastTry() {
        goButton.setTitle("Play again", for: .normal)
    }
    
    func resetButton() {
        goButton.setTitle("Play again", for: .normal)
    }
    
}
