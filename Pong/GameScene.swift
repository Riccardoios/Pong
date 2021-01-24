//
//  GameScene.swift
//  Pong
//
//  Created by Riccardo Carlotto on 21/12/2019.
//  Copyright © 2019 Riccardo Carlotto. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()
    
    var score = [Int]()
    
    var dx = 8
    var dy = 8
    
    override func didMove(to view: SKView) {
        
        topLbl = self.childNode(withName: "topLabel") as! SKLabelNode
        btmLbl = self.childNode(withName: "btmLabel") as! SKLabelNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
        
        
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
    }
    
    func startGame() {
        score = [0,0]
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
        
        ball.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
    }
    
    func addscore(playerWhoWon : SKSpriteNode) {
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        let aumentatore = 0 //score.reduce(0,+)
        print (aumentatore)
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: dx + aumentatore, dy: dy + aumentatore))
        } else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -(dx) + aumentatore, dy: -(dy) + aumentatore))
        }
        
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            } else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            } else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
            dx = 9
            dy = 9
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.08))
            dx = 13
            dy = 13
            break
        case .player2:
            
            break
            
        }
        
        
        
        if ball.position.y <= main.position.y - 30 {
            addscore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 30 {
            addscore(playerWhoWon: main)
        }
    }
}
