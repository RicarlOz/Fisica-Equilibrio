//
//  ViewControllerSimulator.swift
//  
//
//  Created by user190336 on 4/20/21.
//

import UIKit

class ViewControllerSimulator: UIViewController {

    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnObjects: UIButton!
    @IBOutlet weak var lbTorque: UILabel!
    @IBOutlet weak var vTools: UIView!
    @IBOutlet weak var imgLock: UIImageView!
    @IBOutlet weak var btnMass: UIButton!
    @IBOutlet weak var btnForce: UIButton!
    @IBOutlet weak var btnRule: UIButton!
    @IBOutlet weak var btnLevel: UIButton!
    
    var isStarted: Bool = false
    var showMass: Bool = false
    var showForce: Bool = false
    var showRule: Bool = false
    var showLevel: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgBackground.image = UIImage(named: "simulator-bg")
        btnStart.layer.cornerRadius = 9
        btnStart.layer.borderWidth = 3
        btnStart.layer.borderColor = UIColor.black.cgColor
        btnObjects.layer.cornerRadius = 9
        btnObjects.layer.borderWidth = 3
        btnObjects.layer.borderColor = UIColor.black.cgColor
        lbTorque.layer.cornerRadius = 9
        lbTorque.layer.masksToBounds = true
        vTools.layer.cornerRadius = 9
    
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
        }
        else {
            btnMass.setImage(UIImage(named: "checked"), for: .normal)
            showMass = true
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
