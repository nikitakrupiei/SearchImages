//
//  SearchImagesListRouter.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import Foundation
import UIKit

class SearchImagesListRouter{
    
    unowned var vc: SearchImagesListViewController
    
    init(vc: SearchImagesListViewController) {
        self.vc = vc
    }
    
    func navigateToImageDetails(imageUrl: URL) {
        vc.performSegue(withIdentifier: Segue.navigateToImageDetails.rawValue, sender: imageUrl)
    }
    
    func passDataToNextScene(segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == Segue.navigateToImageDetails.rawValue, let destination = segue.destination as? SearchImageDetailsViewController {
            destination.imageURL = sender as? URL
        }
    }
    
    enum Segue: String {
        case navigateToImageDetails
    }
}
