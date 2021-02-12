//
//  Movie.swift
//  BestMovie
//
//  Created by Artem Kedrov on 10.02.2021.
//

import Foundation
import UIKit

class List<T: Codable>: Codable {
  var page: Int?
  var results: [T]?
  var totalPages, totalResults: Int?

  enum CodingKeys: String, CodingKey {
    case page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }

  init(page: Int?, results: [T]?, totalPages: Int?, totalResults: Int?) {
    self.page = page
    self.results = results
    self.totalPages = totalPages
    self.totalResults = totalResults
  }
}

// MARK: - Result

class Movie: Codable {
  var adult: Bool?
  var backdropPath: String?
  var genreIDS: [Int]?
  var id: Int
  var originalLanguage: String?
  var originalTitle, overview: String?
  var popularity: Double?
  var posterPath, releaseDate, title: String?
  var video: Bool?
  var voteAverage: Double?
  var voteCount: Int?

  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case genreIDS = "genre_ids"
    case id
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview, popularity
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title, video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }

  init(adult: Bool?, backdropPath: String?, genreIDS: [Int]?, id: Int, originalLanguage: String?, originalTitle: String?, overview: String?, popularity: Double?, posterPath: String?, releaseDate: String?, title: String?, video: Bool?, voteAverage: Double?, voteCount: Int?) {
    self.adult = adult
    self.backdropPath = backdropPath
    self.genreIDS = genreIDS
    self.id = id
    self.originalLanguage = originalLanguage
    self.originalTitle = originalTitle
    self.overview = overview
    self.popularity = popularity
    self.posterPath = posterPath
    self.releaseDate = releaseDate
    self.title = title
    self.video = video
    self.voteAverage = voteAverage
    self.voteCount = voteCount
  }
}

extension Movie: PosterCellRepresentable {
  var imagePath: String {
    get {
      "https://image.tmdb.org/t/p/original\(posterPath.empty)"
    }
  }
}
