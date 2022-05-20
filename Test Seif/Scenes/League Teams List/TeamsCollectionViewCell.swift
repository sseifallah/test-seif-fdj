//
//  TeamsCollectionViewCell.swift
//  Test Seif
//
//  Created by  Seif on 19/05/2022.
//

import UIKit
import SDWebImage

class TeamsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamImageView: UIImageView!
    
    func configurateCell(with team: Team){
        teamImageView.sd_setImage(with: URL(string: team.teamBadge ?? ""))
    }
}
