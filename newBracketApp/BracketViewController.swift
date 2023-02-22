//
//  BracketViewController.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/9/23.
//

import UIKit

class BracketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var matchesTable: UITableView!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    var labels = ["Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Nineth", "Tenth", "Eleventh", "Twelfth", "Thirteenth", "Fourteenth", "Fifteenth"]
    var cell: VsCell!
    var teams: [String] = []
    var matches: [MatchupClass] = []
    var teamCheck = false
    var rounds = 0
    var selectedMatch: MatchupClass!
    var sectionChoice = 1
    var roundMatches = [Int: RoundClass]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        matchesTable.dataSource = self
        matchesTable.delegate = self
        
        
        print(matches[0].homeTeam)
        matchesTable.reloadData()
        addSegueButtons(rounds2: rounds)
        roundMatches = makeRounds(rounds2: matches, r: rounds)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("lmao")
        
        return matches.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "matchCell") as! VsCell
        cell.configure(match: matches[indexPath.row])
        print("CELL MADE")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMatch = matches[indexPath.row]
        performSegue(withIdentifier: "chooseWinnerSegue", sender: self)
    }
    
    func addSegueButtons(rounds2: Int){
        if(rounds2 > 2){
            for i in 0 ... rounds2-3 {
                segmentedController.insertSegment(withTitle: labels[i], at: i+2, animated: false)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseWinnerSegue"
        {
            let nvc = segue.destination as! WinnerVC
            nvc.team1 = selectedMatch.homeTeam
            nvc.team2 = selectedMatch.awayTeam
            nvc.match = selectedMatch
            nvc.cell = cell
        }
    }
    
    
    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        let select = sender.selectedSegmentIndex
        switch select {
    
        case 0: sectionChoice = 1
        case 1: sectionChoice = 2
        case 2: sectionChoice = 3
        case 3: sectionChoice = 4
        case 4: sectionChoice = 5
        case 5: sectionChoice = 6
        case 6: sectionChoice = 7
        case 7: sectionChoice = 8
        case 8: sectionChoice = 9
        case 9: sectionChoice = 10
        case 10: sectionChoice = 11
        case 11: sectionChoice = 12
        case 12: sectionChoice = 13
        case 13: sectionChoice = 14
        case 14: sectionChoice = 15
        default: sectionChoice = 1
            
        }
        //this updates the tableView based on the selection made
        matches = roundMatches[sectionChoice-1]!.matches
        matchesTable.reloadData()
        
        
        
        
    }
      
    //more rounds checkers
    var newMatches: [MatchupClass] = []
    //This creates a dictionary of rounds which can be updated by the table
    func makeRounds(rounds2: [MatchupClass], r: Int) -> [Int: RoundClass]{
        var rounder = [Int: RoundClass]()
        rounder[0] = RoundClass.init(bMatches: rounds2, brounds: 1)
        for i in 1 ..< r {
            var ron = RoundClass(bMatches: rounds2, brounds: 0)
            ron = newRound(rounds: rounder[i-1] ?? rounder[0]!, r: i+1)
            rounder[i] = ron
        }
        return rounder
    }
    
    //This creates a round based on the round before it
    //Will be updated to that it can track a round made I suppose
    func newRound(rounds: RoundClass, r: Int) -> RoundClass{
        var mats = rounds.matches
        var str1 = ""
        var str2 = ""
        var bool = true
        var newMats: [MatchupClass] = []
        
        for i in 0 ..< mats.count {
            if bool{
                if mats[i].winnerCheck == false{
                    str1 = "Winner of round \(i+1)"
                }
                else{
                    if mats[i].winnerCheck{
                        str1 = mats[i].homeTeam
                    }
                    else{
                        str1 = mats[i].awayTeam
                    }
                }
                bool = false
            }
            else{
                if mats[i].winnerCheck == false{
                    str2 = "Winner of round \(i+1)"
                }
                else{
                    if mats[i].winnerCheck{
                        str2 = mats[i].homeTeam
                    }
                    else{
                        str2 = mats[i].awayTeam
                    }
                }

                newMats.append(MatchupClass(hTeam: str1, aTeam: str2, hScore: 0, aScore: 0, match: true))
                bool = true
            }
        }
        let nRound = RoundClass(bMatches: newMats, brounds: r)
        
        return nRound
    }
    
    func winnerMoment(r: Int, matNum: Int){
        var dub: String!
        if (roundMatches[r]!.matches[matNum].winner){
            dub = roundMatches[r]!.matches[matNum].homeTeam
        }
        else {
            dub = roundMatches[r]!.matches[matNum].awayTeam
        }
        if matNum%2 == 0{
            roundMatches[r+1]!.matches[(matNum/2)+1].homeTeam = dub
        }
        else {
            roundMatches[r+1]!.matches[(matNum/2)+1].awayTeam = dub
        }
        
    }
    
    @IBAction func goToBracket(_ sender: UIButton)
    {
        performSegue(withIdentifier: "toBracket", sender: self)
    }
    
    @IBAction func unwind(_seg: UIStoryboardSegue)
    {
        
    }
    
    
    
    
    }
