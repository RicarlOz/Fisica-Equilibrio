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
    var blockSpaces = [false, false, false, false, false, false, false, false]
    
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
            
            for block in blocks {
                block.viewWithTag(10)?.isHidden = true
            }
        }
        else {
            btnMass.setImage(UIImage(named: "checked"), for: .normal)
            showMass = true
            
            for block in blocks {
                block.viewWithTag(10)?.isHidden = false
            }
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
    
    @objc func PanGestureHandler(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        blocks[gesture.view!.tag].transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        
        let xBar = imgBar.frame.origin.x
        let height = blocks[gesture.view!.tag].frame.size.height
        let width = blocks[gesture.view!.tag].frame.size.width

        let xPos = translation.x + (view.frame.size.width / 2) - (width / 2)
        
        if gesture.state == .began {
            //blocks[gesture.view!.tag].frame.origin.x = 0
            //blocks[gesture.view!.tag].frame.origin.y = 0
        }
        if gesture.state == .changed  {
            
            view.viewWithTag(9)?.removeFromSuperview()
            
            if xPos > xBar && xPos < (xBar + width) {
                print("Entra 1")
                let x = imgBar.frame.origin.x
                let y = imgBar.frame.origin.y - blocks[gesture.view!.tag].frame.size.height
                
                let newBlock = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
                newBlock.backgroundColor = UIColor(red: 116/255, green: 185/255, blue: 255/255, alpha: 0.5)
                newBlock.tag = 9
                
                view.addSubview(newBlock)
            }
            else if xPos > (xBar + width) && xPos < (xBar + width * 2) {
                print("Entra 2")
                let x = imgBar.frame.origin.x + width
                let y = imgBar.frame.origin.y - blocks[gesture.view!.tag].frame.size.height
                
                let newBlock = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
                newBlock.backgroundColor = UIColor(red: 116/255, green: 185/255, blue: 255/255, alpha: 0.5)
                newBlock.tag = 9
                
                view.addSubview(newBlock)
            }
            else if xPos > (xBar + width * 2) && xPos < (xBar + width * 3) {
                print("Entra 3")
                let x = imgBar.frame.origin.x + width * 2
                let y = imgBar.frame.origin.y - blocks[gesture.view!.tag].frame.size.height
                
                let newBlock = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
                newBlock.backgroundColor = UIColor(red: 116/255, green: 185/255, blue: 255/255, alpha: 0.5)
                newBlock.tag = 9
                
                view.addSubview(newBlock)
            }
            else if xPos > (xBar + width * 3) && xPos < (xBar + width * 4) {
                print("Entra 4")
                let x = imgBar.frame.origin.x + width * 3
                let y = imgBar.frame.origin.y - blocks[gesture.view!.tag].frame.size.height
                
                let newBlock = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
                newBlock.backgroundColor = UIColor(red: 116/255, green: 185/255, blue: 255/255, alpha: 0.5)
                newBlock.tag = 9
                
                view.addSubview(newBlock)
            }
            else if xPos > (xBar + width * 4) && xPos < (xBar + width * 5) {
                print("Entra 5")
                let x = imgBar.frame.origin.x + width * 4
                let y = imgBar.frame.origin.y - blocks[gesture.view!.tag].frame.size.height
                
                let newBlock = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
                newBlock.backgroundColor = UIColor(red: 116/255, green: 185/255, blue: 255/255, alpha: 0.5)
                newBlock.tag = 9
                
                view.addSubview(newBlock)
            }
            else if xPos > (xBar + width * 5) && xPos < (xBar + width * 6) {
                print("Entra 6")
                let x = imgBar.frame.origin.x + width * 5
                let y = imgBar.frame.origin.y - blocks[gesture.view!.tag].frame.size.height
                
                let newBlock = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
                newBlock.backgroundColor = UIColor(red: 116/255, green: 185/255, blue: 255/255, alpha: 0.5)
                newBlock.tag = 9
                
                view.addSubview(newBlock)
            }
            else if xPos > (xBar + width * 6) && xPos < (xBar + width * 7) {
                print("Entra 7")
                let x = imgBar.frame.origin.x + width * 6
                let y = imgBar.frame.origin.y - blocks[gesture.view!.tag].frame.size.height
                
                let newBlock = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
                newBlock.backgroundColor = UIColor(red: 116/255, green: 185/255, blue: 255/255, alpha: 0.5)
                newBlock.tag = 9
                
                view.addSubview(newBlock)
            }
            else if xPos > (xBar + width * 7) && xPos < (xBar + width * 8) {
                print("Entra 8")
                let x = imgBar.frame.origin.x + width * 7
                let y = imgBar.frame.origin.y - blocks[gesture.view!.tag].frame.size.height
                
                let newBlock = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
                newBlock.backgroundColor = UIColor(red: 116/255, green: 185/255, blue: 255/255, alpha: 0.5)
                newBlock.tag = 9
                
                view.addSubview(newBlock)
            }
            
        }
        else if gesture.state == .ended {
            if let placeholder = view.viewWithTag(9) {
                placeholder.removeFromSuperview()
            }
            
            if xPos > xBar && xPos < (xBar + width) {
                let x = imgBar.frame.origin.x - (view.frame.size.width / 2 - (width / 2))
                let y = imgBar.frame.origin.y - blocks[gesture.view!.tag].frame.size.height - (view.frame.size.height / 3)
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {self.blocks[gesture.view!.tag].transform = CGAffineTransform(translationX: x, y: y)}, completion: nil)
                
                //self.blocks[gesture.view!.tag].transform = CGAffineTransform(translationX: x, y: y)
                //blocks[gesture.view!.tag].transform = CGAffineTransform(rotationAngle: .pi)
            }
            else if xPos > (xBar + width) && xPos < (xBar + width * 2) {
                let xRelative = view.frame.size.width / 2 - (width / 2)
                let x = imgBar.frame.origin.x - xRelative + width
                let y = imgBar.frame.origin.y - blocks[gesture.view!.tag].frame.size.height - view.frame.size.height / 3
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {self.blocks[gesture.view!.tag].transform = CGAffineTransform(translationX: x, y: y)}, completion: nil)
            }
            else if xPos > (xBar + width * 2) && xPos < (xBar + width * 3) {
                let xRelative = view.frame.size.width / 2 - (width / 2)
                let x = imgBar.frame.origin.x - xRelative + width * 2
                let y = imgBar.frame.origin.y - blocks[gesture.view!.tag].frame.size.height - view.frame.size.height / 3
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {self.blocks[gesture.view!.tag].transform = CGAffineTransform(translationX: x, y: y)}, completion: nil)
            }
            else if xPos > (xBar + width * 3) && xPos < (xBar + width * 4) {
                let xRelative = view.frame.size.width / 2 - (width / 2)
                let x = imgBar.frame.origin.x - xRelative + width * 3
                let y = imgBar.frame.origin.y - blocks[gesture.view!.tag].frame.size.height - view.frame.size.height / 3
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {self.blocks[gesture.view!.tag].transform = CGAffineTransform(translationX: x, y: y)}, completion: nil)
            }
            else if xPos > (xBar + width * 4) && xPos < (xBar + width * 5) {
                let xRelative = view.frame.size.width / 2 - (width / 2)
                let x = imgBar.frame.origin.x - xRelative + width * 4
                let y = imgBar.frame.origin.y - blocks[gesture.view!.tag].frame.size.height - view.frame.size.height / 3
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {self.blocks[gesture.view!.tag].transform = CGAffineTransform(translationX: x, y: y)}, completion: nil)
            }
            else if xPos > (xBar + width * 5) && xPos < (xBar + width * 6) {
                let xRelative = view.frame.size.width / 2 - (width / 2)
                let x = imgBar.frame.origin.x - xRelative + width * 5
                let y = imgBar.frame.origin.y - blocks[gesture.view!.tag].frame.size.height - view.frame.size.height / 3
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {self.blocks[gesture.view!.tag].transform = CGAffineTransform(translationX: x, y: y)}, completion: nil)
            }
            else if xPos > (xBar + width * 6) && xPos < (xBar + width * 7) {
                let xRelative = view.frame.size.width / 2 - (width / 2)
                let x = imgBar.frame.origin.x - xRelative + width * 6
                let y = imgBar.frame.origin.y - blocks[gesture.view!.tag].frame.size.height - view.frame.size.height / 3
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {self.blocks[gesture.view!.tag].transform = CGAffineTransform(translationX: x, y: y)}, completion: nil)
            }
            else if xPos > (xBar + width * 7) && xPos < (xBar + width * 8) {
                let xRelative = view.frame.size.width / 2 - (width / 2)
                let x = imgBar.frame.origin.x - xRelative + width * 7
                let y = imgBar.frame.origin.y - blocks[gesture.view!.tag].frame.size.height - view.frame.size.height / 3
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {self.blocks[gesture.view!.tag].transform = CGAffineTransform(translationX: x, y: y)}, completion: nil)
            }
            else {
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {self.blocks[gesture.view!.tag].transform = .identity}, completion: nil)
            }
        }
    }
    
    func addBlock(block: Block) {
        if blocks.count <= 7 {
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
            newBlock.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(PanGestureHandler)))
            
            let weightLb = UILabel(frame: CGRect(x: 0, y: 0, width: blockWidth, height: blockHeight))
            weightLb.textAlignment = .center
            weightLb.font = UIFont(name: "Questrial", size: 12.0)
            weightLb.text = String(block.weight) + " Kg"
            weightLb.tag = 10
            if !showMass {
                weightLb.isHidden = true
            }
            newBlock.addSubview(weightLb)
            
            blocks.append(newBlock)
            view.addSubview(newBlock)
        }
        else {
            let alert = UIAlertController(title: "¡qAdevertencia!", message: "Solo se pueden colocar máximo 8 objetos.", preferredStyle: .alert)
            let close = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(close)
            present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let itemsView = segue.destination as? ViewControllerItems
        itemsView?.delegate = self
    }
    

}
