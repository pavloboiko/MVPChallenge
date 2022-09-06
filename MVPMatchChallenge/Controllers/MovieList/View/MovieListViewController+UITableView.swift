//
//  MovieListViewController+UITableView.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//

import UIKit

extension MovieListViewController : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movieListCell: MovieListTableViewCell  = tableView.dequeueReusableCell(for: indexPath)
        let cellViewModel = viewModel.getMovieListCellViewModel(index: indexPath.row)
        movieListCell.populateWithViewModel(cellViewModel: cellViewModel)
        return movieListCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectMovie(index: indexPath.row)
    }
}

extension MovieListViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.isAtBottom() {
            viewModel.tableViewDidReachToEnd()
        }
    }
}
