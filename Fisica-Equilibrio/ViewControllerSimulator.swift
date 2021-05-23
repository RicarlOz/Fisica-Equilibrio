//
//  ViewControllerSimulator.swift
//  
//
//  Created by user190336 on 4/20/21.
//

import UIKit
import SpriteKit
import GameplayKit

class ViewControllerSimulator: UIViewController, AddBrickProtocol {
    
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnItems: UIButton!
    @IBOutlet weak var btnExit: UIButton!
    @IBOutlet weak var lbTorque: UILabel!
    @IBOutlet weak var vTools: UIView!
    @IBOutlet weak var imgLock: UIImageView!
    @IBOutlet weak var btnMass: UIButton!
    @IBOutlet weak var btnForce: UIButton!
    @IBOutlet weak var btnRule: UIButton!
    @IBOutlet weak var btnLevel: UIButton!
    
    var currentScene: SimulatorScene?
    var isStarted: Bool = false
    var showMass: Bool = false
    var showForce: Bool = false
    var showRule: Bool = false
    var showLevel: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "SimulatorScene") {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
                
                currentScene = scene as? SimulatorScene
                currentScene?.viewController = self
            }
        }
        
        //view.addBackground(imageName: "temp-menu-simulator")

        btnStart.layer.cornerRadius = 9
        btnStart.layer.borderWidth = 3
        btnStart.layer.borderColor = UIColor.black.cgColor
        btnItems.layer.cornerRadius = 9
        btnItems.layer.borderWidth = 3
        btnItems.layer.borderColor = UIColor.black.cgColor
        btnExit.layer.cornerRadius = 9
        btnExit.layer.borderWidth = 3
        btnExit.layer.borderColor = UIColor.black.cgColor
        lbTorque.layer.cornerRadius = 9
        lbTorque.layer.masksToBounds = true
        vTools.layer.cornerRadius = 9
    
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    @IBAction func closeItems(segue: UIStoryboardSegue) {
        
    }

    @IBAction func StartSimulation(_ sender: Any) {
        
        if isStarted {
            //imgLock.image = UIImage(named: "locked")
            isStarted = false
        }
        else {
            //imgLock.image = UIImage(named: "unlocked")
            isStarted = true
        }
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
        currentScene!.showMass(show: showMass)
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
        
        currentScene!.showRuler(show: showRule)
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
        currentScene!.addBrick(brickWeight: brickWeight, swMass: showMass)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let itemsView = segue.destination as? ViewControllerItems
        itemsView?.delegate = self
    }

}
