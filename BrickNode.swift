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
    var bWeight: Int = 0

    func setup(brickWeight: Int) {
        name = "brick"
        //texture = SKTexture(imageNamed: String(brickWeight))
        bWeight = brickWeight
    }
    
    func addPhysicsBody(withMass: Bool) {
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        if withMass {
            physicsBody?.mass = CGFloat(bWeight)
        }
        else {
            physicsBody?.mass = 0
        }
    }
    
    func removePhysicsBody() {
        physicsBody = nil
    }
}
