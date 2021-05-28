//
//  SimulatorScene.swift
//  Fisica-Equilibrio
//
//  Created by user189096 on 4/27/21.
//

import SpriteKit

class QuizScene: SKScene {

    weak var viewController: ViewControllerQuiz?
    var background = SKSpriteNode(imageNamed: "temp-menu-quizzes")
    
    let scale = SKSpriteNode(imageNamed: "bar")
    let scaleBase = SKSpriteNode(imageNamed: "base")
    var isSimulationPlaying = false
    let lock = SKSpriteNode(imageNamed: "locked")
    let ruler = SKSpriteNode(imageNamed: "ruler")
    let levelLeft = SKSpriteNode(imageNamed: "bar-lvl")
    let levelRight = SKSpriteNode(imageNamed: "bar-lvl")
    var scaleWeight = 0
    let floor = SKSpriteNode()
    let forceLookAt = SKSpriteNode()
    
    var selectedBrick = BrickNode()
    var brickIsSelected : Bool = false
    var positionBrick : SKShapeNode?
    var xScalePositions = [CGFloat]()
    var xBrickPositions = [CGFloat]()
    var brickPosition : Int = 0
    var bricks : [BrickNode?] = [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
    var joints : [SKPhysicsJointFixed?] = [nil, nil, nil, nil, nil, nil, nil, nil]
    var occupiedPositions = [false, false, false, false, false, false, false, false]
    var torques: [Double] = [0, 0, 0, 0, 0, 0, 0, 0]
    var resultHints = [SKSpriteNode]()
    
    var del: updateTorqueProtocol!
    
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
        
        levelLeft.size.height = scale.size.height * 2
        levelLeft.size.width = levelLeft.size.height
        levelLeft.position = CGPoint(x: scale.position.x - (levelLeft.size.width / 2 + scale.size.width / 2), y: scale.position.y)
        levelLeft.isHidden = true
        addChild(levelLeft)
        
        levelRight.xScale = levelRight.xScale * -1
        levelRight.size.height = scale.size.height * 2
        levelRight.size.width = levelRight.size.height
        levelRight.position = CGPoint(x: scale.position.x + (levelRight.size.width / 2 + scale.size.width / 2), y: scale.position.y)
        levelRight.isHidden = true
        addChild(levelRight)
        
        scaleBase.size = CGSize(width: scale.size.height * 3, height: scale.size.height * 3)
        scaleBase.position = CGPoint(x: size.width / 2, y: scale.position.y - scale.size.height / 2 - scaleBase.size.height / 2)
        addChild(scaleBase)
        
        lock.size = CGSize(width: scaleBase.size.width * 0.5, height: scaleBase.size.height * 0.5)
        lock.position = CGPoint(x: 0, y: -scaleBase.size.height * 0.1)
        scaleBase.addChild(lock)
        
        ruler.size.width = frame.size.width * 0.8 + (scale.size.width / 10 / 10 * 2)
        ruler.position = CGPoint(x: 0, y: -scale.size.height)
        ruler.isHidden = true
        ruler.physicsBody?.pinned = true
        scale.addChild(ruler)
        
        floor.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: (scaleBase.position.y - scaleBase.size.height / 2)), to: CGPoint(x: frame.size.width, y: (scaleBase.position.y - scaleBase.size.height / 2)))
        floor.physicsBody?.restitution = 0
        addChild(floor)
        
        forceLookAt.position = CGPoint(x: size.width / 2, y: -10000)
        addChild(forceLookAt)
        
        positionBrick = SKShapeNode(rectOf: CGSize(width: scale.size.width / 10 , height: 50))
        positionBrick!.name = "positionBrick"
        positionBrick!.fillColor = UIColor(red: 116/255, green: 185/255, blue: 255/255, alpha: 0.5)
        positionsSetup()
    }
    
    func positionsSetup() {
        // Define positions where mouse hover defines a position of the scale
        xScalePositions.append(scale.position.x - (scale.size.width * 7 / 18))
        xScalePositions.append(scale.position.x - (scale.size.width * 5 / 18))
        xScalePositions.append(scale.position.x - (scale.size.width * 3 / 18))
        xScalePositions.append(scale.position.x)
        xScalePositions.append(scale.position.x + (scale.size.width * 3 / 18))
        xScalePositions.append(scale.position.x + (scale.size.width * 5 / 18))
        xScalePositions.append(scale.position.x + (scale.size.width * 7 / 18))
        
        // Define positions where bricks will be positioned in scale
        xBrickPositions.append(-4 / 9)
        xBrickPositions.append(-3 / 9)
        xBrickPositions.append(-2 / 9)
        xBrickPositions.append(-1 / 9)
        xBrickPositions.append(1 / 9)
        xBrickPositions.append(2 / 9)
        xBrickPositions.append(3 / 9)
        xBrickPositions.append(4 / 9)
    }
    
    func playSimulation() {
        if scaleWeight == 0 {
            levelLeft.run(SKAction.fadeAlpha(to: 1, duration: 0.5))
            levelRight.run(SKAction.fadeAlpha(to: 1, duration: 0.5))
        }
        else {
            levelLeft.run(SKAction.fadeAlpha(to: 0.3, duration: 0.5))
            levelRight.run(SKAction.fadeAlpha(to: 0.3, duration: 0.5))
        }

        if isSimulationPlaying {
            lock.texture = SKTexture(imageNamed: "unlocked")
            
            // Add mass to all bricks
            for number in 0...7 {
                if let brickFound = bricks[number] {
                    brickFound.removePhysicsBody()
                    brickFound.addPhysicsBody(withMass: true)

                    scene!.physicsWorld.remove(joints[brickFound.brickPosition]!)
                    let fixedJoint = SKPhysicsJointFixed.joint(withBodyA: brickFound.physicsBody!, bodyB: scale.physicsBody!, anchor: CGPoint(x: scale.size.width * xBrickPositions[brickFound.brickPosition], y: (scale.size.height / 2) + (brickFound.size.height / 2)))
                    scene!.physicsWorld.add(fixedJoint)
                    joints[brickFound.brickPosition] = fixedJoint
                }
            }
        }
        else {
            levelLeft.run(SKAction.fadeAlpha(to: 1, duration: 0.5))
            levelRight.run(SKAction.fadeAlpha(to: 1, duration: 0.5))
            
            lock.texture = SKTexture(imageNamed: "locked")
            
            // Remove mass from all bricks, then straighten scale
            for number in 0...7 {
                if let brickFound = bricks[number] {
                    brickFound.removePhysicsBody()
                    brickFound.addPhysicsBody(withMass: false)
                    
                    scene!.physicsWorld.remove(joints[brickFound.brickPosition]!)
                    let fixedJoint = SKPhysicsJointFixed.joint(withBodyA: brickFound.physicsBody!, bodyB: scale.physicsBody!, anchor: CGPoint(x: scale.size.width * xBrickPositions[brickFound.brickPosition], y: (scale.size.height / 2) + (brickFound.size.height / 2)))
                    scene!.physicsWorld.add(fixedJoint)
                    joints[brickFound.brickPosition] = fixedJoint
                }
            }
            straightenScale()
        }
    }
    
    func addBrick(brickWeight: Int, posX: Int, swMass: Bool, swForce: Bool) {
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
        brick.position = scene!.convert(CGPoint(x: (size.width / 2) + (brick.size.width * CGFloat(posX)), y: scale.position.y + scale.size.height * 8), to: scale)
        brick.size.width = scale.size.width / 10
        brick.setup(brickWeight: brickWeight)
        
        let blockForce = SKSpriteNode(imageNamed: "force-vector")
        blockForce.size.width = brick.size.width / 2
        blockForce.size.height = 25 + CGFloat(brick.bWeight) * 2
        
        blockForce.position = CGPoint(x: brick.size.width / 2 - blockForce.size.width, y: -(brick.size.height / 2 + blockForce.size.height / 2))
        let lookAt = SKConstraint.orient(to: forceLookAt, offset: SKRange(constantValue: -CGFloat.pi / 2))
        let lookAtLimit = SKConstraint.zRotation(SKRange(lowerLimit: -CGFloat.pi, upperLimit: CGFloat.pi))
        blockForce.constraints = [lookAt, lookAtLimit]
        blockForce.physicsBody?.mass = 0
        blockForce.name = "force"
        if !swForce {
            blockForce.isHidden = true
        }
        
        brick.addChild(lbWeight)
        brick.addChild(blockForce)
        scale.addChild(brick)
        
        // If a brick was already floating in the screen, remove it and replace with new one
        let fBrick1 = bricks[8]
        let fBrick2 = bricks[9]
        let fBrick3 = bricks[10]
        let fBrick4 = bricks[11]
        
        if fBrick1 == nil || fBrick2 == nil || fBrick3 == nil || fBrick4 == nil {
            if fBrick1 == nil {
                bricks[8] = brick
            }
            else if fBrick2 == nil {
                bricks[9] = brick
            }
            else if fBrick3 == nil {
                bricks[10] = brick
            }
            else {
                bricks[11] = brick
            }
        }
        else {
            fBrick1?.removeFromParent()
            bricks[8] = brick
        }
    }
    
    func selectBrick(location: CGPoint) {
        var touchedNode = self.atPoint(location)
        
        if touchedNode.parent?.name == "brick" {
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
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isSimulationPlaying {
            return
        }
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        selectBrick(location: location)
        if brickIsSelected {
            if selectedBrick.brickPosition != -1 {
                occupiedPositions[selectedBrick.brickPosition] = false
                bricks[selectedBrick.brickPosition] = nil
                joints[selectedBrick.brickPosition] = nil
            }
            else {
                for i in 8..<12 {
                    if selectedBrick.position == bricks[i]?.position {
                        bricks[i] = nil
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !brickIsSelected {
            return
        }
        
        for touch in touches {
            let location = touch.location(in: self)
            selectedBrick.position.x = location.x - scale.position.x
            selectedBrick.position.y = location.y - scale.position.y
            
            if (location.x < xScalePositions[0]) {
                brickPosition = 0
            }
            else if (location.x < xScalePositions[1]) {
                brickPosition = 1
            }
            else if (location.x < xScalePositions[2]) {
                brickPosition = 2
            }
            else if (location.x < xScalePositions[3]) {
                brickPosition = 3
            }
            else if (location.x < xScalePositions[4]) {
                brickPosition = 4
            }
            else if (location.x < xScalePositions[5]) {
                brickPosition = 5
            }
            else if (location.x < xScalePositions[6]) {
                brickPosition = 6
            }
            else {
                brickPosition = 7
            }
            
            positionBrick!.position.x = scale.size.width * xBrickPositions[brickPosition]
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !brickIsSelected {
            return
        }
        
        positionBrick!.removeFromParent()
            
        if !occupiedPositions[brickPosition] {
            if selectedBrick.brickPosition != -1 {
                torques[selectedBrick.brickPosition] = 0
                del.updateTorque(torques: torques)
            }
            
            occupiedPositions[brickPosition] = true
            selectedBrick.brickPosition = brickPosition
            selectedBrick.position = CGPoint(x: scale.size.width * xBrickPositions[brickPosition], y: (scale.size.height / 2) + (selectedBrick.size.height / 2))
            selectedBrick.addPhysicsBody(withMass: false)
            bricks[brickPosition] = selectedBrick
            
            let fixedJoint = SKPhysicsJointFixed.joint(withBodyA: selectedBrick.physicsBody!, bodyB: scale.physicsBody!, anchor: CGPoint(x: scale.size.width * xBrickPositions[brickPosition], y: (scale.size.height / 2) + (selectedBrick.size.height / 2)))
            scene!.physicsWorld.add(fixedJoint)
            joints[brickPosition] = fixedJoint
            
            // Update torque
            if selectedBrick.brickPosition == 0 || selectedBrick.brickPosition == 7 {
                torques[selectedBrick.brickPosition] = Double(selectedBrick.bWeight)
                del.updateTorque(torques: torques)
            }
            else if selectedBrick.brickPosition == 1 || selectedBrick.brickPosition == 6 {
                torques[selectedBrick.brickPosition] = Double(selectedBrick.bWeight) * 0.75
                del.updateTorque(torques: torques)
            }
            else if selectedBrick.brickPosition == 2 || selectedBrick.brickPosition == 5 {
                torques[selectedBrick.brickPosition] = Double(selectedBrick.bWeight) * 0.5
                del.updateTorque(torques: torques)
            }
            else {
                torques[selectedBrick.brickPosition] = Double(selectedBrick.bWeight) * 0.25
                del.updateTorque(torques: torques)
            }
        }
        // Return brick to its original position if position was occupied
        else {
            if selectedBrick.brickPosition == -1 {
                selectedBrick.removeFromParent()
            }
            else {
                occupiedPositions[selectedBrick.brickPosition] = true
                selectedBrick.position = CGPoint(x: scale.size.width * xBrickPositions[selectedBrick.brickPosition], y: (scale.size.height / 2) + (selectedBrick.size.height / 2))
                selectedBrick.addPhysicsBody(withMass: false)
                bricks[selectedBrick.brickPosition] = selectedBrick
                
                let fixedJoint = SKPhysicsJointFixed.joint(withBodyA: selectedBrick.physicsBody!, bodyB: scale.physicsBody!, anchor: CGPoint(x: scale.size.width * xBrickPositions[selectedBrick.brickPosition], y: (scale.size.height / 2) + (selectedBrick.size.height / 2)))
                scene!.physicsWorld.add(fixedJoint)
                joints[selectedBrick.brickPosition] = fixedJoint
            }
        }
        
        brickIsSelected = false
        
        scaleWeight = 0
        for number in 0...7 {
            if let brickFound = bricks[number] {
                if number < 4 {
                    scaleWeight += brickFound.bWeight * (number - 4) / 4
                }
                else {
                    scaleWeight += brickFound.bWeight * (number - 3) / 4
                }
            }
        }
    }
    
    func showMass(show: Bool) {
        //print("---")
        for brick in bricks {
            //print(brick)
            brick?.childNode(withName: "lbWeight")?.isHidden = !show
        }
    }
    
    func showRuler(show: Bool) {
        ruler.isHidden = !show
    }
    
    func straightenScale() {
        let rotation = SKAction.rotate(toAngle: 0, duration: 2)
        scale.run(rotation)
    }
    
    func checkQuiz() -> Bool {
        if bricks[8] == nil && bricks[9] == nil  && bricks[10] == nil  && bricks[11] == nil {
            var totalTorque = 0.0
            for num in 0..<8 {
                totalTorque += (num > 3 ? torques[num] : -torques[num])
            }
                
//            print("total = \(totalTorque)")
//            print("return = \(totalTorque == 0)")
                
            return totalTorque == 0
        }
        else {
            return false
        }
    }
    
    func getHint(weights: [Int], index: [Int]) {
        var phi: SKSpriteNode
        
        for i in 0..<weights.count {
            var height = 50
            if weights[i] >= 65 {
                height *= 3
            }
            else if weights[i] >= 35 && weights[i] <= 60 {
                height *= 2
            }
            
            phi = SKSpriteNode(imageNamed: String(weights[i]))//(rectOf: CGSize(width: Int(scale.size.width) / 10 , height: height))
            phi.name = "HintPlaceholder"
            phi.alpha = 0.5
            if weights[i] >= 95 {
                phi.position = CGPoint(x: scale.size.width, y: scale.size.height+75)
            }
            else if weights[i] >= 65 && weights[i] <= 90 {
                phi.position = CGPoint(x: scale.size.width, y: scale.size.height+55)
            }
            else if weights[i] >= 35 && weights[i] <= 60 {
                phi.position = CGPoint(x: scale.size.width, y: scale.size.height+30)
            }
            else {
                phi.position = CGPoint(x: scale.size.width, y: scale.size.height+5)
            }
            
            scale.addChild(phi)
            phi.size.width = scale.size.width / 10
            phi.position.x = scale.size.width * xBrickPositions[index[i]]
            
            resultHints.append(phi)
            
//            pausa intermitente
            blinkHints()
            perform(#selector(removeHints), with: nil, afterDelay: 3)
        }
    }
    
    func blinkHints(){
        let hide = SKAction.fadeAlpha(to: 0, duration: 1)
        let unhide = SKAction.fadeAlpha(to: 0.5, duration: 1)

        // Wait for 2 seconds before repeating the action
        let wait = SKAction.wait(forDuration: 0.5)

        // Form a sequence with the scale actions, as well as the wait action
        let hideActionSequence = SKAction.sequence([unhide, wait, hide])

        // Run the action
        for i in resultHints {
            i.run(hideActionSequence)
        }
    }
    
    @objc func removeHints(){
        for i in resultHints {
            i.removeFromParent()
        }
        resultHints.removeAll()
    }
}
