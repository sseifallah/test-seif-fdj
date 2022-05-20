//
//  LeagueTeamsListVC.swift
//  Test Seif
//
//  Created by  Seif on 19/05/2022.
//

import UIKit

protocol LeagueTeamsList: AnyObject{
    func onLeaguesRetrieval(leagues: [String])
    func onTeamsRetrieval(teams: [Team])
    func onFetchDataFailure(for retrivedObject: RetrieveObject)
}

class LeagueTeamsListVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    // MARK: - Properties
    var presenter: LeagueTeamsListViewPresenter!
    var leagues: [String] = []
    var teams: [Team] = []
    let cellIdentifier = "cell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LeagueTeamsListPresenter(view: self)
        //Setup Delegates
        searchTextField.delegate = self
        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
        
        presenter.retrieveLeagues()
        //Setup autocomplete for search field
        searchTextField.itemSelectionHandler = { [weak self] filteredLeagues, itemPosition in
            guard let self = self else {return}
            let league = filteredLeagues[itemPosition]
            self.searchTextField.text = league.title
            self.presenter.retrieveTeams(leagueName: league.title)
            self.searchTextField.resignFirstResponder()
        }
    }
    
    //Small animation on the cancel button
    fileprivate func changeCancelButtonAlphaValue(value: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.cancelButton.alpha = value
        }, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func cancelButtonTapAction(_ sender: Any) {
        searchTextField.text = ""
        teams.removeAll()
        DispatchQueue.main.async {
            self.teamsCollectionView.reloadData()
        }
        changeCancelButtonAlphaValue(value: 0)
        searchTextField.becomeFirstResponder()
    }
    
    @IBAction func searchEditingChanged(_ sender: Any) {
        if searchTextField.text?.count ?? 0 > 0{
            changeCancelButtonAlphaValue(value: 1)
        }else{
            changeCancelButtonAlphaValue(value: 0)
        }
    }
}

// MARK: - Protocol Methods
extension LeagueTeamsListVC: LeagueTeamsList{
    
    func onLeaguesRetrieval(leagues: [String]) {
        self.leagues = leagues
        searchTextField.filterStrings(leagues)
    }
    
    func onTeamsRetrieval(teams: [Team]) {
        self.teams.removeAll()
        self.teams = teams
        DispatchQueue.main.async {
            self.teamsCollectionView.reloadData()
        }
    }
    
    func onFetchDataFailure(for retrivedObject: RetrieveObject) {
        DispatchQueue.main.async {
            let errorAlert = UIAlertController(title: "Error", message: "Could not retrieve data for \(retrivedObject.rawValue)", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
            self.teams.removeAll()
            self.teamsCollectionView.reloadData()
        }
    }
}

// MARK: - CollectionView Methods
extension LeagueTeamsListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TeamsCollectionViewCell
        let team = teams[indexPath.row]
        cell.configurateCell(with: team)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let team = teams[indexPath.row]
        let teamDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeamDetailVC") as! TeamDetailVC
        teamDetailVC.team = team
        self.navigationController?.pushViewController(teamDetailVC, animated: true)
    }
    
    //Setting collection view to have two elements at each row, depending on iPhone screen
    //If the device is iPad, fix the cell size at 240 for the height and width
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .phone {
            let size = (collectionView.frame.width / 2) - 10
            return CGSize(width: size, height: size)
        }else{
            return CGSize(width: 240, height: 240)
        }
    }
}

// MARK: - Text Field Delegate
extension LeagueTeamsListVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.presenter.retrieveTeams(leagueName: textField.text ?? "")
        return true
    }
}

