//
//  ViewControllerQuiz.swift
//  Fisica-Equilibrio
//
//  Created by user190336 on 5/15/21.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class ViewControllerQuiz: UIViewController, updateTorqueProtocol {
    
    
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var btnHelp: UIButton!
    @IBOutlet weak var btnExit: UIButton!
    @IBOutlet weak var btnMass: UIButton!
    @IBOutlet weak var btnRule: UIButton!
    @IBOutlet weak var lbResult: UILabel!
    
    var currentScene: QuizScene?
    var player: AVAudioPlayer?
    var sound: Bool!
    var isStarted: Bool = false
    var showMass: Bool = false
    var showRule: Bool = false
    
    var selectedLevel: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "QuizScene") {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
                
                currentScene = scene as? QuizScene
                currentScene?.viewController = self
                
                LoadQuiz()
            }
        }
        
        currentScene?.del = self
        
        //view.addBackground(imageName: "temp-menu-simulator")

        btnCheck.layer.cornerRadius = 9
        btnCheck.layer.borderWidth = 3
        btnCheck.layer.borderColor = UIColor.black.cgColor
        btnHelp.layer.cornerRadius = 9
        btnHelp.layer.borderWidth = 3
        btnHelp.layer.borderColor = UIColor.black.cgColor
        btnExit.layer.cornerRadius = 9
        btnExit.layer.borderWidth = 3
        btnExit.layer.borderColor = UIColor.black.cgColor
    
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    func LoadQuiz() {
        // 0 es el centro de posicion
        print("Loading quiz...")
        switch selectedLevel {
        case 1:
            // 2 bloques
//            let brickPull = Array(stride(from: 10, to: 101, by: 10))
//            let askIndex = Int.random(in: 0..<brickPull.count)
//            let answer = (brickPull[askIndex]/2)
//
//            addBrick(brickWeight: brickPull[askIndex], posX: -1)
//            addBrick(brickWeight: answer, posX: 1)
            let bricks = generateQuiz(N: 2)
            
            addBrick(brickWeight: bricks[0], posX: -1)
            addBrick(brickWeight: bricks[1], posX: 1)
            break
        case 2:
            // 3 bloques
            let randomCount = Int.random(in: 0..<23)
            if randomCount < 2 {
                let brickPull = Array(stride(from: 50, to: 101, by: 50))
                let ask = brickPull[Int.random(in: 0..<brickPull.count)]
                let answ1 = ask/5
                let answ2 = answ1/2
                
                addBrick(brickWeight: ask, posX: -1)
                addBrick(brickWeight: answ1, posX: 0)
                addBrick(brickWeight: answ2, posX: 1)
            } else if (randomCount >= 2 && randomCount < 7) {
                let brickPull = Array(stride(from: 20, to: 101, by: 20))
                let ask = brickPull[Int.random(in: 0..<brickPull.count)]
                let answ1 = ask/2
                let answ2 = answ1/2
                
                addBrick(brickWeight: ask, posX: -1)
                addBrick(brickWeight: answ1, posX: 0)
                addBrick(brickWeight: answ2, posX: 1)
            } else {
                let brickPull = Array(stride(from: 10, to: 86, by: 5))
                let ask = brickPull[Int.random(in: 0..<brickPull.count)]
                let answ1 = ask+15
                let answ2 = ask-5
                
                addBrick(brickWeight: ask, posX: -1)
                addBrick(brickWeight: answ1, posX: 0)
                addBrick(brickWeight: answ2, posX: 1)
            }
            break
        case 3:
            //4 bloques
            let bricks = generateQuiz(N: 4)
            
            addBrick(brickWeight: bricks[0], posX: -2)
            addBrick(brickWeight: bricks[1], posX: -1)
            addBrick(brickWeight: bricks[2], posX: 0)
            addBrick(brickWeight: bricks[3], posX: 1)
            break
        default:
            print("Nivel no identificado")
            break
        }
    }
    
    func generateQuiz(N: Int) -> Array<Int> {
        var result = Array<Int>()
        
        while result.count != N {
            var brickPull = Array(stride(from: 5, to: 101, by: 5))
            
            for _ in 0..<N-1 {
                let randIndex = Int.random(in: 0..<brickPull.count)
                result.append(brickPull[randIndex])
                brickPull.remove(at: randIndex)
            }
            
            result.shuffle()
            
            let d = Array(stride(from: 0.25, to: 1.1, by: 0.25))
            var sum = 0.0
            for i in 0..<result.count {
                let randMult = Int.random(in: 0..<d.count)
                sum += Double(result[i]) * d[randMult]
            }
            
            let res1 = d.map{ sum/$0 }
            let res2 = res1.filter{ ($0.remainder(dividingBy: 5) == 0) }
            let res3 = res2.filter{ ($0 > 0) && ($0 <= 100) }
            var ans = res3.filter{ (brickPull.contains(Int($0))) }
            
            if ans.count > 0 {
                ans.shuffle()
                result.append(Int(ans[0]))
            }
            else {
                result.removeAll()
            }
        }
        
        print(result)
        
        return result
    }

    @IBAction func CheckAnswer(_ sender: UIButton) {
        let result = currentScene!.checkQuiz()
        
        playSound(sound: "button")
        
        lbResult.isHidden = false
        
        lbResult.layer.cornerRadius = 9
        lbResult.layer.borderWidth = 3
        lbResult.layer.borderColor = UIColor.black.cgColor
        
        //begin simulation
        turnSimulation()
        
        if result {
            lbResult.text = "Correcto ✅"
            perform(#selector(exit), with: nil, afterDelay: 3)
        } else {
            lbResult.text = "Incorrecto ❌"
            perform(#selector(hideAnswer), with: nil, afterDelay: 3)
        }
        
        //finish simulation
        perform(#selector(turnSimulation), with: nil, afterDelay: 3)
        
    }
    
    @objc func hideAnswer(){
        lbResult.isHidden = true
    }
    
    @objc func turnSimulation(){
        if isStarted {
            isStarted = false
        }
        else {
            isStarted = true
        }
        currentScene!.isSimulationPlaying = isStarted
        currentScene!.playSimulation()
    }
    
    @IBAction func getHint(_ sender: UIButton) {
        playSound(sound: "button")
        currentScene!.getHint()
    }
    
    @IBAction func CheckboxMass(_ sender: Any) {
        
        if showMass {
            btnMass.setImage(UIImage(named: "unchecked"), for: .normal)
            showMass = false
        }
        else {
            btnMass.setImage(UIImage(named: "checked"), for: .normal)
            showMass = true
        }
        
        playSound(sound: "checkbox")
        currentScene!.showMass(show: showMass)
    }
    
    @IBAction func CheckboxRule(_ sender: Any) {
        if showRule {
            btnRule.setImage(UIImage(named: "unchecked"), for: .normal)
            showRule = false
        }
        else {
            btnRule.setImage(UIImage(named: "checked"), for: .normal)
            showRule = true
        }
        playSound(sound: "checkbox")
        currentScene!.showRuler(show: showRule)
    }
    
    @IBAction func exit(_ sender: UIButton) {
        playSound(sound: "button")
        dismiss(animated: true, completion: nil)
    }
    
    func addBrick(brickWeight: Int, posX: Int) {
        currentScene!.addBrick(brickWeight: brickWeight, posX: posX, swMass: showMass, swForce: false)
    }
    
    func updateTorque(torques: [Double]) {
        playSound(sound: "place")
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let itemsView = segue.destination as? ViewControllerItems
        //itemsView?.delegate = self
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
