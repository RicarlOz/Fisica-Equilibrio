//
//  ViewControllerSimulator.swift
//  
//
//  Created by user190336 on 4/20/21.
//

import UIKit

class ViewControllerSimulator: UIViewController, addBlockProtocol {
    
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnItems: UIButton!
    @IBOutlet weak var lbTorque: UILabel!
    @IBOutlet weak var vTools: UIView!
    @IBOutlet weak var imgLock: UIImageView!
    @IBOutlet weak var btnMass: UIButton!
    @IBOutlet weak var btnForce: UIButton!
    @IBOutlet weak var btnRule: UIButton!
    @IBOutlet weak var btnLevel: UIButton!
    @IBOutlet weak var imgBar: UIImageView!
    
    var isStarted: Bool = false
    var showMass: Bool = false
    var showForce: Bool = false
    var showRule: Bool = false
    var showLevel: Bool = false
    var blocks = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addBackground(imageName: "simulator-bg")

        btnStart.layer.cornerRadius = 9
        btnStart.layer.borderWidth = 3
        btnStart.layer.borderColor = UIColor.black.cgColor
        btnItems.layer.cornerRadius = 9
        btnItems.layer.borderWidth = 3
        btnItems.layer.borderColor = UIColor.black.cgColor
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
    
    func addBlock(block: Block) {
        var blockHeight = CGFloat(30.0)
        let blockWidth = imgBar.frame.size.width / 8
        let blockX = view.frame.size.width / 2 - (blockWidth / 2)
        var blockY = view.frame.size.height / 3
        
        if block.weight >= 35 && block.weight <= 60 {
            blockHeight = blockHeight * 2
            blockY = blockY - 15
        }
        else if block.weight >= 65 && block.weight <= 90 {
            blockHeight = blockHeight * 3
            blockY = blockY - 30
        }
        else if block.weight >= 95 && block.weight <= 100 {
            blockHeight = blockHeight * 4
            blockY = blockY - 45
        }
        
        let newBlock = UIView(frame: CGRect(x: blockX, y: blockY, width: blockWidth, height: blockHeight))
        newBlock.addBackground(imageName: "\(block.weight)")
        newBlock.tag = blocks.count
        
        let weightLb = UILabel(frame: CGRect(x: 0, y: 0, width: blockWidth, height: blockHeight))
        weightLb.textAlignment = .center
        weightLb.font = UIFont(name: "Questrial", size: 12.0)
        weightLb.text = String(block.weight) + " Kg"
        newBlock.addSubview(weightLb)
        
        view.addSubview(newBlock)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let itemsView = segue.destination as? ViewControllerItems
        itemsView?.delegate = self
    }
    

}
