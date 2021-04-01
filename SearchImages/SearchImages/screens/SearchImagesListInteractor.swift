//
//  SearchImagesListInteractor.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import Foundation

protocol SearchImagesListInteractorDelegate{
    func presentError(error: Error)
    func presentStartBusy()
    func presentStopBusy()
}

class SearchImagesListInteractor: SearchImagesListViewDelegate{
    var presenter: SearchImagesListInteractorDelegate?
}
