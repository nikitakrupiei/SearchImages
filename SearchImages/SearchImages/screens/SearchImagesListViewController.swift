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
    
    @IBOutlet var searchContainerView: UIView!{
        didSet{
            searchContainerView.layer.cornerRadius = 8
            searchContainerView.layer.borderWidth = 2
            searchContainerView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    @IBOutlet var searchTextField: UITextField!
    
    @IBOutlet var separatorView: UIView!{
        didSet{
            separatorView.backgroundColor = AppColor.separatorColor.color()
        }
    }
    
    @IBOutlet var searchButton: CornerButton!{
        didSet{
            searchButton.setTitle("Search", for: .normal)
            searchButton.backgroundColor = AppColor.mainAppColor.color()
        }
    }
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var noDataStack: UIStackView!
    
    @IBOutlet var noDataImage: UIImageView!{
        didSet{
            noDataImage.image = #imageLiteral(resourceName: "noImages")
        }
    }
    
    @IBOutlet var noDataTitle: UILabel!{
        didSet{
            noDataTitle.text = "Start searching images and you'll see them here!"
        }
    }
    
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
