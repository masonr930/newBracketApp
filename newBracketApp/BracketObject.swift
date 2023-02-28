//
//  BracketObject.swift
//  newBracketApp
//
//  Created by JAMES DURCAN on 2/27/23.
//

import Foundation

class BracketObject{
    
    var title: String = ""
    var rounds = [Int: RoundClass]()
    
    init(title: String, rounds: [Int: RoundClass]) {
        self.title = title
        self.rounds = rounds
    }
    
    
    
}
