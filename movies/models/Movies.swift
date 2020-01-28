//
//  Movies.swift
//  movies
//
//  Created by Gabriel Villarreal on 1/24/20.
//  Copyright © 2020 Gabriel Villarreal. All rights reserved.
//

import Foundation
import CoreData
import UIKit





class MovieObj {
    
    var title: String
    var rating: Int
    var popularity : Double
    var vote_count : Int
    var video : Bool
    var poster_path : String
    var id : Int
    var adult : Bool
    var backdrop_path : String
    var original_language : String
    var original_title : String
    var vote_average : Int
    var overview : String
    var release_date : Date!
    
    
    
    
    init() {
        self.title = ""
        self.rating = 0
        self.popularity = 0
        self.vote_count = 0
        self.video = false
        self.poster_path = ""
        self.id = 0
        self.adult = false
        self.backdrop_path = ""
        self.original_language = ""
        self.original_title = ""
        self.vote_average = 0
        self.overview = ""
        self.release_date = nil
    }
    
    convenience init(title: String,rating: Int){
        self.init()
        self.title = title
        self.rating = rating
    }
    
    convenience init(object: [String:Any]){
        self.init()
        self.title = object["title"] as? String ?? ""
        self.rating = object["rating"] as? Int ?? 0
        self.popularity = object["popularity"] as? Double ?? 0
        self.vote_count = object["vote_count"] as? Int ?? 0
        self.video = object["video"] as? Bool ?? false
        self.poster_path = object["poster_path"] as? String ?? ""
        self.id = object["id"] as? Int ?? 0
        self.adult = object["adult"] as? Bool ?? false
        self.backdrop_path = object["backdrop_path"] as? String ?? ""
        self.original_language = object["original_language"] as? String ?? ""
        self.original_title = object["original_title"] as? String ?? ""
        self.vote_average = object["vote_average"] as? Int ?? 0
        self.overview = object["overview"] as? String ?? ""
        self.release_date = nil
    }
    
    
    
    func save(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)
        let movie = NSManagedObject(entity: entity!, insertInto: context)
        
        movie.setValue(self.title, forKey: "title")
        movie.setValue(self.rating, forKey: "rating")
        
        do {
            try context.save()
            print("Movie \(self.title) saved")
        } catch let error as NSError{
            print("Save movie fail : \(error), \(error.userInfo)")
        }
        
    }
    
    static func fetch() -> [MovieObj] {
        var savedMovies = [MovieObj]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        
        do {
            let result = try context.fetch(fetchRequest)
            if let movies = result as? [NSManagedObject]{
                for movie in movies {
                    savedMovies.append(MovieObj(title: movie.value(forKey: "title") as! String, rating: movie.value(forKey: "rating") as! Int))
                }
            }
        }catch let error as NSError{
            print("Fetch movie fail : \(error), \(error.userInfo)")
        }
        return savedMovies
    }
    
    
}



