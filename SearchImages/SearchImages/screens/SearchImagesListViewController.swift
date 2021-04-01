//
//  SearchImagesListViewController.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import UIKit

protocol SearchImagesListViewDelegate{
}

class SearchImagesListViewController: BaseViewController,  SearchImagesListPresenterDelegate{
    
    var interactor: SearchImagesListViewDelegate?
    var router: SearchImagesListRouter?
    
    override func settings() {
        super.settings()
        SearchImagesListConfigurator.shared.configure(vc: self)
        setTopBarLightContentStyle()
    }
    
    func showStartBusy() {
        showIndicator()
    }
    
    func showStopBusy() {
        hideIndicator()
    }
}

extension SearchImagesListViewController: ActivityIndicatorDelegate {
    func activityView() -> UIView {
        return self.view
    }
}
