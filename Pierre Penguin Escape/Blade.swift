//
//  Blade.swift
//  Pierre Penguin Escape
//
//  Created by dmitriy1 on 2/16/19.
//  Copyright © 2019 dmitriy1. All rights reserved.
//

import SpriteKit

class Blade : SKSpriteNode, GameSprite {
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Enemies")
    var initialSize: CGSize = CGSize(width: 185, height: 92)
    var spinAnimation = SKAction()
    
    init() {
        
        super.init(texture: nil, color: .clear, size: initialSize)
        let startTexture = textureAtlas.textureNamed("blade")
        
        self.physicsBody = SKPhysicsBody(texture: startTexture, size: initialSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        
        createAnimation()
        self.run(spinAnimation)
    }
    
    func createAnimation() {
        
        let spinFrames : [SKTexture] = [
            
            textureAtlas.textureNamed("blade"),
            textureAtlas.textureNamed("blade-2")
        ]
        
        let spinAction = SKAction.animate(with: spinFrames, timePerFrame: 0.07)
        spinAnimation = SKAction.repeatForever(spinAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func onTap() {
    }
}
