//
//  WinnerVC.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/15/23.
//

import UIKit

class WinnerVC: UIViewController {

    var team1: String!
    var team2: String!
    var match: MatchupClass!
    var cell: VsCell!
    
    @IBOutlet weak var homeLabel: UILabel!
    
    @IBOutlet weak var awayLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeLabel.text = team1
        awayLabel.text = team2
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        cell.configure(match: match)
    }
    
    @IBAction func homeButton(_ sender: UIButton){
        
        match.winner = true
        match.winnerCheck = true
        
    }
    
    @IBAction func awayButton(_ sender: UIButton) {
        
        match.winner = false
        match.winnerCheck = true
    }
    

}
