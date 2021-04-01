//
//  BuildConfiguration.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import Foundation

class EnvironmentConfiguration {
    
    static var baseApiUrl : URL? {
        let baseUrl = "http://api.tumblr.com"
        return URL(string: baseUrl)
    }
    
    static var apiVersion: String? {
        return "/v2"
    }
}
