//
//  LeagueTeamsListPresenter.swift
//  Test Seif
//
//  Created by  Seif on 19/05/2022.
//

import Foundation

protocol LeagueTeamsListViewPresenter: AnyObject{
    init(view: LeagueTeamsList)
    func retrieveLeagues()
    func retrieveTeams(leagueName: String)
}

enum RetrieveObject: String {
    case league = "league"
    case teams  = "teams"
}

class LeagueTeamsListPresenter: LeagueTeamsListViewPresenter{
    
    weak var view: LeagueTeamsList?
    
    // MARK: - Protocol methods
    required init(view: LeagueTeamsList) {
        self.view = view
    }
    
    func retrieveLeagues() {
        Task{
            guard let leagues = await APIService.shared.getLeagues() else {
                view?.onFetchDataFailure(for: .league)
                return
            }
            let leagueTitles = leagues.compactMap { $0.name }
            view?.onLeaguesRetrieval(leagues: leagueTitles)
        }
    }
    
    func retrieveTeams(leagueName: String) {
        Task{
            guard let teams = await APIService.shared.getLeagueTeams(league: leagueName) else{
                view?.onFetchDataFailure(for: .teams)
                return
            }
            view?.onTeamsRetrieval(teams: teams)
        }
    }
    
}
