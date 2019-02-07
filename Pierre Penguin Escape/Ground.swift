//
//  Ground.swift
//  Pierre Penguin Escape
//
//  Created by dmitriy1 on 2/7/19.
//  Copyright © 2019 dmitriy1. All rights reserved.
//

import Foundation
import SpriteKit

class Ground: SKSpriteNode, GameSprite {
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Environment")
    var initialSize: CGSize = CGSize.zero
    
    func CreateChildren() {
        
        self.anchorPoint = CGPoint(x: 0, y: 1)
        
        let texture = textureAtlas.textureNamed("ground")
        var titleCount : CGFloat = 0
        let titleSize = CGSize(width: 35, height: 300)
        
        while titleCount * titleSize.width < self.size.width {
            
            let titleNode = SKSpriteNode(texture: texture)
            titleNode.size = titleSize
            titleNode.position.x = titleCount * titleSize.width
            
            titleNode.anchorPoint = CGPoint(x: 0, y: 1)
            
            self.addChild(titleNode)
            titleCount += 1
        }
        
        let pointTopLeft = CGPoint(x: 0, y: 0)
        let pointTopRight = CGPoint(x: self.size.width, y: 0)
        
        self.physicsBody = SKPhysicsBody(edgeFrom: pointTopLeft, to: pointTopRight)
    }
    
    func onTap() {
        
    }
    
}
