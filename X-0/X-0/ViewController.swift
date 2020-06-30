//
//  ViewController.swift
//  X-0
//
//  Created by Wrood Alrashidi on 27/06/2020.
//  Copyright © 2020 Wrood Alrashidi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b6: UIButton!
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var b8: UIButton!
    @IBOutlet weak var b9: UIButton!
    
    
    
    @IBOutlet weak var xScore: UILabel!
    @IBOutlet weak var oScore: UILabel!
     var xcounter = 0
    var ocounter = 0
    
    @IBOutlet weak var turnLabel: UILabel!
    
    var backroundMusic: AVAudioPlayer?
    var catSound: AVAudioPlayer?
    var dogSound: AVAudioPlayer?
    var whistleSound: AVAudioPlayer?
    //var background: [UIColor] =
    func playMusic() {
        let path = Bundle.main.path(forResource: "tomAndJerry.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            backroundMusic = try AVAudioPlayer(contentsOf: url)
            backroundMusic?.play()
            backroundMusic?.numberOfLoops = -1

        } catch {
            
        }
    }
    
    func playCat() {
        let path = Bundle.main.path(forResource: "cat.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            catSound = try AVAudioPlayer(contentsOf: url)
            catSound?.play()
        } catch {
            
        }
    }
    
    func playDog() {
        let path = Bundle.main.path(forResource: "dog.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            dogSound = try AVAudioPlayer(contentsOf: url)
            dogSound?.play()
        } catch {
            
        }
    }
    
    func playWhistle() {
        let path = Bundle.main.path(forResource: "Whistling.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            whistleSound = try AVAudioPlayer(contentsOf: url)
            whistleSound?.play()
        } catch {
            
        }
    }
    
    var buttons: [UIButton] = []
    var counter = 0
    
    override func viewDidLoad() {
        buttons = [b1, b2, b3, b4, b5, b6, b7, b8, b9]
        playMusic()
    }
    
    @IBAction func press(_ sender: UIButton) {
        print("تم الضغط علي!")
        print(counter)
        
        if counter % 2 == 0{
            playCat()
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            
            sender.setTitle("😼", for: .normal)
            sender.setTitleColor(.white, for: .normal)
            turnLabel.text = "🐶 Turn"
        }
        else {
            playDog()
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            sender.setTitle("🐶", for: .normal)
            sender.setTitleColor(.black, for: .normal)
            turnLabel.text = "😼 Turn"
            
        }
        
       
        sender.isEnabled = false
        if counter == 8
        {
            self.alert(winner: "DRRRRRRRAW")
        }
         counter += 1
        Winning(winner: "😼")
        Winning(winner: "🐶")
        
    }
   
   
    
    
    
    @IBAction func resetTapped() {
        self.restartGame()
        ocounter = 0
        xcounter = 0
        oScore.text = ""
        xScore.text = ""
    }
    
    
    
    func Winning(winner: String)
    {
        if  (b1.titleLabel?.text == winner && b2.titleLabel?.text == winner && b3.titleLabel?.text == winner) ||
            (b4.titleLabel?.text == winner && b5.titleLabel?.text == winner && b6.titleLabel?.text == winner) ||
            (b7.titleLabel?.text == winner && b7.titleLabel?.text == winner && b9.titleLabel?.text == winner) ||
            (b1.titleLabel?.text == winner && b4.titleLabel?.text == winner && b7.titleLabel?.text == winner) ||
            (b2.titleLabel?.text == winner && b5.titleLabel?.text == winner && b8.titleLabel?.text == winner) ||
            (b3.titleLabel?.text == winner && b6.titleLabel?.text == winner && b9.titleLabel?.text == winner) ||
            (b1.titleLabel?.text == winner && b5.titleLabel?.text == winner && b9.titleLabel?.text == winner) ||
            (b3.titleLabel?.text == winner && b5.titleLabel?.text == winner && b7.titleLabel?.text == winner)
            
        {
            print("\(winner) is the winner")
     
            scoreBoard(player: winner)
            restartGame()
        }
        
    }
  
    
    func restartGame() {
        
        for b in buttons{
            b.setTitle("", for: .normal)
            b.titleLabel?.text = ""
            b.isEnabled = true
            view.backgroundColor = randomColor()
            
        }
        
        counter = 0
        turnLabel.text = "😼 Turn"
      
    }
    
    
    func scoreBoard(player: String) {
        if player == "😼" {
            xcounter += 1
            xScore.text = String(xcounter)
        
            self.restartGame()
            
        }
        if player == "🐶" {
            ocounter += 1
            oScore.text = String(ocounter)
           
            self.restartGame()
            
        }
        
        if xcounter == 3 {
            alert(winner: "😼")
            xcounter = 0
            ocounter = 0
            oScore.text = ""
            xScore.text = ""
          self.restartGame()
            playWhistle()
        }
        if ocounter == 3 {
            alert(winner: "🐶")
            ocounter = 0
            xcounter = 0
            oScore.text = ""
            xScore.text = ""
           self.restartGame()
            playWhistle()
        }
        
    }
    
   func randomColor() -> UIColor{
       let red = CGFloat(drand48())
       let green = CGFloat(drand48())
       let blue = CGFloat(drand48())
       return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
   }
    
    func alert (winner : String)
    {
        let alertController = UIAlertController(title: "\(winner) Won", message: "", preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Play Again", style: .cancel) { (alert) in
            self.restartGame()
        }
        alertController.addAction(restartAction)
        present(alertController, animated: true, completion: nil)
    }
}
