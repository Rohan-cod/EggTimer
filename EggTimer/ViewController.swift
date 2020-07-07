

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
    
    var player: AVAudioPlayer!
    
    let eggTime : [String : Int] = ["Soft" : 300, "Medium" : 420, "Hard" : 720]
    
    var secondsRemaining : Float = 60
    
    var c = 0
    
    var total : Float = 60
    
    var per : Float = 1.0
    
    var timer = Timer()
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var eggLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        c=0
        
        progressBar.progress = 1.0
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        
        secondsRemaining = Float(eggTime[hardness]!)
        
        eggLabel.text = sender.currentTitle! + "\n" + "Time: \(Int(secondsRemaining / 60)) min"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer() {
        
        if c==0 {
            total = secondsRemaining
        }
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            c+=1
            per = Float(secondsRemaining / total)
            progressBar.progress = per
        } else {
            timer.invalidate()
            eggLabel.text = "DONE!"
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
        }
    }
}
