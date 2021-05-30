//
//  QuizViewController.swift
//  Fisica-Equilibrio
//
//  Created by user189096 on 4/20/21.
//

import UIKit
import AVFoundation

class QuizViewController: UIViewController {
    
    var player: AVAudioPlayer?
    var sound: Bool!
    var selectedQuiz: Int = -1

    @IBOutlet weak var imgBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addBackground(imageName: "quiz-background")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loadQuiz1(_ sender: UIButton) {
        playSound(sound: "button")
        selectedQuiz = 1
    }
    
    @IBAction func loadQuiz2(_ sender: UIButton) {
        playSound(sound: "button")
        selectedQuiz = 2
    }
    
    @IBAction func loadQuiz3(_ sender: UIButton) {
        playSound(sound: "button")
        selectedQuiz = 3
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizView = segue.destination as! ViewControllerQuiz
        
        quizView.sound = sound
        
        if let level = segue.identifier {
            if (level == "1" || level == "2" || level == "3") {
                quizView.selectedLevel = Int(level)
            } else {
                print("Quiz doesn't exists.")
            }
        }
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
}
