//
//  SimulatorScene.swift
//  Fisica-Equilibrio
//
//  Created by user189096 on 4/27/21.
//

import SpriteKit

class SimulatorScene: SKScene {

    weak var viewController: ViewControllerSimulator?
    let scale = SKSpriteNode(imageNamed: "bar")
    let scaleBase = SKSpriteNode(imageNamed: "base")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.blue
        scale.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
        scaleBase.size = CGSize(width: scale.size.width * 0.2, height: scale.size.width * 0.2)
        scaleBase.position = CGPoint(x: size.width / 2, y: scale.position.y - scale.size.height / 2 - scaleBase.size.height / 2)
        addChild(scale)
        addChild(scaleBase)
    }
    
}
