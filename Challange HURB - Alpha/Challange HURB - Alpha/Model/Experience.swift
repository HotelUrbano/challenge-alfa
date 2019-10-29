//
//  Experiences.swift
//  Challange HURB - Alpha
//
//  Created by Luiz Fernando Cunha Duarte on 28/10/19.
//  Copyright © 2019 Luiz Fernando Cunha Duarte. All rights reserved.
//

import Foundation

struct Experience: Codable {
    
    // MARK: - General attributes
    var id: String
    var name: String
    var adress: Adress
    var smallDescription: String
    var completeDescription: String
    var url: URL
    var category: String
    var stars: Int?
    var image: URL?
    var gallery: [Image]
    var price: [Price]
    var hasFreeCancellation: Bool?
    
    // MARK: - Specific attributes
    
    var isPackage: Bool?
    var isHotel: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "sku"
        case name
        case adress
        case smallDescription
        case completeDescription = "description"
        case url
        case category
        case stars
        case image
        case gallery
        case price
        case hasFreeCancellation = "hu_free_cancellation"
        case isHotel
        case isPackage
    }
    
}
