//
//  BracketObject.swift
//  newBracketApp
//
//  Created by JAMES DURCAN on 2/27/23.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

class BracketObject{
    
    var ref = Database.database().reference()
    var title: String = ""
    var rounds: [RoundClass] = []
    
    init(title: String, rounds: [RoundClass]) {
        self.title = title
        self.rounds = rounds
    }
    
//homeTeam: String
//var awayTeam: String
//var homeScore: Int
//var awayScore: Int
//var isMatch: Bool
//var winner: Bool
//var winnerCheck: Bool
//var hasTeams: Bool
    
//    rounds[i].matches[j].awayTeam
//    func saveToFirebase(){
//        for i in 0..<rounds.count{
//            for j in 0..<rounds[i].matches.count{
//                let dictMatch = ["awayTeam": ]
//            }
//        }
//
//
//        let dict = ["title": title] as [String: Any]
//        let uRef = ref.childByAutoId()
//        uRef.setValue(dict)
//
//
//
//    }
//
}
