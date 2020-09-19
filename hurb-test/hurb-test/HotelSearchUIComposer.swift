//
//  HotelSearchUIComposer.swift
//  hurb-test
//
//  Created by Tulio Parreiras on 19/09/20.
//  Copyright © 2020 Tulio Parreiras. All rights reserved.
//

import Foundation

import HotelSearch
import HotelSearchiOS

final class HotelSearchUIComposer {
    
    private init() { }
    
    static func hotelSearchComposedWith(hotelSearcher: HotelSearcher, imageDataLoader: ImageDataLoader) -> HotelSearchViewController {
        let viewModel = HotelSearchViewModel(hotelSearcher: hotelSearcher, imageDataLoader: imageDataLoader)
        let controller = HotelSearchViewController(viewModel: viewModel)
        viewModel.hotelSearchView = controller
        return controller
    }
}
