//
//  VsCell.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/13/23.
//

import Foundation
import UIKit

class VsCell: UITableViewCell{
    
    @IBOutlet weak var teamOneLabel: UILabel!
    
    @IBOutlet weak var teamTwoLabel: UILabel!
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    var cellMatch: MatchupClass?
    func labelChange(teamOne: String, teamTwo: String){
        
    }
    
    
    
    func configure (match: MatchupClass){
        teamOneLabel.text = match.homeTeam
        teamTwoLabel.text = match.awayTeam
        
        if match.winnerCheck == false
        {
            winnerLabel.text = "N/A"
        }
        else
        {
            if match.winner == true
            {
                winnerLabel.text = "\(match.homeTeam)"
            }
            else
            {
                winnerLabel.text = "\(match.awayTeam)"
            }
            
        }
    }
}
