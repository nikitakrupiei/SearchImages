//
//  ActivityIndicatorUtils.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import Foundation
import UIKit

protocol ActivityIndicatorDelegate {
    func activityView() -> UIView
    func showIndicator()
    func hideIndicator()
}

extension ActivityIndicatorDelegate{
    
    func showIndicator(){
        let activityView = UIView()
        activityView.tag = 1
        
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 8
        container.layer.shadowColor = UIColor.gray.cgColor
        container.layer.shadowOffset = CGSize.zero
        container.layer.shadowOpacity = 0.75
        container.layer.shadowRadius = 5.0
        
        let side: CGFloat = 60
        container.widthAnchor.constraint(equalToConstant: side).isActive = true
        container.heightAnchor.constraint(equalToConstant: side).isActive = true
        
        activityView.addSubview(container)
        self.activityView().addSubview(activityView)
        
        activityView.translatesAutoresizingMaskIntoConstraints = false
        
        activityView.bottomAnchor.constraint(equalTo: self.activityView().safeAreaLayoutGuide.bottomAnchor).isActive = true
        activityView.topAnchor.constraint(equalTo: self.activityView().safeAreaLayoutGuide.topAnchor).isActive = true
        activityView.leadingAnchor.constraint(equalTo: self.activityView().safeAreaLayoutGuide.leadingAnchor).isActive = true
        activityView.trailingAnchor.constraint(equalTo: self.activityView().safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.centerXAnchor.constraint(equalTo: activityView.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: activityView.centerYAnchor).isActive = true
        
        let spinner = UIActivityIndicatorView(style: .gray)
        container.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.widthAnchor.constraint(equalToConstant: 40).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 40).isActive = true
        spinner.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        spinner.startAnimating()
    }
    
    func hideIndicator(){
        self.activityView().viewWithTag(1)?.removeFromSuperview()
    }
}
