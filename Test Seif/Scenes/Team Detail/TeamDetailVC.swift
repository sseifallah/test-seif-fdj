//
//  TeamDetailVC.swift
//  Test Seif
//
//  Created by  Seif on 19/05/2022.
//

import UIKit
import SDWebImage

protocol TeamDetail: AnyObject{
    
}

class TeamDetailVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Properties
    var team: Team!
    var presenter: TeamDetailViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = TeamDetailPresenter(view: self)
        //Fill the info on the page with the selected team object
        navigationItem.title = team.name
        countryLabel.text = team.country
        leagueLabel.text = team.league
        descriptionTextView.text = team.teamDescription
        bannerImageView.sd_setImage(with: URL(string: team.banner ?? ""))
    }
}

extension TeamDetailVC: TeamDetail{
    
}
