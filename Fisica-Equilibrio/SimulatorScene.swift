//
//  SimulatorScene.swift
//  Fisica-Equilibrio
//
//  Created by user189096 on 4/27/21.
//

import SpriteKit

class SimulatorScene: SKScene {

    weak var viewController: ViewControllerSimulator?
    var background = SKSpriteNode(imageNamed: "temp-menu-simulator")
    
    let scale = SKSpriteNode(imageNamed: "bar")
    let scaleBase = SKSpriteNode(imageNamed: "base")
    let floor = SKSpriteNode()
    var trash = SKShapeNode(circleOfRadius: 40)
    
    var selectedBrick = BrickNode()
    var brickIsSelected : Bool = false
    var positionBrick : SKShapeNode?
    var xScalePositions = [CGFloat]()
    var brickPosition : Int = 0
    var xBrickPosition : CGFloat = 0
    var bricks : [BrickNode?] = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    var joints : [SKPhysicsJointFixed?] = [nil, nil, nil, nil, nil, nil, nil, nil]
    var occupiedPositions = [false, false, false, false, false, false, false, false]
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.size = CGSize(width: frame.size.width, height: frame.size.height)
        addChild(background)
        
        scale.size.width = frame.size.width * 0.8
        scale.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.4)
        scale.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: scale.size.width, height: scale.size.height))
        scale.physicsBody?.pinned = true
        scale.physicsBody?.mass = 1000
        addChild(scale)
        
        scaleBase.size = CGSize(width: scale.size.height * 3, height: scale.size.height * 3)
        scaleBase.position = CGPoint(x: size.width / 2, y: scale.position.y - scale.size.height / 2 - scaleBase.size.height / 2)
        addChild(scaleBase)
        
        floor.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: (scaleBase.position.y - scaleBase.size.height / 2)), to: CGPoint(x: frame.size.width, y: (scaleBase.position.y - scaleBase.size.height / 2)))
        floor.physicsBody?.restitution = 0
        addChild(floor)
        
        trash.position = CGPoint(x: size.width / 2, y: scale.position.y + scale.size.height * 8)
        trash.fillColor = .white
        trash.fillTexture = SKTexture(imageNamed: "trashClosed")
        trash.isHidden = true
        addChild(trash)
        
        positionBrick = SKShapeNode(rectOf: CGSize(width: scale.size.width / 10 , height: 50))
        positionBrick!.name = "positionBrick"
        positionBrick!.fillColor = UIColor(red: 116/255, green: 185/255, blue: 255/255, alpha: 0.5)
        xScalePositionsSetup()
    }
    
    func xScalePositionsSetup() {
        xScalePositions.append(scale.position.x - (scale.size.width * 7 / 18))
        xScalePositions.append(scale.position.x - (scale.size.width * 5 / 18))
        xScalePositions.append(scale.position.x - (scale.size.width * 3 / 18))
        xScalePositions.append(scale.position.x)
        xScalePositions.append(scale.position.x + (scale.size.width * 3 / 18))
        xScalePositions.append(scale.position.x + (scale.size.width * 5 / 18))
        xScalePositions.append(scale.position.x + (scale.size.width * 7 / 18))
    }
    
    func addBrick(brickWeight: Int, swMass: Bool) {
        let lbWeight = SKLabelNode(fontNamed: "Questrial")
        lbWeight.text = String(brickWeight) + " Kg"
        lbWeight.fontSize = 24
        lbWeight.fontColor = .black
        lbWeight.horizontalAlignmentMode = .center
        lbWeight.verticalAlignmentMode = .center
        lbWeight.name = "lbWeight"
        if !swMass {
            lbWeight.isHidden = true
        }
        
        let brick = BrickNode(imageNamed: String(brickWeight))
        brick.position = scene!.convert(CGPoint(x: size.width / 2, y: scale.position.y + scale.size.height * 8), to: scale)
        brick.size.width = scale.size.width / 10
        brick.setup(brickWeight: brickWeight)
        
        brick.addChild(lbWeight)
        scale.addChild(brick)
        if let foundBrick = bricks[8] {
            foundBrick.removeFromParent()
        }
        bricks[8] = brick
    }
    
    func selectBrick(location: CGPoint) {
        var touchedNode = self.atPoint(location)
        
        if touchedNode is SKLabelNode && touchedNode.parent?.name == "brick" {
            touchedNode = touchedNode.parent!
        }
        
        if touchedNode is SKSpriteNode && touchedNode.name == "brick" {
            if !selectedBrick.isEqual(touchedNode) {
                selectedBrick = touchedNode as! BrickNode
            }
            
            positionBrick!.position = CGPoint(x: scale.size.width, y: scale.size.height)
            scale.addChild(positionBrick!)
            
            selectedBrick.removePhysicsBody()
            brickIsSelected = true
            trash.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        selectBrick(location: location)
        if selectedBrick.brickPosition != -1 {
            occupiedPositions[selectedBrick.brickPosition] = false
            bricks[selectedBrick.brickPosition] = nil
            joints[selectedBrick.brickPosition] = nil
            
            if let foundBrick = bricks[8] {
                foundBrick.removeFromParent()
                bricks[8] = nil
            }
        }
        else {
            bricks[8] = nil
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
                    xBrickPosition = -(4 / 9)
                }
                else if (location.x < xScalePositions[1]) {
                    brickPosition = 1
                    xBrickPosition = -(3 / 9)
                }
                else if (location.x < xScalePositions[2]) {
                    brickPosition = 2
                    xBrickPosition = -(2 / 9)
                }
                else if (location.x < xScalePositions[3]) {
                    brickPosition = 3
                    xBrickPosition = -(1 / 9)
                }
                else if (location.x < xScalePositions[4]) {
                    brickPosition = 4
                    xBrickPosition = (1 / 9)
                }
                else if (location.x < xScalePositions[5]) {
                    brickPosition = 5
                    xBrickPosition = (2 / 9)
                }
                else if (location.x < xScalePositions[6]) {
                    brickPosition = 6
                    xBrickPosition = (3 / 9)
                }
                else {
                    brickPosition = 7
                    xBrickPosition = (4 / 9)
                }
                
                if location.x > trash.position.x - 40 && location.x < trash.position.x + 40 && location.y > trash.position.y - 40 && location.y < trash.position.y + 40 {
                    trash.fillTexture = SKTexture(imageNamed: "trashOpen")
                    positionBrick!.isHidden = true
                }
                else {
                    trash.fillTexture = SKTexture(imageNamed: "trashClosed")
                    positionBrick!.isHidden = false
                }
                
                positionBrick!.position.x = scale.size.width * xBrickPosition
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if brickIsSelected {
            positionBrick!.removeFromParent()
            
            if location.x > trash.position.x - 40 && location.x < trash.position.x + 40 && location.y > trash.position.y - 40 && location.y < trash.position.y + 40 {
                selectedBrick.removeFromParent()
            }
            else if !occupiedPositions[brickPosition] {
                occupiedPositions[brickPosition] = true
                selectedBrick.brickPosition = brickPosition
                //selectedBrick.run(SKAction.move(to: CGPoint(x: scale.size.width * xBrickPosition, y: (scale.size.height / 2) + (selectedBrick.size.height / 2)), duration: 0.15))
                selectedBrick.position = CGPoint(x: scale.size.width * xBrickPosition, y: (scale.size.height / 2) + (selectedBrick.size.height / 2))
                selectedBrick.addPhysicsBody()
                bricks[brickPosition] = selectedBrick
                
                let fixedJoint = SKPhysicsJointFixed.joint(withBodyA: selectedBrick.physicsBody!, bodyB: scale.physicsBody!, anchor: CGPoint(x: scale.size.width * xBrickPosition, y: (scale.size.height / 2) + (selectedBrick.size.height / 2)))
                scene!.physicsWorld.add(fixedJoint)
                joints[brickPosition] = fixedJoint
            }
            else {
                selectedBrick.removeFromParent()
            }
            
            brickIsSelected = false
            trash.isHidden = true
            print(bricks)
            print(joints)
        }
    }
    
    func showMass(show: Bool) {
        if show {
            for brick in bricks {
                if let foundBrick = brick {
                    foundBrick.childNode(withName: "lbWeight")?.isHidden = false
                }
            }
        }
        else {
            for brick in bricks {
                if let foundBrick = brick {
                    foundBrick.childNode(withName: "lbWeight")?.isHidden = true
                }
            }
        }
    }
}
