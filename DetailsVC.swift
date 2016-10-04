//
//  DetailsVC.swift
//  pokedex3
//
//  Created by QUICK APPS STUDIOS on 04/10/2016.
//  Copyright © 2016 QUICK APPS STUDIOS. All rights reserved.
//

import UIKit




class DetailsVC: UIViewController {
    
    
    @IBOutlet weak var nameLbl: UILabel!
    
    
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

       
        
       nameLbl.text = pokemon.name
        
        
        
        
    }

    

    
}
