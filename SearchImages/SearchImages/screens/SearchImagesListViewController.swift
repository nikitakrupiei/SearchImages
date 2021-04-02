//
//  SearchImagesListViewController.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import UIKit

protocol SearchImagesListViewDelegate{
    func didFinishSearch(with text: String)
    func didTapOnRow(at indexPath: IndexPath)
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
    
    var isTableViewEmpty: Bool {
        self.imageURLs.count == 0
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
            noDataStack.isHidden = !isTableViewEmpty
            noDataStack.alpha = isTableViewEmpty ? 1 : 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        router?.passDataToNextScene(segue: segue, sender: sender)
    }
    
    func showImageDetails(at position: Int) {
        router?.navigateToImageDetails(imageUrl: imageURLs[position])
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
        
        if !isTableViewEmpty {
            let topRow = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: topRow, at: .top, animated: true)
        }
        self.searchTextField.resignFirstResponder()
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
        cell.selectionStyle = .none
        
        cell.loadImage(url: imageURLs[indexPath.row]) { (downLoadedImage, _) in
            if let _ = downLoadedImage {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didTapOnRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let paddings: CGFloat = 20
        let defaultWidth: CGFloat = 300
        
        let url = imageURLs[indexPath.row]
        
        if let imageCache = imageCache.object(forKey: url as NSURL)?.image {
            return (imageCache.size.height * defaultWidth / imageCache.size.width) + paddings
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
}

extension SearchImagesListViewController: ActivityIndicatorDelegate {
    func activityView() -> UIView {
        return self.view
    }
}
