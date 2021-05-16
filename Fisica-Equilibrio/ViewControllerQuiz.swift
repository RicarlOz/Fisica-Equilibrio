//
//  ViewControllerQuiz.swift
//  Fisica-Equilibrio
//
//  Created by user190336 on 5/15/21.
//

import UIKit
import SpriteKit
import GameplayKit

class ViewControllerQuiz: UIViewController {
    
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var btnHelp: UIButton!
    @IBOutlet weak var btnExit: UIButton!
    //@IBOutlet weak var imgLock: UIImageView!
    @IBOutlet weak var btnMass: UIButton!
    @IBOutlet weak var btnRule: UIButton!
    @IBOutlet weak var lbResult: UILabel!
    
    var currentScene: QuizScene?
//    var isStarted: Bool = false
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
            addBrick(brickWeight: 30, posX: 1)
            addBrick(brickWeight: 30, posX: -1)
            break
        case 2:
            addBrick(brickWeight: 20, posX: -1)
            addBrick(brickWeight: 10, posX: 0)
            break
        case 3:
            addBrick(brickWeight: 15, posX: 0)
            addBrick(brickWeight: 30, posX: 1)
            break
        default:
            print("Nivel no identificado")
            break
        }
    }

    @IBAction func CheckAnswer(_ sender: UIButton) {
        let result = currentScene!.checkQuiz()
        
        lbResult.isHidden = false
        
        lbResult.layer.cornerRadius = 9
        lbResult.layer.borderWidth = 3
        lbResult.layer.borderColor = UIColor.black.cgColor
        
        if result {
            lbResult.text = "Correcto ✅"
        } else {
            lbResult.text = "Incorrecto ❌"
        }
    }
    
    @IBAction func getHint(_ sender: UIButton) {
        
    }
    
    @IBAction func CheckboxMass(_ sender: Any) {
        
        if showMass {
            btnMass.setImage(UIImage(named: "unchecked"), for: .normal)
            showMass = false
            
            currentScene!.showMass(show: showMass)
        }
        else {
            btnMass.setImage(UIImage(named: "checked"), for: .normal)
            showMass = true
            
            currentScene!.showMass(show: showMass)
        }
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
    }
    
    @IBAction func exit(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func addBrick(brickWeight: Int, posX: Int) {
        currentScene!.addBrick(brickWeight: brickWeight, posX: posX, swMass: showMass)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let itemsView = segue.destination as? ViewControllerItems
        //itemsView?.delegate = self
    }

}
