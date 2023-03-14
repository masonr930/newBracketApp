//
//  BracketObject.swift
//  newBracketApp
//
//  Created by JAMES DURCAN on 2/27/23.
//

import Foundation
import FirebaseCore
import FirebaseDatabase
import UIKit
import SwiftUI


public class BracketObject: Codable{
    
    var bracketKey: String = ""
   var title: String = ""
  var rounds: [RoundClass]
    var fireKey = ""
//    var roundsData = [Data]()
    init(title: String, rounds: [RoundClass]) {
        self.title = title
        self.rounds = rounds
    }
    
    init(dict: [String:Any]){
        self.title = dict["title"] as! String
        var rounds2: [RoundClass] = []
        var matches2: [MatchupClass] = []
        print("This is super fun")
        print("\(dict["rounds"])")
        var dRounds = dict["rounds"] as! [String: Any]
        print("Do not read")
        var matcher: MatchupClass!
        for i in 0..<dRounds.count {
            var dMatch = dRounds["\(i)"] as! [String: Any]
            for j in 0..<dMatch.count{
                print("Waddup looser")
                matcher = MatchupClass(hTeam: dMatch["homeTeam"] as! String, aTeam: dMatch["awayteam"] as! String, hScore: 0, aScore: 0, match: dMatch["isMatch"] as! Bool)
                matcher.winner = dMatch["winner"] as! Bool
                matcher.winnerCheck = dMatch["winnerCheck"] as! Bool
                matcher.hasTeams = dMatch["hasTeams"] as! Bool
                matches2.append(matcher)
                print(matcher.homeTeam)
            }
            rounds2.append(RoundClass(bMatches: matches2, brounds: i))
        }
        self.rounds = rounds2


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
    
    func read(){
        
    }
    
    func saveToFirebase(){
        var dictMatch: [String : Any] = [:]
        var dictRound: [String : Any] = [:]
        var dictB: [String : Any] = [:]
        dictB = ["title": title, "roundDict": dictRound] as [String: Any]
        
        var ref = Database.database().reference()
        ref = ref.childByAutoId()
        ref.setValue(dictB)
        fireKey = ref.key ?? "0"
        
        for i in 0..<rounds.count{
            print("Round: \(rounds[i].round)")
            
            for j in 0..<rounds[i].matches.count{
                dictMatch = ["homeTeam": rounds[i].matches[j].homeTeam, "awayTeam": rounds[i].matches[j].awayTeam,"isMatch": rounds[i].matches[j].isMatch,"winner": rounds[i].matches[j].winner, "winnerCheck": rounds[i].matches[j].winnerCheck, "hasTeams": rounds[i].matches[j].hasTeams] as [String : Any]
                
                ref.child("rounds").child("\(rounds[i].round)").child("matches").child("\(j)").setValue(dictMatch)
            }
            
        }
        
    }

}
