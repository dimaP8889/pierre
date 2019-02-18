//
//  Star.swift
//  Pierre Penguin Escape
//
//  Created by dmitriy1 on 2/16/19.
//  Copyright © 2019 dmitriy1. All rights reserved.
//

import SpriteKit

class Star : SKSpriteNode, GameSprite {
    
    var initialSize = CGSize(width: 40, height: 38)
    var textureAtlas : SKTextureAtlas = SKTextureAtlas(named: "Environment")
    var pulseAnimation = SKAction()
    
    init() {
        
        let starTexture = textureAtlas.textureNamed("star")
        super.init(texture: starTexture, color: .clear, size: initialSize)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        createAnimation()
        self.run(pulseAnimation)
    }
    
    func createAnimation() {
        
        let pulseOutGroup = SKAction.group([
            SKAction.fadeAlpha(to: 0.85, duration: 0.8),
            SKAction.scale(to: 0.6, duration: 0.8),
            SKAction.rotate(byAngle: -0.3, duration: 0.8)
            ])
        let pulseInGroupe = SKAction.group([
            SKAction.fadeAlpha(to: 1, duration: 1.5),
            SKAction.scale(to: 1, duration: 1.5),
            SKAction.rotate(byAngle: 3.5, duration: 1.5)
            ])
        
        let pulseSequence = SKAction.sequence([
            pulseOutGroup, pulseInGroupe
            ])
        
        pulseAnimation = SKAction.repeatForever(pulseSequence)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func onTap() {
    }
}
