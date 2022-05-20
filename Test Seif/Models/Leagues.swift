//
//  Leagues.swift
//  Test Seif
//
//  Created by  Seif on 19/05/2022.
//

import Foundation

struct Leagues: Codable {
    let leagues: [League]?
}

struct League: Codable {
    let name: String?
    let sport: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "strLeague"
        case sport = "strSport"
    }
}
