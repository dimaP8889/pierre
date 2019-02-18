//
//  MadFly.swift
//  Pierre Penguin Escape
//
//  Created by dmitriy1 on 2/16/19.
//  Copyright © 2019 dmitriy1. All rights reserved.
//

import SpriteKit

class MadFly : SKSpriteNode, GameSprite {
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Enemies")
    var initialSize: CGSize = CGSize(width: 61, height: 29)
    var flyAnimation = SKAction()
    
    init() {
        
        super.init(texture: nil, color: .clear, size: initialSize)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
    
        createAnimation()
        self.run(flyAnimation)
    }
    
    func createAnimation() {
        
        let flyFrames : [SKTexture] = [
            textureAtlas.textureNamed("madfly"),
            textureAtlas.textureNamed("madfly-fly")
        ]
        
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.14)
        flyAnimation = SKAction.repeatForever(flyAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func onTap() {
    }
    
    
}
