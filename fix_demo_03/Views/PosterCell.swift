//
//  PosterCell.swift
//  fix_demo_03
//
//  Created by paul on 9/8/18.
//  Copyright © 2018 PoHung Wang. All rights reserved.
//

import UIKit
import Alamofire

class PosterCell: UICollectionViewCell {
    
    @IBOutlet weak var posterimageView: UIImageView!
    
    var movie: Movie! {
        didSet{
            
            let imagePath = movie.posterUrl
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let imageUrl = URL(string: baseURLString + imagePath)!
            
            posterimageView.af_setImage(withURL: imageUrl)
        }
    }
 
}
