//
//  SearchImageDetailsConfigurator.swift
//  SearchImages
//
//  Created by Никита Крупей on 01.04.2021.
//

import Foundation

class SearchImageDetailsConfigurator{
    static let shared = SearchImageDetailsConfigurator()
    private init(){}
    
    func configure(vc: SearchImageDetailsViewController) {
        vc.router = SearchImageDetailsRouter(vc: vc)
        let interactor = SearchImageDetailsInteractor()
        let presenter = SearchImageDetailsPresenter()
        vc.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = vc
    }
}
