//
//  AlphaNetworkManager.swift
//  Alpha
//
//  Created by Theo Mendes on 20/10/19.
//  Copyright © 2019 Hurb. All rights reserved.
//

import Foundation
import Moya
import RxMoya
import RxSwift

enum NetworkState {
    case Unit
    case Production
}

struct AlphaNetworkManager: AlphaAPI {
    private let provider: MoyaProvider<HurbAPI>

    init(state: NetworkState) {
        switch state {
        case .Unit:
            provider = MoyaProvider<HurbAPI>(stubClosure: MoyaProvider.immediatelyStub)
        case .Production:
            provider = MoyaProvider<HurbAPI>(plugins: [NetworkLoggerPlugin()])
        }
    }

    func search(query: String, page: Int) -> Single<HurbResponse> {
        return provider.rx
            .request(.search(query: query, page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(HurbResponse.self)
    }
}
