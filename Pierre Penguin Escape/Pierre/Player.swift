//
//  Player.swift
//  Pierre Penguin Escape
//
//  Created by dmitriy1 on 2/7/19.
//  Copyright © 2019 dmitriy1. All rights reserved.
//

import Foundation
import SpriteKit

class Player : SKSpriteNode, GameSprite {
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Pierre")
    var initialSize: CGSize = CGSize(width: 64, height: 64)
    
    var flyAnimation = SKAction()
    var soarAnimation = SKAction()
    
    var flapping = false
    let maxFlappingForce : CGFloat = 57000
    let maxHeight : CGFloat = 1000
    
    init() {
        super.init(texture: nil, color: .clear, size: initialSize)
        createAnimations()
        self.run(soarAnimation, withKey: "soarAnimation")
        
        let bodyTexture = textureAtlas.textureNamed("pierre-flying-3")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: self.size)
        self.physicsBody?.linearDamping = 0.9
        self.physicsBody?.mass = 30
        self.physicsBody?.allowsRotation = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        
        if self.flapping {
            
            var forceToApply = maxFlappingForce
            
            if position.y > 600 {
                
                let percentageOfMaxHeight = position.y / maxHeight
                let flappingForceSubtraction = percentageOfMaxHeight * maxFlappingForce
                
                forceToApply -= flappingForceSubtraction
            }
            self.physicsBody?.applyForce(CGVector(dx: 0, dy: forceToApply))
        }
        
        self.physicsBody?.velocity.dx = 200
    }
    
    func startFlapping() {
        
        self.removeAction(forKey: "soarAnimation")
        self.run(flyAnimation, withKey: "flyAnimation")
        self.flapping = true
    }
    
    func stopFlapping() {
        
        self.removeAction(forKey: "flyAnimation")
        self.run(soarAnimation, withKey: "soarAnimation")
        self.flapping = false
    }
    
    func createAnimations() {
        
        let rotateUpAnimation = SKAction.rotate(toAngle: 0, duration: 0.475)
        rotateUpAnimation.timingMode = .easeOut
        let rotateDownAnimation = SKAction.rotate(toAngle: -1, duration: 0.8)
        rotateDownAnimation.timingMode = .easeIn
        
        let flyFrames : [SKTexture] = [
            textureAtlas.textureNamed("pierre-flying-1"),
            textureAtlas.textureNamed("pierre-flying-2"),
            textureAtlas.textureNamed("pierre-flying-3"),
            textureAtlas.textureNamed("pierre-flying-4"),
            textureAtlas.textureNamed("pierre-flying-3"),
            textureAtlas.textureNamed("pierre-flying-2")
        ]
        
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.03)
        flyAnimation = SKAction.group([SKAction.repeatForever(flyAction), rotateUpAnimation])
        
        let soarFrame : [SKTexture] = [
            
            textureAtlas.textureNamed("pierre-flying-1")
        ]
        
        let soarAction = SKAction.animate(with: soarFrame, timePerFrame: 1)
        soarAnimation = SKAction.group([SKAction.repeatForever(soarAction), rotateDownAnimation])
        
        
    }
    
    func onTap() {
        
    }
}
