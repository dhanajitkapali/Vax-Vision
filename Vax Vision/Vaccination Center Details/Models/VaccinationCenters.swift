//
//  VaccinationCenters.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 24/06/21.
//

import Foundation

struct VaccinationCenters: Codable {
    let sessions: [Session]
}

// MARK: - Session
struct Session: Codable {
    let centerID: Int
    let name, address, stateName, districtName: String
    let blockName: String
    let pincode: Int
    let from, to: String
    let lat, long: Int
    let feeType, sessionID, date: String
    let availableCapacity, availableCapacityDose1, availableCapacityDose2: Int
    let fee: String
    let minAgeLimit: Int
    let vaccine: String
    let slots: [String]

    enum CodingKeys: String, CodingKey {
        case centerID = "center_id"
        case name, address
        case stateName = "state_name"
        case districtName = "district_name"
        case blockName = "block_name"
        case pincode, from, to, lat, long
        case feeType = "fee_type"
        case sessionID = "session_id"
        case date
        case availableCapacity = "available_capacity"
        case availableCapacityDose1 = "available_capacity_dose1"
        case availableCapacityDose2 = "available_capacity_dose2"
        case fee
        case minAgeLimit = "min_age_limit"
        case vaccine, slots
    }
}
