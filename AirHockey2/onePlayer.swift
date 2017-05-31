//
//  onePlayer.swift
//  AirHockey2
//
//  Created by student1 on 5/5/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation


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
    var playAgainNode = SKSpriteNode()
    var backToMainNode = SKSpriteNode()
    var backToMainOnBarNode = SKSpriteNode()
    var resetNode = SKSpriteNode()

    
    func playMySound(){
        airHornPlayer = try! AVAudioPlayer(contentsOf: airHornSoundURL)
        airHornPlayer.prepareToPlay()
        airHornPlayer.play()
    }
    
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
        resetNode = self.childNode(withName: "reset") as! SKSpriteNode
        backToMainOnBarNode = self.childNode(withName: "backToMainOnBar") as! SKSpriteNode
        
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
//        addChild(left)
        addChild(top)
//        addChild(right)
        
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
            if resetNode.contains(location) && resetNode.alpha == 1 {
                reset()
            }
            else if backToMainOnBarNode.contains(location) && backToMainOnBarNode.alpha == 1 {
                let viewControllerForSegue = self.view?.window?.rootViewController
                viewControllerForSegue?.dismiss(animated: true, completion: nil)
            }
            else if backToMainNode.contains(location) && backToMainNode.alpha == 1 {
                let viewControllerForSegue = self.view?.window?.rootViewController
                viewControllerForSegue?.dismiss(animated: true, completion: nil)
            }
            else if playAgainNode.contains(location) && playAgainNode.alpha == 1 {
                reset()
            }
            else if location.x < 0 && location.y < 249 && location.x > frame.origin.x + 25
            {
                leftPaddle.run(SKAction.move(to: location, duration: 0.05))
            }
        }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if counter > 168 {
        for touch in touches
        {
            let location = touch.location(in: self)
            if resetNode.contains(location) && resetNode.alpha == 1 {
                reset()
            }
            else if backToMainOnBarNode.contains(location) && backToMainOnBarNode.alpha == 1 {
                let viewControllerForSegue = self.view?.window?.rootViewController
                viewControllerForSegue?.dismiss(animated: true, completion: nil)
            }
            else if backToMainNode.contains(location) && backToMainNode.alpha == 1 {
                let viewControllerForSegue = self.view?.window?.rootViewController
                viewControllerForSegue?.dismiss(animated: true, completion: nil)
            }
            else if playAgainNode.contains(location) && playAgainNode.alpha == 1 {
                reset()
            }
            else if location.x < 0 && location.y < 249 && location.x > frame.origin.x + 25
            {
                leftPaddle.run(SKAction.move(to: location, duration: 0.05))
            }
        }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print(contact.bodyA)
        print(contact.bodyB)
        if contact.bodyA.categoryBitMask == paddleCategory
        {
            let currentPaddle = contact.bodyA.node?.name!
            print(currentPaddle!)
            if currentPaddle == "leftPaddle"
            {
                print("left")
                puck.physicsBody?.applyImpulse(CGVector(dx: 1.3 * (puck.position.x - leftPaddle.position.x)  , dy: 1.3 * (puck.position.y - leftPaddle.position.y)))
            }
            if currentPaddle == "rightPaddle"
            {
                print("right")
                puck.physicsBody?.applyImpulse(CGVector(dx: 1.3 * (puck.position.x - rightPaddle.position.x)  , dy: 1.3 * (puck.position.y - rightPaddle.position.y)))
            }
        }
        else if  contact.bodyB.categoryBitMask == paddleCategory {
            let currentPaddle = contact.bodyB.node?.name!
            print(currentPaddle!)
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
            puck.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            playMySound()
        }
            
        else if contact.bodyA.categoryBitMask == leftGoalCategory {
            rightScoreCounter += 1
            rightScore.text = "\(rightScoreCounter)"
            puck.run(SKAction.move(to: CGPoint(x: -150, y: -50), duration: 0.0))
            puck.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            playMySound()
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
        self.counter = 1
        self.timerCounter = 120
        self.backToMainNode.alpha = 0
        self.playAgainNode.alpha = 0
        self.backToMainOnBarNode.alpha = 1
        self.resetNode.alpha = 1
//        }
    }
    var counter = 1
    var timerCounter = 120
    override func update(_ currentTime: TimeInterval) {
        counter += 1
        if puck.position.x < 0
        {
            let randomNumber = arc4random_uniform(500) + 1
            rightPaddle.run(SKAction.move(to: CGPoint(x: 410, y: puck.position.y), duration: 0.2))
        }
            
        else if puck.position.x > 0 && puck.position.x > rightPaddle.position.x
        {
            if !(rightPaddle.position.x + 80 > 450) {
                rightPaddle.run(SKAction.move(to: CGPoint(x: puck.position.x + 80, y: puck.position.y), duration: 0.2))
            }
            else if rightPaddle.position.x + 80 > 450 {
                rightPaddle.position.x = 450
            }
        }
        else if puck.position.x > 0
        {
            rightPaddle.run(SKAction.move(to: CGPoint(x: puck.position.x, y: puck.position.y), duration: 0.2))
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
            resetNode.alpha = 0
            backToMainOnBarNode.alpha = 0
            if rightScoreCounter > leftScoreCounter
            {
                winnerLabel.text = "CPU Wins!"
//                reset()
            }
            else if leftScoreCounter > rightScoreCounter
            {
                winnerLabel.text = "Player Wins!"
//                reset()
            }
            else {
//                reset()
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
