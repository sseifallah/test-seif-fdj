//
//  TeamDetailPresenter.swift
//  Test Seif
//
//  Created by  Seif on 19/05/2022.
//

import Foundation

protocol TeamDetailViewPresenter: AnyObject{
    init(view: TeamDetail)
}

class TeamDetailPresenter: TeamDetailViewPresenter {
    
    weak var view: TeamDetail?
    
    // MARK: - Protocol methods
    required init(view: TeamDetail) {
        self.view = view
    }
    
    
}
