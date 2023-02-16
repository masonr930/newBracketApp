//
//  matchUp.swift
//  newBracketApp
//
//  Created by JAMES DURCAN on 2/8/23.
//

import Foundation

class MatchupClass{
    var homeTeam: String
    var awayTeam: String
    var homeScore: Int
    var awayScore: Int
    var isMatch: Bool
    var winner: Bool
    var winnerCheck: Bool
    
    
    init(hTeam: String, aTeam: String, hScore: Int, aScore: Int, match: Bool) {
        
        homeTeam = hTeam
        awayTeam = aTeam
        homeScore = hScore
        awayScore = aScore
        isMatch = match
        winner = true
        winnerCheck = false
        
    }
    
    
    
    
}
