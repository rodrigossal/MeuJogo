//
//  GameLLScene.swift
//  Eu
//
//  Created by Rodrigo Salles Stefani on 26/01/18.
//  Copyright © 2018 Rodrigo Salles Stefani. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameLLScene: SKScene{
    
    private var rua : SKNode!
    private var carro : SKNode!
    
    private var londrina : SKNode!
    private var curitiba : SKNode!
    private var cuiaba : SKNode!
    
    private var qualRua = 1
    private var time = 0.0
    
    override func sceneDidLoad() {
        
        self.rua = childNode(withName: "rua") as! SKSpriteNode
        self.carro = childNode(withName: "carro") as! SKSpriteNode
        rua.zPosition = 0
        carro.zPosition = 5
        
        self.londrina = childNode(withName: "Londrina") as! SKSpriteNode
        self.curitiba = childNode(withName: "Curitiba") as! SKSpriteNode
        self.cuiaba = childNode(withName: "Cuiaba") as! SKSpriteNode
    }
    
    func touchDown(atPoint pos : CGPoint) {
  
        if pos.x > 0{
            carro.run(SKAction.moveTo(x: 358, duration: 0.5))
            //carro.position = CGPoint(x: 358, y: -606)
        }else{
            carro.run(SKAction.moveTo(x: -358, duration: 0.5))
            //carro.position = CGPoint(x: -358, y: -606)
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
    
    override func update(_ currentTime: TimeInterval) {
        if Double(time+0.2) < currentTime{
            //print("viirou")
            var simboloAceso: SKTexture
            if qualRua == 1{
                simboloAceso = SKTexture.init(imageNamed: "rua2")
                qualRua = 2
                //print("1")
            }else{
                simboloAceso = SKTexture.init(imageNamed: "rua1")
                qualRua = 1
                //print("2")
            }
            let changeTextures = SKAction.animate(with: [simboloAceso], timePerFrame: 0.1)
            self.rua.run(changeTextures)

            time = currentTime
        }
    }
}
