//
//  PokeCell.swift
//  pokedex3
//
//  Created by QUICK APPS STUDIOS on 03/10/2016.
//  Copyright © 2016 QUICK APPS STUDIOS. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    
    @IBOutlet weak var thumbImg: UIImageView!
    
    
    
    @IBOutlet weak var nameLbl: UILabel!
    
    
    //create object of our array from model data
    var pokemon:Pokemon!
    
    
    // create rounded corners on cell
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        
      layer.cornerRadius = 5.0
        
        
        
    }
    
    
    
    
    
    //configurecell
    
    func configureCell(_ pokemon:Pokemon) {
        
      self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
        
        
        
        
        
    }
    
    
    
}
