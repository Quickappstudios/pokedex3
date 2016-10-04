//
//  ViewController.swift
//  pokedex3
//
//  Created by QUICK APPS STUDIOS on 03/10/2016.
//  Copyright © 2016 QUICK APPS STUDIOS. All rights reserved.
//

import UIKit

import AVFoundation

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    
    
    var pokemon = [Pokemon]()
    
    var musicPlayer:AVAudioPlayer!
    
    var filteredPokemon = [Pokemon]()
    
    var inSearchMode = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       collectionView.dataSource = self
        collectionView.delegate = self
        
        searchbar.delegate = self
        
        
        
        //dissmiss when done key is pressed on keybaoard
        
        searchbar.returnKeyType = UIReturnKeyType.done
        
        
        parsePokemonCSV()
        readyAudio()
        
        
       
    }
    
    
    
    
    func readyAudio() {
        
      let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do {
            
           musicPlayer = try AVAudioPlayer(contentsOf:URL(string:path!)!)
            
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
            
        }catch let err as NSError{
            
            
            print(err.debugDescription)
        }
        
        
        
        
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
            
            
            let poke: Pokemon!
            
            if inSearchMode {
                
              
                poke = filteredPokemon[indexPath.row]
                
                cell.configureCell(poke)
                
                
                
                
                
            }else{
        
                poke = pokemon[indexPath.row]
                
                cell.configureCell(poke)
            
           
            
            }
            
            
        
        return cell
        
        } else {
            
            
         return UICollectionViewCell()
            
            
        }
        
        
    }
    
    
    //didselect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        var poke: Pokemon!
        
        if inSearchMode{
            
            
            poke = filteredPokemon[indexPath.row]
            
            
        }else{
            
            poke = pokemon[indexPath.row]
        }
        
        
        
        ///preform segue
       performSegue(withIdentifier: "PokemonDetailsVc", sender: poke)
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        if inSearchMode{
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    //size for item
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:105, height: 105)
        
    }
    
    
    
    ///musicbuttonpressed

    @IBAction func musicbuttonPressed(_ sender: UIButton) {
        
        
        if musicPlayer.isPlaying{
            
            
            musicPlayer.pause()
            
            sender.alpha = 0.2
            
        }else {
            
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }
    
    
    
    //searchbar

    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
            
        } else {
            
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            collectionView.reloadData()
            
        }
        
    }
        
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "PokemonDetailsVc"{
            
            
            if let detailsVC = segue.destination as? DetailsVC{
                
                
                if let poke = sender as? Pokemon {
                    
                 detailsVC.pokemon = poke
                    
                    
                }
                }
                
                
                
            }
            
            
            
            
            
        }
        
    }
                
                
    

        
        
        
        
        


   



