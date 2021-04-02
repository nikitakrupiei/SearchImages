//
//  SearchImagesListPresenter.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import Foundation

protocol SearchImagesListPresenterDelegate: BasePresenterDelegate{
    func showImageUrls(urls: [URL])
    func showImageDetails(at position: Int)
    func showStartBusy()
    func showStopBusy()
}

class SearchImagesListPresenter: SearchImagesListInteractorDelegate {
    weak var viewController: SearchImagesListPresenterDelegate?
    
    func presentError(error: Error) {
        if let error = error as? APIError {
            viewController?.showError(message: error.local)
        }
    }
    
    func presentImageDetails(at indexPath: IndexPath) {
        viewController?.showImageDetails(at: indexPath.row)
    }
    
    func presentSearchTagResults(tagResults: TagSearchModel) {
        let urls = tagResults.response.compactMap({ response in
            response.photos?.map({ photo in
                photo.originalSize.url
            })
        }).flatMap({
            $0
        })
        
        viewController?.showImageUrls(urls: urls)
    }
    
    func presentStartBusy() {
        viewController?.showStartBusy()
    }
    
    func presentStopBusy() {
        viewController?.showStopBusy()
    }
}
