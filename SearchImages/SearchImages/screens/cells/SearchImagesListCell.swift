//
//  SearchImagesListCell.swift
//  SearchImages
//
//  Created by Никита Крупей on 01.04.2021.
//

import UIKit

class SearchImagesListCell: UITableViewCell {

    static let reusableIdentifier = "SearchImagesListCell"
    
    @IBOutlet weak var searchImageView: NetworkLoadImage!
    
    func loadImage(url: URL, completion: @escaping(_ downloadedImage: UIImage?, _ cashedImage: UIImage?) -> Void) {
        searchImageView.setImage(url: url, completion: completion)
    }
}
