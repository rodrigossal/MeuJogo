//
//  GameScene.swift
//  Eu
//
//  Created by Rodrigo Salles Stefani on 22/01/18.
//  Copyright © 2018 Rodrigo Salles Stefani. All rights reserved.
//

import SpriteKit
import GameplayKit
import AudioToolbox
import AVFoundation

class GameSAScene: SKScene {
    
    private var kick : SKNode!
    private var snare : SKNode!
    private var hihat : SKNode!
    
    private var hit = 0
    
    let Hihatsound = SKAction.playSoundFileNamed("Hihatsound.mp3", waitForCompletion: false)
    let SnareSound = SKAction.playSoundFileNamed("SnareSound.mp3", waitForCompletion: false)
    let KickSound = SKAction.playSoundFileNamed("KickSound.mp3", waitForCompletion: false)
    
    override func sceneDidLoad() {

        self.kick = childNode(withName: "kick") as! SKSpriteNode
        self.snare = childNode(withName: "snare") as! SKSpriteNode
        self.hihat = childNode(withName: "hihat") as! SKSpriteNode
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if hihat.contains(pos){
            playSound(sound: Hihatsound)
            hit += 1
        }
        if snare.contains(pos){
            playSound(sound: SnareSound)
            hit += 1
        }
        if kick.contains(pos){
            playSound(sound: KickSound)
            hit += 1
        }
        if hit > 20{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doaSegue"), object: nil)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    func playSound(sound : SKAction){
        run(sound)
    }
    
    override func update(_ currentTime: TimeInterval) {
      
    }
}
