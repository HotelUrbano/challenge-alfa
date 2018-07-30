//
//  HotelUrbanoChallengeService.swift
//  HotelUrbanoChallenge
//
//  Created by maciosdev on 19/07/2018.
//  Copyright © 2018 Ronilson. All rights reserved.
//

import Foundation

final class HotelUrbanoService {
    
    func getHotels(success: @escaping (_ products: Hotels) -> Void, fail: @escaping (_ error: ServiceError) -> Void) {
        
        ServiceManager.shared.GetData(url: ServiceURL.hotels.value, parameters: nil, success: { result in
            let response = try! JSONDecoder().decode(Hotels.self, from: result)
            success(response)
        }, failure: { error in
            fail(ServiceError(code: error.code))
        })
    }

}
