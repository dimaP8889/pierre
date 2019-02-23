//
//  EncounterManager.swift
//  Pierre Penguin Escape
//
//  Created by Dimas on 2/23/19.
//  Copyright © 2019 dmitriy1. All rights reserved.
//

import Foundation
import SpriteKit

class EncounterManager {
    
    let encounterNames : [String] = [
        "EncounterA",
        "EncounterB",
        "EncounterC"
    ]
    
    var currentEncounterIndex : Int?
    
    var previousEncounterIndex : Int?
    
    var encounters : [SKNode] = []
    
    init() {
        
        for encounterFileName in encounterNames {
            
            let encounterNode = SKNode()
            
            if let encounterScene = SKScene(fileNamed: encounterFileName) {
                
                for child in encounterScene.children {
                    
                    let copyOfNode = type(of: child).init()
                    copyOfNode.position = child.position
                    copyOfNode.name = child.name
                    encounterNode.addChild(copyOfNode)
                }
            }
            encounters.append(encounterNode)
            //save initial sprite positions for this encounter
            saveSpritePositions(node: encounterNode)
            
            //Turn coins gold
            
            encounterNode.enumerateChildNodes(withName: "gold") { (node, stop) in
                (node as? Coin)?.turnToGold()
            }
        }
    }
    
    func addEncountersToScene(gameScene : SKNode) {
        
        var encountersPosY = 1000
        for encounterNode in encounters {
            
            encounterNode.position = CGPoint(x: -2000, y: encountersPosY)
            gameScene.addChild(encounterNode)
            encountersPosY *= 2
        }
    }
    
    //Store the initial positions of the children of a node
    func saveSpritePositions(node : SKNode) {
        
        for sprite in node.children {
            
            if let spriteNode = sprite as? SKSpriteNode {
                
                let initialPositionValue = NSValue.init(cgPoint: sprite.position)
                spriteNode.userData = ["initialPosition" : initialPositionValue]
                //Save the positions for children of this node
                saveSpritePositions(node: spriteNode)
            }
        }
    }
    
    // Reset all children nodes to their original positions
    func resetSpritePositions(node : SKNode) {
        
        for sprite in node.children {
            if let spriteNode = sprite as? SKSpriteNode {
                
                // Remove any linear or angular velocity
                spriteNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                spriteNode.physicsBody?.angularVelocity = 0
                // reset rotation of the sprite
                spriteNode.zRotation = 0
                if let initialPositionalVal = spriteNode.userData?.value(forKey: "initialPosition") as? NSValue {
                    
                    spriteNode.position = initialPositionalVal.cgPointValue
                }
                //Reset positions on this node's children
            }
        }
    }
    
    func placeNextEncounter(currentXPos : CGFloat) {
        
        // count encounters
        let encounterCount = UInt32(encounters.count)
        //The game requires at least 3 encounters to function
        // so exit this func if it less than 3
        if encounterCount < 3 { return }
        
        //We need to pick an encounter which is not
        //currently on the screen
        var nextEncounterIndex : Int?
        var trulyNew : Bool?
        // The current encounter and previous can potentially
        // be on the screen now
        // Pick until we get a new one
        while trulyNew == false || trulyNew == nil {
            
            // Pick a random encounter to start set next
            nextEncounterIndex = Int(arc4random_uniform(encounterCount))
            // First asset it as a new encounter
            trulyNew = true
            // Test if it is instead the current encounter
            if let currentIndex = currentEncounterIndex {
                if (nextEncounterIndex == currentIndex) {
                    trulyNew = false
                }
            }
            //Test if it is the directly previous
            if let previousIndex = previousEncounterIndex {
                if (nextEncounterIndex == previousIndex) {
                    trulyNew = false
                }
            }
        }
        
        // Keep track of the current encounter
        previousEncounterIndex = currentEncounterIndex
        currentEncounterIndex = nextEncounterIndex
        
        // reste the new encounter and position it ahead of the player
        let encounter = encounters[currentEncounterIndex!]
        encounter.position = CGPoint(x: currentXPos + 1000, y: 300)
        resetSpritePositions(node: encounter)
    }
}
