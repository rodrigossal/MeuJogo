//
//  GameESScene.swift
//  Eu
//
//  Created by Rodrigo Salles Stefani on 26/01/18.
//  Copyright © 2018 Rodrigo Salles Stefani. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameESScene: SKScene{
    
    var spamNodes = [SKSpriteNode]()
    var spaceShip : SKSpriteNode?
    var SpaceShipSelecionado = false
    var bulletsNode = [SKSpriteNode]()
    var tempoAtual : TimeInterval = 0.0
    var spaceString : [String : CGPoint]!
    var iniciou = false
    var isTheEnd : Bool = false
    var enemiesDown : Int = 0

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        //backgroundColor = UIColor.black
        
        var x = [-250, -150, -50, 50 , 150, 250]
        var y = [750, 850, 350, 450, 550, 650]
        
        for i in 0 ..< x.count-1 {
            let j = Int(arc4random_uniform(UInt32(x.count - i))) + i
            if i != j {
                x.swapAt(i, j)
                y.swapAt(i, j)
            }
        }
        
        spaceString = ["amor.png" : CGPoint(x: x[0], y: y[0]), "disrespeito-1.png" : CGPoint(x: x[1], y: y[1]), "disrespeito-2.png" : CGPoint(x: x[2], y: y[2]), "disrespeito-3.png" : CGPoint(x: x[3], y: y[3]), "disrespeito.png" : CGPoint(x: x[4], y: y[4])]
        
        for (string, pos) in spaceString
        {
            self.spamNodes.append(SKSpriteNode(imageNamed: string))
            self.spamNodes.last?.position = pos
            self.spamNodes.last?.name = string
            self.spamNodes.last?.size = CGSize(width: 100, height: 110)
            self.spamNodes.last?.setScale(1.5)
            self.addChild(spamNodes.last!)
        }
        
        self.spaceShip = SKSpriteNode(imageNamed: "eu.png")
        
        spaceShip?.position = CGPoint(x: 300, y: -630)
        spaceShip?.size = CGSize(width: 150, height: 210)
        spaceShip?.zPosition = 10
        self.addChild(spaceShip!)
        spaceShip?.run(SKAction.repeatForever(SKAction.sequence([SKAction.move(to: CGPoint(x: -350, y: -630), duration: 2), SKAction.move(to: CGPoint(x: 350, y: -630), duration: 2)])))
        
        //createIntro(text: "Defend your mail", pos: CGPoint(x: 0, y: -270), size: 80, color: SKColor.white)
        //createSubtitle(text: "Click to shoot", pos: CGPoint(x: 0, y: -350), size: 65, color: SKColor.lightGray)
        
    }


    func touchDown(atPoint pos : CGPoint) {
        
        if spaceShip!.contains(pos){  // TOCAR NA NAVE
            SpaceShipSelecionado = true
            iniciou = true
        }
    }

    func touchMoved(toPoint pos : CGPoint) {
        if SpaceShipSelecionado{
            //spaceShip?.position.x = pos.x
        }
    }

    func touchUp(atPoint pos : CGPoint) {
        //if SpaceShipSelecionado{
        self.bulletsNode.append(SKSpriteNode(imageNamed: "tiro.png"))
        bulletsNode.last?.position = (spaceShip?.position)!
        bulletsNode.last?.size = CGSize(width: 10, height: 40)
        bulletsNode.last?.zPosition = 1
        self.addChild(bulletsNode.last!)
        
        SpaceShipSelecionado = false
        //}
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
        super.update(currentTime)
        moveBullets()
        moveSpam()
    }

    func moveSpam()
    {
        if !isTheEnd
        {
            for spam in spamNodes
            {
                spam.position.y -= 2
                if ((spam.position.y < -(self.size.height/2) && spam.name != "amor.png") || (spam.contains((spaceShip?.position)!) && spam.name != "amor.png"))
                {
                    isTheEnd = true
                    //loseTime(time: 0.1)
                    spam.run(SKAction.sequence([SKAction.scale(by: 0.1, duration: 0.1), SKAction.removeFromParent()]))
                    
                }
            }
        }
    }

    func moveBullets()
    {
        if !isTheEnd
        {
            for bullet in bulletsNode
            {
                bullet.position.y += 15
                for pop in spamNodes
                {
                    if pop.contains(bullet.position)
                    {
                        if pop.name == "amor.png"
                        {
                            //lose
                            isTheEnd = true
                            return
                        }
                        enemiesDown += 1
                        //let delAt = bulletsNode.index(of: bullet)!
                        pop.removeFromParent()
                        spamNodes.remove(at: spamNodes.index(of: pop)!)
                        bullet.position = CGPoint(x: 0, y: 1000)
                        bullet.run(SKAction.removeFromParent())
                        //bulletsNode.remove(at: delAt)
                        
                        if enemiesDown >= 4
                        {
                           // winTime(time: 0.1)
                            isTheEnd = true
                            return
                        }
                    }
                }
                
                if bullet.position.y > (self.size.height/2) && children.contains(bullet)
                {
                    bullet.run(SKAction.sequence([SKAction.scale(by: 0.1, duration: 0.5), SKAction.removeFromParent()]))
                    bulletsNode.remove(at: bulletsNode.index(of: bullet)!)
                }
            }
        }
    }
    
    func goToGameScene(){
        let gameScene:GameScene = GameScene(size: self.view!.bounds.size) // create your new scene
        let transition = SKTransition.fadeWithDuration(1.0) // create type of transition (you can check in documentation for more transtions)
        gameScene.scaleMode = SKSceneScaleMode.Fill
        self.view!.presentScene(gameScene, transition: transition)
    }
}
