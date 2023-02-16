//
//  roundClass.swift
//  newBracketApp
//
//  Created by JAMES DURCAN on 2/16/23.
//

import Foundation
class RoundClass{
    
    var matches: [MatchupClass] = []
    var round = 0
    
    init(bMatches: [MatchupClass], brounds: Int) {
        matches = bMatches
        round = brounds
    }
}
