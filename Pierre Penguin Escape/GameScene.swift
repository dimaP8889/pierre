//
//  GameScene.swift
//  Pierre Penguin Escape
//
//  Created by dmitriy1 on 2/3/19.
//  Copyright © 2019 dmitriy1. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let cam = SKCameraNode()
    let ground = Ground()
    let player = Player()
    var screenCenterY : CGFloat = 0
    
    let initialPlayerPosition = CGPoint(x: 150, y: 150)
    var playerProgress = CGFloat()
    
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = .zero
        self.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
        
        self.camera = cam
        
        ground.position = CGPoint(x: -self.size.width * 2, y: 30)
        ground.size = CGSize(width: self.size.width * 6, height: 0)
        ground.CreateChildren()
        self.addChild(ground)
        
        player.position = initialPlayerPosition
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        
        screenCenterY = self.size.height / 2
    }
    
    override func didSimulatePhysics() {
        
        var cameraYPos = screenCenterY
        
        cam.yScale = 1
        cam.xScale = 1
        if player.position.y > screenCenterY {
            
            cameraYPos = player.position.y
            let percentOfMaxHeight = (player.position.y - screenCenterY) / (player.maxHeight - screenCenterY)
            let newScale = 1 + percentOfMaxHeight
            
            cam.yScale = newScale
            cam.xScale = newScale
        }
        self.camera?.position = CGPoint(x: player.position.x, y: cameraYPos)
        
        playerProgress = player.position.x - initialPlayerPosition.x
        ground.checkForRepositionn(playerProgress: playerProgress)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            let nodeTouched = atPoint(location)
            
            if let gameSprite = nodeTouched as? GameSprite {
                
                gameSprite.onTap()
            }
        }
        
        player.startFlapping()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        player.stopFlapping()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        player.stopFlapping()
    }
    
    override func update(_ currentTime: TimeInterval) {
        player.update()
    }
}
