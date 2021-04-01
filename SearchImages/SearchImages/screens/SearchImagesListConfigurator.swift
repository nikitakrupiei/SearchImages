//
//  SearchImagesListConfigurator.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import Foundation

class SearchImagesListConfigurator{
    static let shared = SearchImagesListConfigurator()
    private init(){}
    
    func configure(vc: SearchImagesListViewController) {
        vc.router = SearchImagesListRouter(vc: vc)
        let interactor = SearchImagesListInteractor()
        let presenter = SearchImagesListPresenter()
        vc.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = vc
    }
}
