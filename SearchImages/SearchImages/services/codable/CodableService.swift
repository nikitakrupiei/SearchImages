//
//  CodableService.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import Foundation

// Manager to decode Data in correct Decodable model
class DecodableService {
    
    static let shared = DecodableService()
    private init() {}
    
    func decodeOne<Entity: Decodable>(data: Data, success:@escaping((Entity)->()), fail:@escaping((Error)->())){
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(Entity.self, from: data)
            success(result)
        } catch {
            fail(APIError.DecodeDataError(message: error.localizedDescription))
        }
    }
}
