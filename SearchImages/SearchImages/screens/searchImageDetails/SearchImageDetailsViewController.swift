//
//  SearchImageDetailsViewController.swift
//  SearchImages
//
//  Created by Никита Крупей on 01.04.2021.
//

import UIKit

protocol SearchImageDetailsViewDelegate{
}

class SearchImageDetailsViewController: BaseViewController,  SearchImageDetailsPresenterDelegate{
    
    var interactor: SearchImageDetailsViewDelegate?
    var router: SearchImageDetailsRouter?
    
    var imageURL: URL?
    
    @IBOutlet weak var searchImageView: NetworkLoadImage!{
        didSet{
            searchImageView.imgUrl = imageURL
        }
    }
    
    override func settings() {
        super.settings()
        SearchImageDetailsConfigurator.shared.configure(vc: self)
        setTopBarLightContentStyle()
    }
    
    func showStartBusy() {
        showIndicator()
    }
    
    func showStopBusy() {
        hideIndicator()
    }
}

extension SearchImageDetailsViewController: ActivityIndicatorDelegate {
    func activityView() -> UIView {
        return self.view
    }
}
