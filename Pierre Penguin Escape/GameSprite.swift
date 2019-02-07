//
//  GameSprite.swift
//  Pierre Penguin Escape
//
//  Created by dmitriy1 on 2/7/19.
//  Copyright © 2019 dmitriy1. All rights reserved.
//

import Foundation
import SpriteKit

protocol GameSprite {
    
    var textureAtlas : SKTextureAtlas { get set }
    var initialSize : CGSize { get set }
    func onTap()
}
