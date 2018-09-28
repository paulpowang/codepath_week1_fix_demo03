//
//  MovieCell.swift
//  fix_demo_03
//
//  Created by paul on 9/3/18.
//  Copyright © 2018 PoHung Wang. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterimageView: UIImageView!
    
    var movie: Movie! {
        didSet{
            let title = movie.title
            let overview = movie.overview
            let imagePath = movie.posterUrl
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let imageUrl = URL(string: baseURLString + imagePath)!
            titleLabel.text = title
            overviewLabel.text = overview
            posterimageView.af_setImage(withURL: imageUrl)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
