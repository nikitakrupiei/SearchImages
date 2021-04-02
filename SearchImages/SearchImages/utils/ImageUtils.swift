//
//  ImageUtils.swift
//  SearchImages
//
//  Created by Никита Крупей on 01.04.2021.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

// ImageView for downloading image from URL
class NetworkLoadImage: UIImageView {
    var imgUrl: URL?
    
    var spinner: UIActivityIndicatorView?
    
    func setImage(url: URL, completion: ((_ downloadedImage: UIImage?, _ cashedImage: UIImage?) -> Void)? = nil) {
        self.imgUrl = url
        
        self.image = nil
        
        if let imageCache = imageCache.object(forKey: url as NSURL) as? UIImage {
            completion?(nil, imageCache)
            self.image = imageCache
            return
        }
        
        spinner?.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            let imgData = try? Data.init(contentsOf: url)
            
            DispatchQueue.main.async {
                
                self.spinner?.stopAnimating()
                
                guard let imgData = imgData, let image = UIImage(data: imgData) else {
                    return
                }
                
                imageCache.setObject(image, forKey: url as NSURL)
                
                //check if we are on the correct reusable cell
                if url == self.imgUrl {
                    completion?(image, nil)
                    
                    //this set causes jumping effect from one width to another, so I left only presentation of cashed images
                    //self.image = image
                }
            }
        }
    }
    
    private func addSpinner() {
        guard spinner == nil else {
            return
        }
        
        spinner = UIActivityIndicatorView()
        
        guard let spinner = spinner else {
            return
        }
        self.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSpinner()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSpinner()
    }
}
