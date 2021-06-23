//
//  States.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 23/06/21.
//

import Foundation

// MARK: - Welcome
struct States: Codable {
    let states: [State]
    let ttl: Int
}

// MARK: - State
struct State: Codable {
    let stateID: Int
    let stateName: String

    enum CodingKeys: String, CodingKey {
        case stateID = "state_id"
        case stateName = "state_name"
    }
}
