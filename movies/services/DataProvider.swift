//
//  DataProvider.swift
//  movies
//
//  Created by Gabriel Villarreal on 1/22/20.
//  Copyright © 2020 Gabriel Villarreal. All rights reserved.
//

import Foundation
import Alamofire



/*
 *
 *  Pendientes Observable de la funcion get movies?
 *
 *  Poblar tabla
 *
 *
*/








class DataProvider : NSObject{
    
    static let shared = DataProvider()
    private let url : URL
    
    
    
    func getMovies(){
        
        var urlRequest = URLRequest(url: url)
               urlRequest.timeoutInterval = 40
               
             
        urlRequest.httpMethod = "GET"
        
        SessionManager.default.request(urlRequest).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                print("Success :", value)
                
            case .failure(let error):
                print("Fail: ",error.localizedDescription)
            }
        }
        
    }
    
    
    
    override init() {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/discover/movie"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: "f9d0c4746bc06c64de6cf84f17bd73ed"),
            URLQueryItem(name: "sort_by", value: "popularity.desc")
        ]

        self.url = components.url!
        
    }
}

