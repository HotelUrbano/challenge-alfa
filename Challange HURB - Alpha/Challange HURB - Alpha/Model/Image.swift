//
//  Image.swift
//  Challange HURB - Alpha
//
//  Created by Luiz Fernando Cunha Duarte on 28/10/19.
//  Copyright © 2019 Luiz Fernando Cunha Duarte. All rights reserved.
//

import Foundation

struct Image: Codable {
    var url: URL
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case url
        case description
    }
}
