//
//  ViewController.swift
//  movies
//
//  Created by Gabriel Villarreal on 1/22/20.
//  Copyright © 2020 Gabriel Villarreal. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{

    var movies = [MovieObj]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addMovie(_ sender: Any) {
        let alert = UIAlertController(title: "Add Movie", message: "Wich movie doy like to add?", preferredStyle: .alert)
        
        let alertSave = UIAlertAction(title: "Save", style: .default) { (action) in
            //Save movie
            if let title = alert.textFields?.first?.text{
                self.saveMovie(title: title)
            }
            
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField { (textField) in
        }
        alert.addAction(alertSave)
        alert.addAction(alertCancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.movies = MovieObj.fetch()
        self.tableView.reloadData()
        
        DataProvider.shared.getMovies()
    }


}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let movie = self.movies[indexPath.row]
        
        cell!.textLabel?.text = movie.title
        return cell!
    }
}

// SaveMovies
extension MainViewController {
    
    private func saveMovie(title: String){
        let movie = MovieObj(title: title, rating: 0)
        movie.save()
        self.movies.append(movie)
        tableView.reloadData()
    }
    
    
}
