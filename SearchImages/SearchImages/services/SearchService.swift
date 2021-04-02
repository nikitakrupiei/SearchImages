//
//  SearchService.swift
//  SearchImages
//
//  Created by Никита Крупей on 01.04.2021.
//

import Foundation

// Service for concrete screens. There can be many of them, They use APIConfigurator and used by interactors
class SearchService {
    
    static let shared = SearchService()
    private init() {}
    
    func searchImages(by tag: String, success:@escaping((TagSearchModel) -> Void), fail:@escaping((Error) -> Void)){
        SearchServiceEndpoint.searchWith(tag: tag).decodeOne(success: success, fail: fail)
    }
}

fileprivate enum SearchServiceEndpoint: APIConfigurator {
    case searchWith(tag: String)
    
    var method: HTTPMethod{
        switch self {
        case .searchWith:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .searchWith:
            return "tagged"
        }
    }
    
    var query: Parameters?{
        switch self {
        case .searchWith(let tag):
            return [QueryKey.apiKey.rawValue: EnvironmentConfiguration.shared.apiKey, QueryKey.tag.rawValue: tag]
        }
    }
}

fileprivate enum QueryKey: String {
    case tag = "tag"
    case apiKey = "api_key"
}
