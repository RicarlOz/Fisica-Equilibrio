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
    @IBOutlet weak var imgLock: UIImageView!
    @IBOutlet weak var btnMass: UIButton!
    @IBOutlet weak var btnForce: UIButton!
    @IBOutlet weak var btnRule: UIButton!
    @IBOutlet weak var btnLevel: UIButton!
    
    var currentScene: QuizScene?
    var isStarted: Bool = false
    var showMass: Bool = false
    var showForce: Bool = false
    var showRule: Bool = false
    var showLevel: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "QuizScene") {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
                
                currentScene = scene as? QuizScene
                currentScene?.viewController = self
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
    
    func LoadQuiz1() {
        print("Loading quiz 1...")
    }
    
    func LoadQuiz2() {
        print("Loading quiz 2...")
    }
    
    func LoadQuiz3() {
        print("Loading quiz 3...")
    }
    
    @IBAction func closeItems(segue: UIStoryboardSegue) {
        
    }

    @IBAction func StartSimulation(_ sender: Any) {
        
        if isStarted {
            imgLock.image = UIImage(named: "locked")
            isStarted = false
        }
        else {
            imgLock.image = UIImage(named: "unlocked")
            isStarted = true
        }
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
    
    @IBAction func CheckboxForce(_ sender: Any) {
        if showForce {
            btnForce.setImage(UIImage(named: "unchecked"), for: .normal)
            showForce = false
        }
        else {
            btnForce.setImage(UIImage(named: "checked"), for: .normal)
            showForce = true
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
    
    @IBAction func CheckboxLevel(_ sender: Any) {
        if showLevel {
            btnLevel.setImage(UIImage(named: "unchecked"), for: .normal)
            showLevel = false
        }
        else {
            btnLevel.setImage(UIImage(named: "checked"), for: .normal)
            showLevel = true
        }
    }
    
    @IBAction func exit(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func addBrick(brickWeight: Int) {
        //currentScene!.addBrick(brickWeight: brickWeight, swMass: showMass)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let itemsView = segue.destination as? ViewControllerItems
        //itemsView?.delegate = self
    }

    
    // MARK: - Navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//    }
    

}
