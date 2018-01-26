//
//  MainViewController.swift
//  Eu
//
//  Created by Rodrigo Salles Stefani on 23/01/18.
//  Copyright © 2018 Rodrigo Salles Stefani. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let reuseIdentifier = "cell"
    
    var item = [GameType]()
    var flag = false
    
    //var gvc : GameViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        item.append(GameType(image: #imageLiteral(resourceName: "Music")))
        item.append(GameType(image: #imageLiteral(resourceName: "Games")))
        item.append(GameType(image: #imageLiteral(resourceName: "Social")))
        print("oiiiii")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        print("btatacount")
        return item.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        print("create")
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        cell.imagem.image = item[indexPath.item].image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        //        print("You selected cell #\(indexPath.item)!")
        flag = true
        switch indexPath.item {
        case 0:
            performSegue(withIdentifier: "GameSA", sender: self)
        case 1:
            performSegue(withIdentifier: "GameLL", sender: self)
        case 2:
            performSegue(withIdentifier: "GameES", sender: self)
        default: break
            
        }
        
        // self.presentViewController(NPlayersViewController, animated: true, completion: nil)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue.identifier
        //let svc = segue.destination as! NPlayersViewController;
        
        
        
    }
    
    
}
