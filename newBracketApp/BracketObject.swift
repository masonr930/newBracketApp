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
    var made = false
   var title: String = ""
  var rounds: [RoundClass]
    var fireKey = ""
//    var ref = Database.database().reference()
    var owner = false
//    var roundsData = [Data]()
    init(title: String, rounds: [RoundClass], bracketKey: String) {
        self.title = title
        self.rounds = rounds
        self.bracketKey = bracketKey
    }
    
    init(dict: [String:Any], reference: String){
        self.title = dict["title"] as! String
        self.bracketKey = dict["bracketKey"] as! String
        self.fireKey = reference
        self.made = dict["made"] as! Bool
        var rounds2: [RoundClass] = []
        var matches2: [MatchupClass] = []
        print("This is super fun")
        var dRounds = dict["rounds"] as! [Any]
        var matcher: MatchupClass!
        for i in 1..<dRounds.count {
            var dMatch = dRounds[i] as! [String: Any]
            var gar = dMatch["matches"] as! [Any]
                    
            for j in 0..<gar.count{
                    print("Round \(i) Match \(j)")
                
                    var blah = gar[j] as! [String: Any]
                print(blah["homeTeam"] as! String)
                    matcher = MatchupClass(hTeam: blah["homeTeam"] as! String, aTeam: blah["awayTeam"] as! String, hScore: 0, aScore: 0, match: blah["isMatch"] as! Bool)
                    matcher.winner = blah["winner"] as! Bool
                    matcher.winnerCheck = blah["winnerCheck"] as! Bool
                    matcher.hasTeams = blah["hasTeams"] as! Bool
                    matches2.append(matcher)
                    print(matcher.homeTeam)
            }
                    rounds2.append(RoundClass(bMatches: matches2, brounds: i))
            matches2.removeAll()
                }
                self.rounds = rounds2
//        print(rounds[2].matches[1].homeTeam)
            
        
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
    
    func createDict() -> [String: Any]{
        var dictRound: [String : Any] = [:]
        var dictB: [String : Any] = [:]
        dictB = ["title": title, "roundDict": dictRound, "bracketKey": bracketKey, "made": made] as [String: Any]
        return dictB
    }
    
    
    func update(dictB: [String: Any]){
        var dictMatch: [String : Any] = [:]
        var ref = Database.database().reference().child(fireKey)
        ref.updateChildValues(["made": made])
        
//        ref.child(fireKey).updateChildValues(dictB)
//        ref = ref.child(fireKey)
        for i in 0 ..< rounds.count{
            
            for j in 0..<rounds[i].matches.count{
                dictMatch = ["homeTeam": rounds[i].matches[j].homeTeam, "awayTeam": rounds[i].matches[j].awayTeam,"isMatch": rounds[i].matches[j].isMatch,"winner": rounds[i].matches[j].winner, "winnerCheck": rounds[i].matches[j].winnerCheck, "hasTeams": rounds[i].matches[j].hasTeams] as [String : Any]
                
                ref.child("rounds").child("\(rounds[i].round)").child("matches").child("\(j)").updateChildValues(dictMatch)
            }

            
        }

    }
    
    func saveToFirebase(){
        var dictMatch: [String : Any] = [:]
        var dictRound: [String : Any] = [:]
        var dictB: [String : Any] = [:]
        var ref = Database.database().reference()
        fireKey = ref.childByAutoId().key ?? "0"
        ref = ref.child(fireKey)
        print(ref.key)
        dictB = ["title": title, "roundDict": dictRound, "bracketKey": bracketKey, "made": made] as [String: Any]
        ref.setValue(dictB)
        
        
        for i in 0..<rounds.count{
            print("Round: \(rounds[i].round)")
            
            for j in 0..<rounds[i].matches.count{
                dictMatch = ["homeTeam": rounds[i].matches[j].homeTeam, "awayTeam": rounds[i].matches[j].awayTeam,"isMatch": rounds[i].matches[j].isMatch,"winner": rounds[i].matches[j].winner, "winnerCheck": rounds[i].matches[j].winnerCheck, "hasTeams": rounds[i].matches[j].hasTeams] as [String : Any]
                
                ref.child("rounds").child("\(rounds[i].round)").child("matches").child("\(j)").setValue(dictMatch)
            }
            
        }
        var visible: [BracketObject] = []
        if let items = UserDefaults.standard.data(forKey: "visibleBrackets") {
                        let decoder = JSONDecoder()
                        if let decoded = try? decoder.decode([BracketObject].self, from: items) {
                            visible = decoded
                        }
                }

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(visible) {
                UserDefaults.standard.set(encoded, forKey: "visibleBrackets")
        }
    }

}
