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
    func presentImageDetails(at indexPath: IndexPath)
    func presentStartBusy()
    func presentStopBusy()
}

class SearchImagesListInteractor: SearchImagesListViewDelegate{
    var presenter: SearchImagesListInteractorDelegate?
    
    /*
        It would be a great feature to make some pagination with limit and offset
        In documentation https://www.tumblr.com/docs/en/api/v2#tagged-method
        Unfortinatelly there is only limit of objects that I can get and no opportunity to skip objects I already downloaded
    */
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
    
    func didTapOnRow(at indexPath: IndexPath){
        presenter?.presentImageDetails(at: indexPath)
    }
}
