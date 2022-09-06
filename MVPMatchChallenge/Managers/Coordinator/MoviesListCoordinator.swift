//
//  MoviesListCoordinator.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//

import Foundation
import UIKit

/// Movie list coordinator protocol
protocol MoviesListCoordinator {
    func navigateToMovieDetail(withMovie movie: Movie?)
}

/// Protocol implementation of movies list coordinator
class MoviesListCoordinatorImpl: MoviesListCoordinator {
    weak var view: UIViewController?
    
    init(view: UIViewController?) {
        self.view = view
    }
}

extension MoviesListCoordinatorImpl {
    
    func navigateToMovieDetail(withMovie movie: Movie?) {
        let detailController = SceneFactory.shared().getScene(sceneType: .MovieDetail, withMovie: movie)
        view?.navigationController?.pushViewController(detailController, animated: true)
    }
}
