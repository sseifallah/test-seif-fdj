//
//  APIEndpoints.swift
//  Test Seif
//
//  Created by  Seif on 19/05/2022.
//

import Foundation

class APIEndpoints {
    static let baseURL = "https://www.thesportsdb.com/api/v1/json/2/"
    static let getLeaguesURL = baseURL + "all_leagues.php"
    static let getTeamsURL = baseURL + "search_all_teams.php"
}
