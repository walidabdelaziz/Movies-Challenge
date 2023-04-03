//
//  Movies.swift
//  YassirChallenge
//
//  Created by Walid Ahmed on 03/04/2023.
//

import Foundation

struct MoviesModel: Codable {
    var page: Int?
    var results: [Movies]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movies: Codable {
    var id: Int?
    var originalTitle, overview: String?
    var posterPath, releaseDate, title,backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}
