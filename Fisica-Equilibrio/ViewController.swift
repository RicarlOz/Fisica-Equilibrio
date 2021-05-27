//
//  ViewController.swift
//  Fisica-Equilibrio
//
//  Created by user190336 on 4/15/21.
//

import UIKit
import AVFoundation

extension UIView {
    func addBackground(imageName: String = "menu-background", contentMode: UIView.ContentMode = .scaleToFill) {
        // setup the UIImageView
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: imageName)
        backgroundImageView.contentMode = contentMode
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)

        // adding NSLayoutConstraints
        let leadingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)

        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var btSound: UIButton!
    
    var sound: Bool = true
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addBackground()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    @IBAction func seleccion(_ sender: Any) {
        playSound(sound: "button")
    }
    
    @IBAction func mute(_ sender: Any) {
        sound = !sound
        if sound {
            btSound.setImage(UIImage(systemName: "speaker.wave.3.fill"), for: .normal)
        }
        else {
            btSound.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
        }
        btSound.tintColor = UIColor.black
    }
    
    func playSound(sound: String) {
        let pathToSound = Bundle.main.path(forResource: sound, ofType: "mp3")!
        let url = URL(fileURLWithPath: pathToSound)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            if self.sound {
                player?.play()
            }
        } catch {
            print("hubo un error con el sonido: " + sound)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "simulator" {
            let simulatorView = segue.destination as! ViewControllerSimulator
            
            simulatorView.sound = sound
        }
        else {
            let quizView = segue.destination as! QuizViewController
            
            quizView.sound = sound
        }
    }
}

