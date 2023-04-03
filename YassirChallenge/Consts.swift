//
//  Consts.swift
//  YassirChallenge
//
//  Created by Walid Ahmed on 03/04/2023.
//

import Foundation
class Consts{

    // MARK:- Api Key
    static var API_KEY = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    static var baseURLForPosters = "https://image.tmdb.org/t/p/w500"


    // MARK:- Movies
    static var BASE_URL = "https://api.themoviedb.org/3/"
    static var Movies = BASE_URL + "discover/movie?api_key=\(API_KEY)"
    static var Movie_DETAILS = BASE_URL + "movie/"
    
}


