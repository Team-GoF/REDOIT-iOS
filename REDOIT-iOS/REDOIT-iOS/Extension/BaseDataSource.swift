//
//  BaseDataSource.swift
//  REDOIT-iOS
//
//  Created by 강인혜 on 2023/10/13.
//

import Combine
import Foundation
import Moya

open class BaseRemoteDataSource<API: BaseAPI> {
    private let provider: MoyaProvider<API>
    private let decoder = JSONDecoder()
    private let maxRetryCount = 2

    public init(
        provider: MoyaProvider<API>? = nil
    ) {
        self.provider = provider ?? MoyaProvider(plugins: [MoyaLogginPlugin()])
    }

    public func request<T: Decodable>(_ api: API, dto: T.Type) -> AnyPublisher<T, Error> {
        requestPublisher(api)
            .map(\.data)
            .decode(type: dto, decoder: decoder)
            .eraseToAnyPublisher()
    }

    public func request(_ api: API) -> AnyPublisher<Void, Error> {
        requestPublisher(api)
            .map { _ in return }
            .eraseToAnyPublisher()
    }

    private func requestPublisher(_ api: API) -> AnyPublisher<Response, Error> {
        return defaultRequest(api)
    }
}

private extension BaseRemoteDataSource {
    func defaultRequest(_ api: API) -> AnyPublisher<Response, Error> {
        provider.requestPublisher(api, callbackQueue: .main)
            .retry(maxRetryCount)
            .timeout(45, scheduler: DispatchQueue.main)
            .mapError { api.errorMap[$0.response?.statusCode ?? 0] ?? $0 as Error }
            .eraseToAnyPublisher()
    }
}

