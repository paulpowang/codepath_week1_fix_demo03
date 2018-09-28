//
//  DetailViewController.swift
//  fix_demo_03
//
//  Created by paul on 9/8/18.
//  Copyright © 2018 PoHung Wang. All rights reserved.
//

import UIKit


 //set repeatly use string as static value:
 enum MovieKeys{
    static let title = "title"
    static let posterPath = "poster_path"
 }
 //to call: MovieKeys.title will be equal to "title" for avoid miss spelling
 


class DetailViewController: UIViewController {

    @IBOutlet weak var backDropimageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let movie = movie{
            /*
            titleLabel.text = movie["title"] as? String
            releaseDateLabel.text = movie["release_date"] as? String
            overviewLabel.text = movie["overview"] as? String
            let backdropPathString = movie["backdrop_path"] as! String
            let posterPathString = movie[MovieKeys.posterPath] as! String
 */
            titleLabel.text = movie.title
            releaseDateLabel.text = movie.releaseDate
            overviewLabel.text = movie.overview
            let backdropPathString = movie.backdropBathUrl
            let posterPathString = movie.posterUrl
            
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let backdropURL = URL(string:baseURLString + backdropPathString)!
            backDropimageView.af_setImage(withURL: backdropURL)
            
            let posterPathURL = URL (string: baseURLString + posterPathString)!
            posterImageView.af_setImage(withURL: posterPathURL)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
