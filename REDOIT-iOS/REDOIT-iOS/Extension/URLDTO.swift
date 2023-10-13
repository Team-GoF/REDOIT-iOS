//
//  URLDTO.swift
//  REDOIT-iOS
//
//  Created by 강인혜 on 2023/10/13.
//

import Foundation

public struct URLDTO: Decodable {
    public let url: String

    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}
