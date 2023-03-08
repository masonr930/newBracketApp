//
//  roundClass.swift
//  newBracketApp
//
//  Created by JAMES DURCAN on 2/16/23.
//

import Foundation
class RoundClass: Codable{
    
    var matches: [MatchupClass]
    var round: Int
    
    init(bMatches: [MatchupClass], brounds: Int) {
        matches = bMatches
        round = brounds
    }
}
