//
//  BrickNode.swift
//  Fisica-Equilibrio
//
//  Created by user189096 on 5/13/21.
//

import SpriteKit
import UIKit

class BrickNode: SKSpriteNode {
    
    var brickPosition : Int = -1

    func setup(brickWeight: Int) {
        name = "brick"
        texture = SKTexture(imageNamed: String(brickWeight))
        //physicsBody = SKPhysicsBody(texture: texture!, size: size)
        //physicsBody?.categoryBitMask = CollisionTypes.brick.rawValue
        //physicsBody?.collisionBitMask = CollisionTypes.scale.rawValue
        //physicsBody?.contactTestBitMask = CollisionTypes.scale.rawValue
        //physicsBody?.usesPreciseCollisionDetection = true
        //physicsBody?.isDynamic = false
        //physicsBody?.mass = CGFloat(brickWeight)
    }
}
