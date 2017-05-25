//
//  GameScene.swift
//  AirHockey2
//
//  Created by student3 on 5/4/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit
import AVFoundation

let puckCategory: UInt32 = 0x1 << 0
let bottomCategory: UInt32 = 0x1 << 1
let topCategory: UInt32 = 0x1 << 2
let leftCategory: UInt32 = 0x1 << 3
let rightCategory: UInt32 = 0x1 << 4
let paddleCategory: UInt32 = 0x1 << 5
let leftGoalCategory: UInt32 = 0x1 << 6
let rightGoalCategory: UInt32 = 0x1 << 7

class GameScene: SKScene, SKPhysicsContactDelegate {
    
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
    var didEnd = false
    var playAgainNode = SKSpriteNode()
    var backToMainNode = SKSpriteNode()
    var resetNode = SKSpriteNode()
    var backToMainOnBarNode = SKSpriteNode()
    
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
        playAgainNode = self.childNode(withName: "playAgain") as! SKSpriteNode
        backToMainNode = self.childNode(withName: "backToMenu") as! SKSpriteNode
        backToMainOnBarNode = self.childNode(withName: "backToMainOnBar") as! SKSpriteNode
        resetNode = self.childNode(withName: "reset") as! SKSpriteNode
        
        playAgainNode.alpha = 0
        backToMainNode.alpha = 0
        
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
        if counter > 168 {
        for touch in touches
        {
            let location = touch.location(in: self)
            if resetNode.contains(location) && backToMainOnBarNode.alpha == 1 {
                reset()
            }
            else if backToMainOnBarNode.contains(location) && backToMainOnBarNode.alpha == 1 {
                var viewControllerForSegue = self.view?.window?.rootViewController
                viewControllerForSegue?.dismiss(animated: true, completion: nil)
            }
            else if backToMainNode.contains(location) && backToMainNode.alpha == 1 {
                var viewControllerForSegue = self.view?.window?.rootViewController
                viewControllerForSegue?.dismiss(animated: true, completion: nil)
            }
            else if playAgainNode.contains(location) && playAgainNode.alpha == 1 {
                reset()
            }
            else if location.x > 0 && location.y < 249 && location.x < -frame.origin.x - 25
            {
                rightPaddle.run(SKAction.move(to: location, duration: 0.1))
            }
            
            else if location.x < 0 && location.y < 249 && location.x > frame.origin.x + 25
            {
                leftPaddle.run(SKAction.move(to: location, duration: 0.1))
            }
        }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if counter > 168 {
        for touch in touches
        {
            let location = touch.location(in: self)
            if resetNode.contains(location) && backToMainOnBarNode.alpha == 1 {
                reset()
            }
            else if backToMainOnBarNode.contains(location) && backToMainOnBarNode.alpha == 1 {
                var viewControllerForSegue = self.view?.window?.rootViewController
                viewControllerForSegue?.dismiss(animated: true, completion: nil)
            }
            else if backToMainNode.contains(location) && backToMainNode.alpha == 1 {
                var viewControllerForSegue = self.view?.window?.rootViewController
                viewControllerForSegue?.dismiss(animated: true, completion: nil)
            }
            else if playAgainNode.contains(location) && playAgainNode.alpha == 1 {
                reset()
            }
            else if location.x > 0 && location.y < 249
            {
                rightPaddle.run(SKAction.move(to: location, duration: 0.05))
            }
            
            else if location.x < 0 && location.y < 249
            {
                leftPaddle.run(SKAction.move(to: location, duration: 0.05))
            }
        }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == paddleCategory
        {
            let currentPaddle = contact.bodyA.node?.name!
            
            if currentPaddle == "rightPaddle"
            {
                puck.physicsBody?.applyImpulse(CGVector(dx: 1.2 * (puck.position.x - rightPaddle.position.x), dy: 1.2 * (puck.position.y - rightPaddle.position.y)))
            }
            
            if currentPaddle == "leftPaddle"
            {
                puck.physicsBody?.applyImpulse(CGVector(dx: 1.2 * (puck.position.x - leftPaddle.position.x), dy: 1.2 * (puck.position.y - leftPaddle.position.y)))
            }
        }
        
        if contact.bodyA.categoryBitMask == rightGoalCategory {
            leftScoreCounter += 1
            leftScore.text = "\(leftScoreCounter)"
            puck.run(SKAction.move(to: CGPoint(x: 150, y: -50), duration: 0.0))
            puck.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }
            
        else if contact.bodyA.categoryBitMask == leftGoalCategory {
            rightScoreCounter += 1
            rightScore.text = "\(rightScoreCounter)"
            puck.run(SKAction.move(to: CGPoint(x: -150, y: -50), duration: 0.0))
            puck.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }
    }
    
    func reset() {
//        let delayInSeconds = 2.0
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.winnerLabel.text = "Ready!"
            self.leftScore.text = "0"
            self.rightScore.text = "0"
            self.leftScoreCounter = 0
            self.rightScoreCounter = 0
            self.puck.run(SKAction.move(to: CGPoint(x: 0, y: -50), duration: 0))
            self.rightPaddle.run(SKAction.move(to: CGPoint(x: 410, y: -50), duration: 0))
            self.leftPaddle.run(SKAction.move(to: CGPoint(x: -410, y: -50), duration: 0))
            self.puck.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            self.leftPaddle.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            self.rightPaddle.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            self.didEnd = false
            self.counter = 1
            self.timerCounter = 120
            self.backToMainNode.alpha = 0
            self.playAgainNode.alpha = 0
//        }
    }
    
    var counter = 1
    var timerCounter = 120
    override func update(_ currentTime: TimeInterval) {
        if didEnd == false {
            counter += 1
        }
        if counter % 56 == 0 && timerCounter != 0
        {
            if counter <= 56 {
                winnerLabel.text = "Ready!"
            }
            else if counter <= 112 {
                winnerLabel.text = "Set!"
            }
            else if counter <= 168 {
                winnerLabel.text = "GO!"
            }
            else if counter > 168 {
                timerCounter -= 1
                winnerLabel.text = "\(timerCounter)"
            }
        }
        else if timerCounter == 0
        {
            playAgainNode.alpha = 1
            backToMainNode.alpha = 1
            if rightScoreCounter > leftScoreCounter
            {
                winnerLabel.text = "Player 2 Wins!"
//                reset()
                didEnd = true
            }
            else if leftScoreCounter > rightScoreCounter
            {
                winnerLabel.text = "Player 1 Wins!"
//                reset()
                didEnd = true
            }
            else {
//                reset()
                didEnd = true
            }
        }
        if rightPaddle.position.x < 0 {
            rightPaddle.position = CGPoint(x: 0, y: rightPaddle.position.y)
        }
        if leftPaddle.position.x > 0 {
            leftPaddle.position = CGPoint(x: 0, y: leftPaddle.position.y)
        }
    }
}
