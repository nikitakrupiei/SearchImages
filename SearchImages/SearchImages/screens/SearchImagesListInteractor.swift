//
//  SearchImagesListInteractor.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import Foundation

protocol SearchImagesListInteractorDelegate{
    func presentError(error: Error)
    func presentSearchTagResults(tagResults: TagSearchModel)
    func presentStartBusy()
    func presentStopBusy()
}

class SearchImagesListInteractor: SearchImagesListViewDelegate{
    var presenter: SearchImagesListInteractorDelegate?
    
    func didFinishSearch(with text: String) {
        presenter?.presentStartBusy()
        SearchService.shared.searchImages(by: text) { [self] searchTagResults in
            presenter?.presentStopBusy()
            presenter?.presentSearchTagResults(tagResults: searchTagResults)
        } fail: { [self] error in
            presenter?.presentStopBusy()
            presenter?.presentError(error: error)
        }
    }
    
}
