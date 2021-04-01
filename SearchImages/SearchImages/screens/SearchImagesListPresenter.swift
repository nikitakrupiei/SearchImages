//
//  SearchImagesListPresenter.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import Foundation

protocol SearchImagesListPresenterDelegate: BasePresenterDelegate{
    func showStartBusy()
    func showStopBusy()
}

class SearchImagesListPresenter: SearchImagesListInteractorDelegate {
    weak var viewController: SearchImagesListPresenterDelegate?
    
    func presentError(error: Error) {
    }
    
    func presentStartBusy() {
        viewController?.showStartBusy()
    }
    
    func presentStopBusy() {
        viewController?.showStopBusy()
    }
}
