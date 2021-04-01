//
//  SearchImageDetailsPresenter.swift
//  SearchImages
//
//  Created by Никита Крупей on 01.04.2021.
//

import Foundation

protocol SearchImageDetailsPresenterDelegate: BasePresenterDelegate{
    func showStartBusy()
    func showStopBusy()
}

class SearchImageDetailsPresenter: SearchImageDetailsInteractorDelegate {
    weak var viewController: SearchImageDetailsPresenterDelegate?
    
    func presentError(error: Error) {
        if let error = error as? APIError {
            viewController?.showError(message: error.local)
        }
    }
    
    func presentStartBusy() {
        delegate?.showStartBusy()
    }
    
    func presentStopBusy() {
        delegate?.showStopBusy()
    }
}
