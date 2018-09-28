//
//  NowPlayingViewController.swift
//  fix_demo_03
//
//  Created by paul on 9/3/18.
//  Copyright © 2018 PoHung Wang. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    //change to Movie class here
    //var movies: [[String:Any]] = []
    var movies: [Movie] = []
    var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityindicator.startAnimating()
        
        //refresh view
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50

        // Do any additional setup after loading the view.
        
        fectchMovies()
        
    }
    
    func wifiAlarm (title: String = "Cannot Get Movies" , message:String = "The Internet connetion appears to be offline."){
        let alertController = UIAlertController(title: title, message: message
            , preferredStyle: UIAlertControllerStyle.alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default){(action) in
            self.fectchMovies()
        }
        alertController.addAction(dismissAction)
        
        self.present(alertController, animated: true){
            //exit(0)
            
            self.activityindicator.stopAnimating()
            
        }

    }
    
    
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fectchMovies()
    }
    /*
    func fectchMovies(){
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error{
                print(error.localizedDescription)
                self.wifiAlarm()
            }else if let data = data {
                /*
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String:Any]]
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityindicator.stopAnimating()
 */
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                self.movies = []
                for dictionary in movieDictionaries {
                    let movie = Movie(dictionary: dictionary)
                    self.movies.append(movie)
                }
                
            }
        }
        task.resume()
    }*/
    
    func fectchMovies(){
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityindicator.stopAnimating()
            }else if let error = error{
                print(error.localizedDescription)
                self.wifiAlarm()
            }
        }
    }
 
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    /*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        
        let posterURL = URL(string: baseURLString + posterPathString)!
        cell.posterimageView.af_setImage(withURL: posterURL)
        
        return cell
    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.movie = movies[indexPath.row]
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
