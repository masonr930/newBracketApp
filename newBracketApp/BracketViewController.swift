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
    var matIndex = 0
    var bigBracket: BracketObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        matchesTable.dataSource = self
        matchesTable.delegate = self
        
        
        matchesTable.reloadData()
        addSegueButtons(rounds2: rounds)
        byeCheck()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return matches.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "matchCell") as! VsCell
        cell.configure(match: matches[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMatch = matches[indexPath.row]
        matIndex = indexPath.row
        if  selectedMatch.isMatch == true{
            performSegue(withIdentifier: "chooseWinnerSegue", sender: self)
        }
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
        matches = bigBracket.rounds[sectionChoice-1]!.matches
        matchesTable.reloadData()
        
        
        
        
    }
      
    //more rounds checkers
    var newMatches: [MatchupClass] = []
    
    
    func winnerMoment(r: Int, matNum: Int){
        var dub: String!
        if bigBracket.rounds[r]!.matches[matNum].winnerCheck{
            if (bigBracket.rounds[r]!.matches[matNum].winner){
                dub = bigBracket.rounds[r]!.matches[matNum].homeTeam
                print("Home")
            }
            else {
                dub = bigBracket.rounds[r]!.matches[matNum].awayTeam
                print("away")
            }
            if matNum%2 == 0{
                bigBracket.rounds[r+1]!.matches[(matNum/2)].homeTeam = dub
            }
            else {
                bigBracket.rounds[r+1]!.matches[(matNum/2)].awayTeam = dub
            }
        }
    }
    
    func byeCheck(){
        var matNum = bigBracket.rounds[0]!.matches.count
        for i in 0 ..< matNum{
            if bigBracket.rounds[0]!.matches[i].isMatch{
                if i%2 == 0{
                    bigBracket.rounds[1]!.matches[(i/2)].homeTeam = bigBracket.rounds[0]!.matches[i].homeTeam
                    print("BOOOOO")
                }
                else {
                    bigBracket.rounds[1]!.matches[(i/2)].awayTeam = bigBracket.rounds[0]!.matches[i].homeTeam
                    print("hooray!")
                }
            }
        }
    }
    
    @IBAction func goToBracket(_ sender: UIButton)
    {
        performSegue(withIdentifier: "toBracket", sender: self)
    }
    
    @IBAction func unwind(_seg: UIStoryboardSegue)
    {
        winnerMoment(r: sectionChoice-1, matNum: matIndex)
        matchesTable.reloadData()
    }
    
    
    
    
    }
