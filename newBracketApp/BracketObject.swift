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
    
    //This is the key entered to see bracket
    var bracketKey: String = ""
    //This helps track loading into the app
    var made = false
    var title: String = ""
    //This is a dictionary of all the rounds
    var rounds: [RoundClass]
    //lets one get the firekey
    var fireKey = ""
    //will work on in future
    var owner = false
    
    
    init(title: String, rounds: [RoundClass], bracketKey: String) {
        self.title = title
        self.rounds = rounds
        self.bracketKey = bracketKey
    }
    //This should be called whenever we need to fetch from firebase
    init(dict: [String:Any], reference: String){
        //Gets the easy variables
        self.title = dict["title"] as! String
        self.bracketKey = dict["bracketKey"] as! String
        print(reference)
        self.fireKey = reference
        if let m = dict["made"]{
            self.made = m as! Bool
        }
       // self.made = dict["made"] as! Bool
        var rounds2: [RoundClass] = []
        var matches2: [MatchupClass] = []
        let dRounds = dict["rounds"] as! [Any]
        var matcher: MatchupClass!
        
        
        for i in 1..<dRounds.count {
            let dMatch = dRounds[i] as! [String: Any]
            let gar = dMatch["matches"] as! [Any]
                    
            for j in 0..<gar.count{

                let blah = gar[j] as! [String: Any]
                matcher = MatchupClass(hTeam: blah["homeTeam"] as! String, aTeam: blah["awayTeam"] as! String, hScore: 0, aScore: 0, match: blah["isMatch"] as! Bool)
                matcher.winner = blah["winner"] as! Bool
                matcher.winnerCheck = blah["winnerCheck"] as! Bool
                matcher.hasTeams = blah["hasTeams"] as! Bool
                matches2.append(matcher)
                
            }
            rounds2.append(RoundClass(bMatches: matches2, brounds: i))
            matches2.removeAll()
        }
        self.rounds = rounds2
    }

    //This creates a dictionary to put into firebase
    func createDict() -> [String: Any]{
        let dictRound: [String : Any] = [:]
        var dictB: [String : Any] = [:]
        dictB = ["title": title, "roundDict": dictRound, "bracketKey": bracketKey, "made": made] as [String: Any]
        return dictB
    }
    
    //This updates any dictionary with winners, basically just creates a new dictionary
    func update(dictB: [String: Any]){
        var dictMatch: [String : Any] = [:]
        let ref = Database.database().reference().child(fireKey)
        ref.updateChildValues(["made": made])
        
        //Loops through all of rounds and matches
        for i in 0 ..< rounds.count{
            
            for j in 0..<rounds[i].matches.count{
                dictMatch = ["homeTeam": rounds[i].matches[j].homeTeam, "awayTeam": rounds[i].matches[j].awayTeam,"isMatch": rounds[i].matches[j].isMatch,"winner": rounds[i].matches[j].winner, "winnerCheck": rounds[i].matches[j].winnerCheck, "hasTeams": rounds[i].matches[j].hasTeams] as [String : Any]
                
                ref.child("rounds").child("\(rounds[i].round)").child("matches").child("\(j)").updateChildValues(dictMatch)
            }

            
        }

    }
    
    //This actually saves to firebase
    func saveToFirebase(){
        var dictMatch: [String : Any] = [:]
        let dictRound: [String : Any] = [:]
        var dictB: [String : Any] = [:]
        var ref = Database.database().reference()
        fireKey = ref.childByAutoId().key ?? "0"
        ref = ref.child(fireKey)
        dictB = ["title": title, "roundDict": dictRound, "bracketKey": bracketKey, "made": made] as [String: Any]
        ref.setValue(dictB)
        
        
        for i in 0..<rounds.count{
            print("Round: \(rounds[i].round)")
            
            for j in 0..<rounds[i].matches.count{
                dictMatch = ["homeTeam": rounds[i].matches[j].homeTeam, "awayTeam": rounds[i].matches[j].awayTeam,"isMatch": rounds[i].matches[j].isMatch,"winner": rounds[i].matches[j].winner, "winnerCheck": rounds[i].matches[j].winnerCheck, "hasTeams": rounds[i].matches[j].hasTeams] as [String : Any]
                
                ref.child("rounds").child("\(rounds[i].round)").child("matches").child("\(j)").setValue(dictMatch)
            }
            
        }
        //This saves bracket to visible class so one can see it on the app with user defaults
        var visible: [BracketObject] = []
        if let items = UserDefaults.standard.data(forKey: "createdBrackets") {
                        let decoder = JSONDecoder()
                        if let decoded = try? decoder.decode([BracketObject].self, from: items) {
                            visible = decoded
                        }
                }

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(visible) {
                UserDefaults.standard.set(encoded, forKey: "createdBrackets")
        }
    }

}
