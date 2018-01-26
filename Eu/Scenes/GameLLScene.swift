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
    //time1
    private var inveja : SKNode!
    private var dorgas : SKNode!
    private var semjogar : SKNode!
    //time2
    private var bullying : SKNode!
    private var cagadas : SKNode!
    private var badcoding : SKNode!
    
    private var qualRua = 1
    private var time = 0.0
    
    private var timeCity = 0.0
    private var witchCity = 1
    
    private var goDown = SKAction.move(to: CGPoint(x: 0, y: -870), duration: 5)
    private var goDownEnemies1 = SKAction.move(to: CGPoint(x: -342, y: -950), duration: 5)
    private var goDownEnemies2 = SKAction.move(to: CGPoint(x: 330, y: -950), duration: 5)
    
    private var timeEnemies = 0.0
    private var witchEnemies = 1
    
    override func sceneDidLoad() {
        
        self.rua = childNode(withName: "rua") as! SKSpriteNode
        self.carro = childNode(withName: "carro") as! SKSpriteNode
        rua.zPosition = 0
        carro.zPosition = 5
        
        self.londrina = childNode(withName: "Londrina") as! SKSpriteNode
        self.curitiba = childNode(withName: "Curitiba") as! SKSpriteNode
        self.cuiaba = childNode(withName: "Cuiaba") as! SKSpriteNode
        londrina.zPosition = 9
        cuiaba.zPosition = 8
        curitiba.zPosition = 7
        
        self.inveja = childNode(withName: "inveja") as! SKSpriteNode
        self.dorgas = childNode(withName: "dorgas") as! SKSpriteNode
        self.semjogar = childNode(withName: "semjogar") as! SKSpriteNode
        self.bullying = childNode(withName: "bullying") as! SKSpriteNode
        self.cagadas = childNode(withName: "cagadas") as! SKSpriteNode
        self.badcoding = childNode(withName: "bad coding") as! SKSpriteNode
        inveja.zPosition = 5
        semjogar.zPosition = 5
        dorgas.zPosition = 5
        bullying.zPosition = 5
        cagadas.zPosition = 5
        badcoding.zPosition = 5
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
        if Double(timeCity+10) < currentTime{
            print("oi")
            if witchCity == 1{
                londrina.run(goDown)
                witchCity = 2
            }else if witchCity == 2{
                cuiaba.run(goDown)
                witchCity = 3
            }else if witchCity == 3{
                curitiba.run(goDown){
                    
                }
            }
            
            timeCity = currentTime
        }
        
        if witchEnemies == 1{
            if cagadas.contains(carro){
                goToGameScene()
            }
        }else if witchEnemies == 2{
            if bullying.contains(carro){
                goToGameScene()
            }

        }else if witchEnemies == 3{
            if inveja.contains(carro){
                goToGameScene()
            }

        }else if witchEnemies == 4{
            if badcoding.contains(carro){
                goToGameScene()
            }

            
        }else if witchEnemies == 5{
            if dorgas.contains(carro){
                goToGameScene()
            }

            
        }else if witchEnemies == 6{
            if semjogar.contains(carro){
                goToGameScene()
            }
            
        }
        
        if Double(timeEnemies+5) < currentTime{
            print("oi")
            if witchEnemies == 1{
                cagadas.run(goDownEnemies2)
                witchEnemies = 2
            }else if witchEnemies == 2{
                bullying.run(goDownEnemies2)
                witchEnemies = 3
            }else if witchEnemies == 3{
                inveja.run(goDownEnemies1)
                    witchEnemies = 4
            }else if witchEnemies == 4{
                badcoding.run(goDownEnemies2)
                    witchEnemies = 5
                
            }else if witchEnemies == 5{
                dorgas.run(goDownEnemies1)
                witchEnemies = 6
                
            }else if witchEnemies == 6{
                witchEnemies = 7
                semjogar.run(goDownEnemies1){
                    salles[1] = 1
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doaSegue"), object: nil)
                }
            }
            timeEnemies = currentTime
        }
        
    }
    
    func goToGameScene(){
        if let scene = GKScene(fileNamed: "GameESScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameESScene? {
                
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                
                // Present the scene
                if let view = self.view as! SKView? {
                    
                    //scene.userData?.setObject(self, forKey: "wholeGameViewController" as NSCopying)
                    
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
}
