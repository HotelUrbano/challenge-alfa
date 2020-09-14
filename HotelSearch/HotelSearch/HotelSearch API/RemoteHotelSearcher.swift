//
//  RemoteHotelSearcher.swift
//  HotelSearch
//
//  Created by Tulio Parreiras on 14/09/20.
//  Copyright © 2020 Tulio Parreiras. All rights reserved.
//

import Foundation

final public class RemoteHotelSearcher: HotelSearcher {
    
    public typealias SearchResult = HotelSearcher.SearchResult
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func searchHotel(with searchText: String, completion: @escaping (RemoteHotelSearcher.SearchResult) -> Void) {
        self.client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                completion(Result {
                    try HotelMapper.map(data, from: response)
                })
            case .failure:
                completion(.failure(RemoteHotelSearcher.Error.connectivity))
            }
        }
    }
    
}
