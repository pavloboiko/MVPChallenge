//
//  MovieListService.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//


import Foundation


typealias UpcomingMovieResponse = (Result<UpcomingMovies,NetworkError>) -> Void

/// Movie List Service  Protocol
protocol MovieListService {
    func fetchMovies(forPage page: Int, withCompletion: @escaping (UpcomingMovieResponse) )
}

/// Movie List Service  Protocol Implementation
class MovieListServiceImpl: MovieListService {
        
    /// Properties
    let translationLayer: TranslationLayer
    let networkManager: Networking
    
    /// Init
    init(translationLayer: TranslationLayer = JSONTranslation(), networkManager: Networking = NetworkManager() ) {
        self.translationLayer = translationLayer
        self.networkManager = networkManager
    }
    
    /// Method
    func fetchMovies(forPage page: Int, withCompletion: @escaping (UpcomingMovieResponse) ) {
        
        let endPoint = Endpoint(method: .get, route: APIConstants.MovieListAPIRoute ,parameters:["api_key": Keys.APIKey,"language": "en-US","page": "\(page)"])
        
        networkManager.request(endPoint) { [weak self] (result) in
           
            switch result {
            case .success(let data):
                do {
                    guard let self = self else { return }
                    
                    let upcomingMovies: UpcomingMovies = try self.translationLayer.translateToObject(withData: data)
                    withCompletion(.success(upcomingMovies))
                    
                } catch {
                    withCompletion(.failure(NetworkError.decoding(error)))
                    
                }
                
            case .failure(let error):
                withCompletion(.failure(error))
            }
        }
    }
    
}
