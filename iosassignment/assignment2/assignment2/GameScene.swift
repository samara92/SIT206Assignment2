//
//  GameScene.swift
//  assignment2
//
//  Created by SAMEERA PRIYANANDA on 21/05/2017.
//  Copyright © 2017 SAMEERA PRIYANANDA. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var topLabel = SKLabelNode()
    var bottomLabel = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        
        
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        bottomLabel = self.childNode(withName: "bottomLabel") as! SKLabelNode
        
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
    
    func startGame(){
    
        score = [0,0]
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        
    }
    
    func addScore(playerWhoWon : SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y:0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main{
        
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        }
        else if playerWhoWon == enemy {
        
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
    
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self)
            
            if currentGameType == .player2{
                
                if location.y > 0{
                    enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
                    
                }
                if location.y < 0{
                    
                    main.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
                    
                }
            }else{
                
                main.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self)
            
            if currentGameType == .player2{
                
                if location.y > 0{
                    enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
                    
                }
                if location.y < 0{
                    
                    main.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
                    
                }
            }else{
            
                main.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
            }
            
        }
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.3))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.6))
            break
        case .player2:
            break
        }
        
        
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        

        
        if ball.position.y <= main.position.y - 30 {
            addScore(playerWhoWon: enemy)
            
        
        }
        else if ball.position.y >= enemy.position.y + 30{
            addScore(playerWhoWon: main)
        
        
        }
        
        
        
        
    }
    
    
}
