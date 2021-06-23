//
//  Districts.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 23/06/21.
//

import Foundation

// MARK: - Welcome
struct Districts: Codable {
    let districts: [District]
    let ttl: Int
}

// MARK: - District
struct District: Codable {
    let districtID: Int
    let districtName: String

    enum CodingKeys: String, CodingKey {
        case districtID = "district_id"
        case districtName = "district_name"
    }
}
