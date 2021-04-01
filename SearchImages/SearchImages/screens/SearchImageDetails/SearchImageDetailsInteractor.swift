//
//  SearchImageDetailsInteractor.swift
//  SearchImages
//
//  Created by Никита Крупей on 01.04.2021.
//

import Foundation

protocol SearchImageDetailsInteractorDelegate{
    func presentError(error: Error)
    func presentStartBusy()
    func presentStopBusy()
}

class SearchImageDetailsInteractor: SearchImageDetailsViewDelegate{
    var presenter: SearchImageDetailsInteractorDelegate?
}
