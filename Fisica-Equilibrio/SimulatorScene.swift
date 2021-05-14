//
//  SimulatorScene.swift
//  Fisica-Equilibrio
//
//  Created by user189096 on 4/27/21.
//

import SpriteKit

/*enum CollisionTypes: UInt32 {
    case scale = 1
    case brick = 2
}*/

class SimulatorScene: SKScene {

    weak var viewController: ViewControllerSimulator?
    var background = SKSpriteNode(imageNamed: "temp-menu-simulator")
    let scale = SKSpriteNode(imageNamed: "bar")
    let scaleBase = SKSpriteNode(imageNamed: "base")
    let floor = SKSpriteNode()
    var bricks = [BrickNode]()
    var selectedBrick = BrickNode()
    
    let positionBrick = SKShapeNode(rectOf: CGSize(width: 120, height: 50))
    var xScalePositions = [CGFloat]()
    var brickPosition : Int = 0
    var xBrickPosition : CGFloat = 0
    var occupiedPositions = [false, false, false, false, false, false, false, false]
    var brickIsSelected : Bool = false
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.size = CGSize(width: frame.size.width, height: frame.size.height)
        addChild(background)
        
        scale.size.width = frame.size.width * 0.8
        scale.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.4)
        scale.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "bar"), size: scale.size)
        scale.physicsBody?.pinned = true
        //scale.physicsBody?.categoryBitMask = CollisionTypes.scale.rawValue
        //scale.physicsBody?.contactTestBitMask = CollisionTypes.brick.rawValue
        scaleBase.size = CGSize(width: scale.size.height * 3, height: scale.size.height * 3)
        scaleBase.position = CGPoint(x: size.width / 2, y: scale.position.y - scale.size.height / 2 - scaleBase.size.height / 2)
        scaleBase.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "base"), size: scaleBase.size)
        scaleBase.physicsBody?.isDynamic = false
        addChild(scale)
        addChild(scaleBase)
        
        floor.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: (scaleBase.position.y - scaleBase.size.height / 2)), to: CGPoint(x: frame.size.width, y: (scaleBase.position.y - scaleBase.size.height / 2)))
        floor.physicsBody?.restitution = 0
        addChild(floor)
        
        positionBrick.name = "positionBrick"
        positionBrick.fillColor = UIColor(red: 116/255, green: 185/255, blue: 255/255, alpha: 0.5)
        xScalePositionsSetup()
    }
    
    func xScalePositionsSetup() {
        xScalePositions.append(scale.position.x - (scale.size.width * 0.375))
        xScalePositions.append(scale.position.x - (scale.size.width * 0.25))
        xScalePositions.append(scale.position.x - (scale.size.width * 0.125))
        xScalePositions.append(scale.position.x)
        xScalePositions.append(scale.position.x + (scale.size.width * 0.125))
        xScalePositions.append(scale.position.x + (scale.size.width * 0.25))
        xScalePositions.append(scale.position.x + (scale.size.width * 0.375))
    }
    
    func addBrick(brickWeight: Int) {
        let brick = BrickNode(imageNamed: String(brickWeight))
        brick.position = CGPoint(x: 0, y: scale.size.height * 8)
        brick.setup(brickWeight: brickWeight)
        scale.addChild(brick)
        bricks.append(brick)
    }
    
    func selectBrick(location: CGPoint) {
        let touchedNode = self.atPoint(location)
        
        if touchedNode is SKSpriteNode && touchedNode.name == "brick" {
            if !selectedBrick.isEqual(touchedNode) {
                selectedBrick = touchedNode as! BrickNode
            }
            
            positionBrick.position = CGPoint(x: scale.size.width, y: scale.size.height)
            scale.addChild(positionBrick)
            
            brickIsSelected = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        selectBrick(location: location)
        if selectedBrick.brickPosition != -1 {
            occupiedPositions[selectedBrick.brickPosition] = false
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if brickIsSelected {
            for touch in touches {
                let location = touch.location(in: self)
                selectedBrick.position.x = location.x - scale.position.x
                selectedBrick.position.y = location.y - scale.position.y
                
                if (location.x < xScalePositions[0]) {
                    brickPosition = 0
                    xBrickPosition = -0.4375
                }
                else if (location.x < xScalePositions[1]) {
                    brickPosition = 1
                    xBrickPosition = -0.3125
                }
                else if (location.x < xScalePositions[2]) {
                    brickPosition = 2
                    xBrickPosition = -0.1875
                }
                else if (location.x < xScalePositions[3]) {
                    brickPosition = 3
                    xBrickPosition = -0.0625
                }
                else if (location.x < xScalePositions[4]) {
                    brickPosition = 4
                    xBrickPosition = 0.0625
                }
                else if (location.x < xScalePositions[5]) {
                    brickPosition = 5
                    xBrickPosition = 0.1875
                }
                else if (location.x < xScalePositions[6]) {
                    brickPosition = 6
                    xBrickPosition = 0.3125
                }
                else {
                    brickPosition = 7
                    xBrickPosition = 0.4375
                }
                positionBrick.position.x = scale.size.width * xBrickPosition
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if brickIsSelected {
            positionBrick.removeFromParent()
            
            if !occupiedPositions[brickPosition] {
                occupiedPositions[brickPosition] = true
                selectedBrick.brickPosition = brickPosition
                selectedBrick.run(SKAction.move(to: CGPoint(x: scale.size.width * xBrickPosition, y: (scale.size.height / 2) + (selectedBrick.size.height / 2)), duration: 0.15))
            }
            else {
                selectedBrick.removeFromParent()
            }
            
            brickIsSelected = false
        }
    }
    
}
