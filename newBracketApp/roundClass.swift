//
//  roundClass.swift
//  newBracketApp
//
//  Created by JAMES DURCAN on 2/15/23.
//

import Foundation

class RoundClass{
    
    
    
    var matches: [MatchupClass] = []
    var round = 0
    
    init(bMatches: [MatchupClass], bround: Int) {
        
        matches = bMatches
        round = bround
        
    }
    
}
