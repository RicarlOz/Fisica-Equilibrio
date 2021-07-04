//
//  ViewControllerSimulator.swift
//  
//
//  Created by user190336 on 4/20/21.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class ViewControllerSimulator: UIViewController, AddBrickProtocol, updateTorqueProtocol {
    
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnItems: UIButton!
    @IBOutlet weak var btnExit: UIButton!
    @IBOutlet weak var vTorque: UIView!
    @IBOutlet weak var vTools: UIView!
    @IBOutlet weak var imgLock: UIImageView!
    @IBOutlet weak var btnMass: UIButton!
    @IBOutlet weak var btnForce: UIButton!
    @IBOutlet weak var btnRule: UIButton!
    @IBOutlet weak var btnLevel: UIButton!
    @IBOutlet weak var tvLeft: UITableView!
    @IBOutlet weak var tvRight: UITableView!
    @IBOutlet weak var btnSH: UIButton!
    
    var currentScene: SimulatorScene?
    var player: AVAudioPlayer?
    var sound: Bool!
    var isStarted: Bool = false
    var showMass: Bool = false
    var showForce: Bool = false
    var showRule: Bool = false
    var showLevel: Bool = false
    var torques: [Double] = [0, 0, 0, 0, 0, 0, 0, 0]
    
    var btnSHPos = CGPoint()
    var showTools: Bool = true
    
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
        
        currentScene?.del = self
        
        //view.addBackground(imageName: "temp-menu-simulator")

        btnStart.layer.cornerRadius = 9
        btnStart.layer.borderWidth = 3
        btnStart.layer.borderColor = UIColor.black.cgColor
        btnItems.layer.cornerRadius = 9
        btnItems.layer.borderWidth = 3
        btnItems.layer.borderColor = UIColor.black.cgColor
        btnSH.layer.cornerRadius = 9
        btnExit.layer.cornerRadius = 9
        btnExit.layer.borderWidth = 3
        btnExit.layer.borderColor = UIColor.black.cgColor
        vTorque.layer.cornerRadius = 9
        vTorque.layer.masksToBounds = true
        vTools.layer.cornerRadius = 9
        
        tvLeft.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        tvLeft.separatorInset = UIEdgeInsets.zero
        tvRight.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        tvRight.separatorInset = UIEdgeInsets.zero
        
        btnSHPos = btnSH.layer.position
    }
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .landscape
//    }
//    
//    override var shouldAutorotate: Bool {
//        return false
//    }
    
    @IBAction func closeItems(segue: UIStoryboardSegue) {
        playSound(sound: "button")
    }

    @IBAction func StartSimulation(_ sender: UIButton) {
        
        if isStarted {
            sender.setTitle("Iniciar Simulación", for: .normal)
            btnItems.isHidden = false
            //imgLock.image = UIImage(named: "locked")
            isStarted = false
        }
        else {
            sender.setTitle("Detener Simulación", for: .normal)
            btnItems.isHidden = true
            //imgLock.image = UIImage(named: "unlocked")
            isStarted = true
        }
        playSound(sound: "button")
        currentScene!.isSimulationPlaying = isStarted
        currentScene!.playSimulation()
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
    
    @IBAction func CheckboxForce(_ sender: Any) {
        if showForce {
            btnForce.setImage(UIImage(named: "unchecked"), for: .normal)
            showForce = false
        }
        else {
            btnForce.setImage(UIImage(named: "checked"), for: .normal)
            showForce = true
        }
        playSound(sound: "checkbox")
        currentScene?.showForce(show: showForce)
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
    
    @IBAction func CheckboxLevel(_ sender: Any) {
        if showLevel {
            btnLevel.setImage(UIImage(named: "unchecked"), for: .normal)
            showLevel = false
        }
        else {
            btnLevel.setImage(UIImage(named: "checked"), for: .normal)
            showLevel = true
        }
        playSound(sound: "checkbox")
        currentScene?.showLevel(show: showLevel)
    }
    
    @IBAction func exit(_ sender: UIButton) {
        playSound(sound: "button")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showHideTools(_ sender: UIButton) {
        if showTools {
            showTools = false
            btnSH.setTitle("⟨", for: .normal)
            UIView.animate(withDuration: 0.8, animations: {self.vTools.transform = CGAffineTransform(translationX: self.vTools.frame.width + 20, y: 0)})
            UIView.animate(withDuration: 0.8, animations: {self.btnSH.transform = CGAffineTransform(translationX: self.vTools.frame.width + 20, y: 0)})
        } else {
            showTools = true
            btnSH.setTitle("⟩", for: .normal)
            UIView.animate(withDuration: 0.8, animations: {self.vTools.transform = CGAffineTransform(translationX: 0, y: 0)})
            UIView.animate(withDuration: 0.8, animations: {self.btnSH.transform = CGAffineTransform(translationX: 0, y: 0)})
        }
    }
    
    func addBrick(brickWeight: Int) {
        currentScene!.addBrick(brickWeight: brickWeight, swMass: showMass, swForce: showForce)
    }
    
    func updateTorque(torques: [Double]) {
        playSound(sound: "place")
        self.torques = torques
        tvLeft.reloadData()
        tvRight.reloadData()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        playSound(sound: "button")
        
        let itemsView = segue.destination as? ViewControllerItems
        
        itemsView?.sound = sound
        
        itemsView?.delegate = self
    }
    
    //funcion para reproducir sonido
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

extension ViewControllerSimulator: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if tableView == tvLeft {
            cell = tableView.dequeueReusableCell(withIdentifier: "torqueLeft", for: indexPath)
            
            if indexPath.row == 0 {
                cell.textLabel!.text = "Izquierda:"
            }
            else {
                cell.textLabel!.text = "P" + String(indexPath.row) + ": " + String(torques[indexPath.row - 1])
            }
        }
        if tableView == tvRight {
            cell = tableView.dequeueReusableCell(withIdentifier: "torqueRight", for: indexPath)
            
            if indexPath.row == 0 {
                cell.textLabel!.text = "Derecha:"
            }
            else {
                cell.textLabel!.text = "P" + String(indexPath.row) + ": " + String(torques[8 - indexPath.row])
            }
        }
        
        cell.textLabel!.font = UIFont(name: "Righteous", size: 13)
        cell.separatorInset = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsets.zero
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 18
    }
}
