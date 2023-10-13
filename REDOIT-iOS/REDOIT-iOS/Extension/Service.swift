//
//  Service.swift
//  REDOIT-iOS
//
//  Created by 강인혜 on 2023/10/12.
//

import Foundation
import Moya
import Combine

final class Service: BaseRemoteDataSource<API> {
    public func uploadInput(_ data: Data, _ prompt: String) -> AnyPublisher<String, Error> {
        request(.uploadInput(data: data, prompt: prompt), dto: URLDTO.self)
            .map(\.url)
            .eraseToAnyPublisher()
    }
}
