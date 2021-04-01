//
//  SearchImagesListViewController.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import UIKit

protocol SearchImagesListViewDelegate{
    func didFinishSearch(with text: String)
}

class SearchImagesListViewController: BaseViewController,  SearchImagesListPresenterDelegate{
    
    var interactor: SearchImagesListViewDelegate?
    var router: SearchImagesListRouter?
    
    var imageURLs: [URL] = []{
        didSet{
            tableView.reloadData()
            handleNoData()
        }
    }
    
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
            noDataTitle.text = "Oops.. Nothing was found. Try searching for other tag"
        }
    }
    
    override func settings() {
        super.settings()
        SearchImagesListConfigurator.shared.configure(vc: self)
        setTopBarLightContentStyle()
        title = "Tag search"
    }
    
    func handleNoData() {
        UIView.animate(withDuration: 0.5) { [self] in
            noDataStack.isHidden = imageURLs.count != 0
            noDataStack.alpha = imageURLs.count == 0 ? 1 : 0
        }
    }
    
    func showImageUrls(urls: [URL]){
        imageURLs = urls
    }
    
    func showStartBusy() {
        showIndicator()
    }
    
    func showStopBusy() {
        hideIndicator()
    }
    
    @IBAction func didTapSearchButton(_ sender: Any) {
        guard let text = searchTextField.text, !text.isEmpty else{
            searchContainerView.shake()
            return
        }
        interactor?.didFinishSearch(with: text)
    }
}

extension SearchImagesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchImagesListCell.reusableIdentifier, for: indexPath) as? SearchImagesListCell else {
            return UITableViewCell()
        }
        cell.searchImageView.imgUrl = imageURLs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchImagesListViewController: ActivityIndicatorDelegate {
    func activityView() -> UIView {
        return self.view
    }
}
