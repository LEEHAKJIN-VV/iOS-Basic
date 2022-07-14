//
//  MovieInfo.swift
//  MyMovieChart
//
//  Created by 이학진 on 2022/07/14.
//

import Foundation

// MARK: - MovieInfo
struct MovieInfo: Codable {
    let hoppin: Hoppin
}

// MARK: - Hoppin
struct Hoppin: Codable {
    let totalCount: String
    let movies: Movies
}

// MARK: - Movies
struct Movies: Codable {
    let movie: [Movie]
}

// MARK: - Movie
struct Movie: Codable {
    let genreNames, genreIDS, title, movieID: String
    let linkURL: String
    let participant, ratingAverage: String
    let thumbnailImage: String

    enum CodingKeys: String, CodingKey {
        case genreNames
        case genreIDS = "genreIds"
        case title
        case movieID = "movieId"
        case linkURL = "linkUrl"
        case participant, ratingAverage, thumbnailImage
    }
}
