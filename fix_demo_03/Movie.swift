//
//  Movie.swift
//  fix_demo_03
//
//  Created by paul on 9/28/18.
//  Copyright © 2018 PoHung Wang. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var posterUrl: String
    
    var overview: String
    var backdropBathUrl: String
    var releaseDate: String
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        
        // Set the rest of the properties
        posterUrl = dictionary["poster_path"] as? String ?? "No poster"
        overview = dictionary["overview"] as? String ?? "No overview"
        backdropBathUrl = dictionary["backdrop_path"] as? String ?? "No background Image"
        releaseDate = dictionary["release_date"] as? String ?? "Release Date unknown"
    }
    
    
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
    
    
    
}


