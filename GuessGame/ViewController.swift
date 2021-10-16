//
//  ViewController.swift
//  GuessGame
//
//  Created by Umut Öztunç on 12.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    let guessHandler = GuessHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessHandler.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressPlay(_ sender: Any) {
        guessHandler.pickNumber()
        print("Picked number: \(String(describing: guessHandler.pickedNumber))")
        guessHandler.resetTries()
        playButton.isHidden = true
        textLabel.isHidden = false
        textLabel.text = "Good luck"
        field.isHidden = false
        goButton.isHidden = false
    }
    
    @IBAction func makeGuess(_ sender: Any) {

        guard let input = field.text else {
            return
        }

        if (input == "") {

            let alert = UIAlertController(title: "Empty input", message: "Enter a number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }

        guard let intInput = Int(input) else {
            
            let alert = UIAlertController(title: "Wrong type of input", message: "Enter a number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        if ((intInput > 10) || (intInput < 1)) {
            
            let alert = UIAlertController(title: "Guess out of range", message: "Enter a number from 1 to 10", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        print("Entered number: \(intInput)")
        
        textLabel.text = ""
        
        if (guessHandler.calculateWinner(guessedNumber: intInput)) {
            win()
        } else {
            if (guessHandler.tries == 0) {
                lost()
            } else {
                if (guessHandler.isGuessBigger(guessedNumber : intInput)) {
                    arrowImage.isHidden = false
                    arrowImage.image = UIImage(systemName: "arrow.up")
                } else {
                    arrowImage.isHidden = false
                    arrowImage.image = UIImage(systemName: "arrow.down")
                }
            }
        }
        
        field.text = ""
    }
                    
    func win() {
        arrowImage.isHidden = true
        playButton.isHidden = false
        playButton.setTitle("Play again", for: .normal)
        textLabel.isHidden = false
        textLabel.text = "Congratulations"
        field.isHidden = true
        goButton.isHidden = true
    }
    
    func lost() {
        arrowImage.isHidden = true
        playButton.isHidden = false
        playButton.setTitle("Play again", for: .normal)
        textLabel.isHidden = false
        textLabel.text = "You lost"
        field.isHidden = true
        goButton.isHidden = true
    }
}

extension ViewController : GuessGameProtocol {
    func lastTry() {
        textLabel.text = "Last chance!"
    }
}
