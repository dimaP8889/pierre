//
//  Bat.swift
//  Pierre Penguin Escape
//
//  Created by dmitriy1 on 2/16/19.
//  Copyright © 2019 dmitriy1. All rights reserved.
//

import SpriteKit

class Bat :  SKSpriteNode, GameSprite {
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Enemies")
    var initialSize: CGSize = CGSize(width: 44, height: 24)
    var flyAnimation = SKAction()
    
    init() {
        
        super.init(texture: nil, color: .clear, size: initialSize)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity  = false
        
        createAnimation()
        self.run(flyAnimation)
    }
    
    func createAnimation() {
        
        let flyFrames : [SKTexture] = [
            
            textureAtlas.textureNamed("bat"),
            textureAtlas.textureNamed("bat-fly")
        ]
        
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.12)
        flyAnimation = SKAction.repeatForever(flyAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func onTap() {
        
    }
}
