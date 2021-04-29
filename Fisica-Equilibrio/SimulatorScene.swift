//
//  SimulatorScene.swift
//  Fisica-Equilibrio
//
//  Created by user189096 on 4/27/21.
//

import SpriteKit

enum CollisionTypes: UInt32 {
    case scale = 1
    case brick = 2
}

class SimulatorScene: SKScene {

    weak var viewController: ViewControllerSimulator?
    var background = SKSpriteNode(imageNamed: "temp-menu-simulator")
    let scale = SKSpriteNode(imageNamed: "bar")
    let scaleBase = SKSpriteNode(imageNamed: "base")
    let floor = SKSpriteNode()
    let brick1 = SKSpriteNode(imageNamed: "5")
    let brick2 = SKSpriteNode(imageNamed: "5")
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.size = CGSize(width: frame.size.width, height: frame.size.height)
        addChild(background)
        
        scale.size.width = frame.size.width * 0.8
        scale.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.4)
        scale.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "bar"), size: scale.size)
        scale.physicsBody?.pinned = true
        scale.physicsBody?.categoryBitMask = CollisionTypes.scale.rawValue
        scale.physicsBody?.contactTestBitMask = CollisionTypes.brick.rawValue
        scaleBase.size = CGSize(width: scale.size.height * 3, height: scale.size.height * 3)
        scaleBase.position = CGPoint(x: size.width / 2, y: scale.position.y - scale.size.height / 2 - scaleBase.size.height / 2)
        scaleBase.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "base"), size: scaleBase.size)
        scaleBase.physicsBody?.isDynamic = false
        addChild(scale)
        addChild(scaleBase)
        
        floor.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: (scaleBase.position.y - scaleBase.size.height / 2)), to: CGPoint(x: frame.size.width, y: (scaleBase.position.y - scaleBase.size.height / 2)))
        floor.physicsBody?.restitution = 0
        addChild(floor)
        
        brick1.position = CGPoint(x: frame.size.width * 0.3, y: frame.size.height * 1)
        brick1.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "5"), size: brick1.size)
        brick1.physicsBody?.categoryBitMask = CollisionTypes.brick.rawValue
        brick1.physicsBody?.collisionBitMask = CollisionTypes.scale.rawValue
        brick1.physicsBody?.contactTestBitMask = CollisionTypes.scale.rawValue
        brick1.physicsBody?.usesPreciseCollisionDetection = true
        addChild(brick1)
        
        brick2.position = CGPoint(x: frame.size.width * 0.7, y: frame.size.height * 1)
        brick2.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "5"), size: brick2.size)
        brick2.physicsBody?.categoryBitMask = CollisionTypes.brick.rawValue
        brick2.physicsBody?.collisionBitMask = CollisionTypes.scale.rawValue
        brick2.physicsBody?.contactTestBitMask = CollisionTypes.scale.rawValue
        brick2.physicsBody?.usesPreciseCollisionDetection = true
        addChild(brick2)
    }
    
}
