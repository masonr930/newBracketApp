//
//  matchUp.swift
//  newBracketApp
//
//  Created by JAMES DURCAN on 2/8/23.
//

import Foundation

class MatchupClass: Codable{
    var homeTeam: String
    var awayTeam: String
    var homeScore: Int
    var awayScore: Int
    var isMatch: Bool
    var winner: Bool
    var winnerCheck: Bool
    var hasTeams: Bool
    
    
    init(hTeam: String, aTeam: String, hScore: Int, aScore: Int, match: Bool) {
        
        homeTeam = hTeam
        awayTeam = aTeam
        //these score variables are completely useless, but they've been here since the beginning
        homeScore = hScore
        awayScore = aScore
        //is match checks if its a bye
        isMatch = match
        //winner is true if winner is home team, false if away team. Variable should only be used in winnercheck is true
        winner = true
        //winner check, checks if there is a winner has been declared
        winnerCheck = false
        hasTeams = true
        
    }
    
    
    
    
}
