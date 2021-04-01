//
//  BuildConfiguration.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import Foundation

class EnvironmentConfiguration {
    
    static let shared = EnvironmentConfiguration()
    private init() {}
    
    var baseApiUrl : URL? {
        let baseUrl = "http://api.tumblr.com"
        return URL(string: baseUrl)
    }
    
    var apiVersion: String? {
        return "/v2"
    }
    
    var apiKey: String {
        return "CcEqqSrYdQ5qTHFWssSMof4tPZ89sfx6AXYNQ4eoXHMgPJE03U"
    }
}
