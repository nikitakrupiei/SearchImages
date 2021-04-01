//
//  ImageUtils.swift
//  SearchImages
//
//  Created by Никита Крупей on 01.04.2021.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class NetworkLoadImage: UIImageView {
    var imgUrl: URL? {
        didSet{
            setImage()
        }
    }
    
    var spinner: UIActivityIndicatorView?
    
    func setImage() {
        guard let url = imgUrl else {
            return
        }
        
        self.image = nil
        
        if let imageCache = imageCache.object(forKey: url as NSURL) as? UIImage {
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
                
                if url == self.imgUrl {
                    self.image = image
                }
            }
        }
    }
    
    func addSpinner() {
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
