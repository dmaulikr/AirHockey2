//
//  onePlayer.swift
//  AirHockey2
//
//  Created by student1 on 5/5/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import SpriteKit
import GameplayKit

class onePlayer: SKScene, SKPhysicsContactDelegate {
    
    var rightPaddle = SKSpriteNode()
    var leftPaddle = SKSpriteNode()
    var puck = SKSpriteNode()
    var rightGoal = SKSpriteNode()
    var leftGoal = SKSpriteNode()
    var leftScore = SKLabelNode()
    var rightScore = SKLabelNode()
    var leftScoreCounter = 0
    var rightScoreCounter = 0
    var winnerLabel = SKLabelNode()
    
    override func didMove(to view: SKView)
    {
        rightPaddle = self.childNode(withName: "rightPaddle") as! SKSpriteNode
        leftPaddle = self.childNode(withName: "leftPaddle") as! SKSpriteNode
        puck = self.childNode(withName: "puck") as! SKSpriteNode
        rightGoal = self.childNode(withName: "rightGoal") as! SKSpriteNode
        leftGoal = self.childNode(withName: "leftGoal") as! SKSpriteNode
        leftScore = self.childNode(withName: "leftScore") as! SKLabelNode
        rightScore = self.childNode(withName: "rightScore") as! SKLabelNode
        winnerLabel = self.childNode(withName: "winnerLabel") as! SKLabelNode
        
        physicsWorld.contactDelegate = self
        
        let bottomLeft = CGPoint(x: frame.origin.x + 25, y: frame.origin.y)
        let bottomRight = CGPoint(x: -frame.origin.x - 25, y: frame.origin.y)
        let topLeft = CGPoint(x: frame.origin.x, y: 284)
        let topRight = CGPoint(x: -frame.origin.x, y: 284)
        
        let bottom = SKSpriteNode()
        bottom.name = "bottom"
        bottom.physicsBody = SKPhysicsBody(edgeFrom: bottomLeft, to: bottomRight)
        
        let left = SKSpriteNode()
        left.name = "left"
        left.physicsBody = SKPhysicsBody(edgeFrom: bottomLeft, to: topLeft)
        
        let top = SKSpriteNode()
        top.name = "top"
        top.physicsBody = SKPhysicsBody(edgeFrom: topLeft, to: topRight)
        
        let right = SKSpriteNode()
        right.name = "right"
        right.physicsBody = SKPhysicsBody(edgeFrom: topRight, to: bottomRight)
        
        addChild(bottom)
        addChild(left)
        addChild(top)
        addChild(right)
        
        leftPaddle.physicsBody?.categoryBitMask = paddleCategory
        rightPaddle.physicsBody?.categoryBitMask = paddleCategory
        puck.physicsBody?.categoryBitMask = puckCategory
        leftGoal.physicsBody?.categoryBitMask = leftGoalCategory
        rightGoal.physicsBody?.categoryBitMask = rightGoalCategory
        
        puck.physicsBody?.contactTestBitMask = paddleCategory | leftGoalCategory | rightGoalCategory
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let location = touch.location(in: self)
            if location.x < 0 && location.y < 249 && location.x > frame.origin.x + 25
            {
                leftPaddle.run(SKAction.move(to: location, duration: 0.1))
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let location = touch.location(in: self)
            if location.x < 0 && location.y < 249 && location.x > frame.origin.x + 25
            {
                leftPaddle.run(SKAction.move(to: location, duration: 0.1))
            }
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == paddleCategory
        {
            let currentPaddle = contact.bodyA.node?.name!
            
            if currentPaddle == "rightPaddle"
            {
                print("right")
                puck.physicsBody?.applyImpulse(CGVector(dx: 1.3 * (puck.position.x - rightPaddle.position.x)  , dy: 1.3 * (puck.position.y - rightPaddle.position.y)))
            }
            
            if currentPaddle == "leftPaddle"
            {
                print("left")
                puck.physicsBody?.applyImpulse(CGVector(dx: 1.3 * (puck.position.x - leftPaddle.position.x)  , dy: 1.3 * (puck.position.y - leftPaddle.position.y)))
            }
        }
        
        if contact.bodyA.categoryBitMask == rightGoalCategory {
            leftScoreCounter += 1
            leftScore.text = "\(leftScoreCounter)"
            puck.run(SKAction.move(to: CGPoint(x: 150, y: -50), duration: 0.0))
        }
            
        else if contact.bodyA.categoryBitMask == leftGoalCategory {
            rightScoreCounter += 1
            rightScore.text = "\(rightScoreCounter)"
            puck.run(SKAction.move(to: CGPoint(x: -150, y: -50), duration: 0.0))
        }
    }
    
    func reset() {
        let delayInSeconds = 4.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.winnerLabel.text = "Ready!"
            self.leftScore.text = "0"
            self.rightScore.text = "0"
            self.leftScoreCounter = 0
            self.rightScoreCounter = 0
            self.puck.run(SKAction.move(to: CGPoint(x: 0, y: -50), duration: 0))
            self.rightPaddle.run(SKAction.move(to: CGPoint(x: 410, y: -50), duration: 0))
            self.leftPaddle.run(SKAction.move(to: CGPoint(x: -410, y: -50), duration: 0))
            self.counter = 1
            self.timerCounter = 120
        }
    }
    var counter = 1
    var timerCounter = 120
    override func update(_ currentTime: TimeInterval) {
        counter += 1
        if counter < 42 {
            leftPaddle.position = CGPoint(x: -410, y: -50)
            rightPaddle.position = CGPoint(x: 410, y: -50)
            puck.position = CGPoint(x: 0, y: -50)
        }
        if puck.position.x < 0
        {
            rightPaddle.run(SKAction.move(to: CGPoint(x: 410, y: puck.position.y), duration: 0.2))
        }
            
        else if puck.position.x > 0
        {
            rightPaddle.run(SKAction.move(to: CGPoint(x: puck.position.x, y: puck.position.y), duration: 0.2))
        }
        
        if counter % 14 == 0 && timerCounter != 0
        {
            if counter == 14 {
                winnerLabel.text = "Ready!"
            }
            else if counter == 28 {
                winnerLabel.text = "Set!"
            }
            else if counter == 42 {
                winnerLabel.text = "GO!"
            }
            else {
                timerCounter -= 1
                winnerLabel.text = "\(timerCounter)"
            }
        }
        else if timerCounter == 0
        {
            if rightScoreCounter > leftScoreCounter
            {
                winnerLabel.text = "CPU Wins!"
                reset()
            }
            else if leftScoreCounter > rightScoreCounter
            {
                winnerLabel.text = "Player 1 Wins!"
                reset()
            }
            else {
                reset()
            }
        }
    }
}
