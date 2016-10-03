//
//  ViewController.swift
//  pokedex3
//
//  Created by QUICK APPS STUDIOS on 03/10/2016.
//  Copyright © 2016 QUICK APPS STUDIOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var pokemon = [Pokemon]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       collectionView.dataSource = self
        collectionView.delegate = self
        
        
        parsePokemonCSV()
        
        
        
       
    }
    
    
    func parsePokemonCSV() {
        
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            
         
         let csv = try CSV(contentsOfURL: path!)
            
      let rows = csv.rows
            
            print(rows)
            
            
            
            
            //for loop to get data
            
            for row in rows{
                
                
             let pokeId = Int(row["id"]!)
                
                let name = row["identifier"]
                
                
                
                //create an object called poke
                
                let poke = Pokemon(name: name!, pokedexId: pokeId!)
                
                ///append
                
                pokemon.append(poke)
                
            }
            
            
            
            
            
            
            
    
            //error
            
        } catch let err as NSError {
            
            
            print(err.debugDescription)
        }
        
            
    
}
        
        
    
    
    
    
    
    
    
    
    
    
    
    
    //cellforitem
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath)as? PokeCell{
            
            
            
         let poke = pokemon[indexPath.row]
            
            //sets our images from our object
            
            cell.configureCell(poke)
            
            
            
            
        
        return cell
        
        } else {
            
            
         return UICollectionViewCell()
            
            
        }
        
        
    }
    
    
    //didselect
   // func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // return 1
    //}
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    //size for item
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:105, height: 105)
        
    }


   

}

