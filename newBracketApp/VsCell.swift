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
    
    func chooseWinner(matches: [MatchupClass])
    {
        if cellMatch?.winnerCheck == false
        {
            winnerLabel.text = "N/A"
        }
        else
        {
            if cellMatch?.winner == true
            {
                winnerLabel.text = "\(cellMatch?.homeTeam)"
            }
            else
            {
                winnerLabel.text = "\(cellMatch?.awayTeam)"
            }
            
        }
    }
    
    func configure (match: MatchupClass){
        cellMatch = match
        teamOneLabel.text = cellMatch!.homeTeam
        teamTwoLabel.text = cellMatch!.awayTeam
        winnerLabel.text = "N/A"
    }
}
