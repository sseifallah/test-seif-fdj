//
//  LeagueTeams.swift
//  Test Seif
//
//  Created by  Seif on 19/05/2022.
//

import Foundation

struct LeagueTeams: Codable {
    let teams: [Team]?
}

struct Team: Codable {
    let name: String?
    let banner: String?
    let country: String?
    let league: String?
    let teamDescription: String?
    let teamBadge: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "strTeam"
        case banner = "strTeamBanner"
        case country = "strCountry"
        case league = "strLeague"
        case teamDescription = "strDescriptionEN"
        case teamBadge = "strTeamBadge"
    }
}
