//
//  Coin.swift
//  Pierre Penguin Escape
//
//  Created by dmitriy1 on 2/16/19.
//  Copyright © 2019 dmitriy1. All rights reserved.
//

import SpriteKit

class Coin: SKSpriteNode, GameSprite {
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Environment")
    var initialSize: CGSize = CGSize(width: 26, height: 26)
    
    var value = 1
    
    init() {
        
        let bronzeTexture = textureAtlas.textureNamed("coin-bronze")
        
        super.init(texture: bronzeTexture, color: .clear, size: initialSize)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        self.physicsBody?.affectedByGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func turnToGold() {
        self.texture = textureAtlas.textureNamed("coin-gold")
        self.value = 5
    }
    
    func onTap() {
    }
}
