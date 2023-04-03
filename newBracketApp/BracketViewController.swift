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
        matches = bigBracket.rounds[0].matches
        
        matchesTable.reloadData()
        rounds = bigBracket.rounds.count
        addSegueButtons(rounds2: rounds)
//        byeCheck()
        matchesTable.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if isMovingFromParent
        {
            performSegue(withIdentifier: "unwindToHome", sender: nil)
        }
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
        if selectedMatch.isMatch == true && gotTeams(match: selectedMatch) == true{
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
            nvc.bracket = bigBracket
            nvc.team1 = selectedMatch.homeTeam
            nvc.team2 = selectedMatch.awayTeam
            nvc.match = selectedMatch
            nvc.cell = cell
            nvc.segment = segmentedController.selectedSegmentIndex + 1
            nvc.finalSegment = segmentedController.numberOfSegments
                
        }
        else if segue.identifier == "toBracket4"
        {
            let nvc = segue.destination as! Bracket4ViewController
            nvc.theBracket = bigBracket
        }
        else if segue.identifier == "toBracket8"
        {
            let nvc = segue.destination as! Bracket8ViewController
            nvc.theBracket = bigBracket
        }
        else if segue.identifier == "toBracket16"
        {
            let nvc = segue.destination as! Bracket16ViewController
            nvc.theBracket = bigBracket
        }
        else if segue.identifier == "toBracket32"
        {
            let nvc = segue.destination as! NewBracketViewController
            nvc.theBracket = bigBracket
        }
        else if segue.identifier == "toBracket64"
        {
            let nvc = segue.destination as! Bracket64ViewController
            nvc.theBracket = bigBracket
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
        matches = bigBracket.rounds[sectionChoice-1].matches
        matchesTable.reloadData()
        
        
        
        
    }
      
    //more rounds checkers
   
    
    
    func winnerMoment(r: Int, matNum: Int){
        var dub: String!
        if bigBracket.rounds[r].matches[matNum].winnerCheck{
            if (bigBracket.rounds[r].matches[matNum].winner){
                dub = bigBracket.rounds[r].matches[matNum].homeTeam
                print("Home")
            }
            else {
                dub = bigBracket.rounds[r].matches[matNum].awayTeam
                print("away")
            }
            if matNum%2 == 0{
                bigBracket.rounds[r+1].matches[(matNum/2)].homeTeam = dub
            }
            else {
                bigBracket.rounds[r+1].matches[(matNum/2)].awayTeam = dub
            }
        }
        bigBracket.update(dictB: bigBracket.createDict())
    }
    
//    func byeCheck(){
//        var matNum = bigBracket.rounds[0].matches.count
//        for i in 0 ..< matNum{
//            if !bigBracket.rounds[0].matches[i].isMatch{
//                bigBracket.rounds[0].matches[i].winnerCheck = true
//                if i%2 == 0{
//                    bigBracket.rounds[1].matches[(i/2)].homeTeam = bigBracket.rounds[0].matches[i].homeTeam
//                    print("BOOOOO")
//                }
//                else {
//                    bigBracket.rounds[1].matches[(i/2)].awayTeam = bigBracket.rounds[0].matches[i].homeTeam
//                    print("hooray!")
//                }
//            }
//        }
//    }
    
    @IBAction func goToBracket(_ sender: UIButton)
    {
        if bigBracket.rounds.count == 2 {
            performSegue(withIdentifier: "toBracket4", sender: self)
        }
        else if bigBracket.rounds.count == 3 {
            performSegue(withIdentifier: "toBracket8", sender: self)
        }
        else if bigBracket.rounds.count == 4 {
            performSegue(withIdentifier: "toBracket16", sender: self)
        }
        else if bigBracket.rounds.count == 5 {
            performSegue(withIdentifier: "toBracket32", sender: self)
        }
        else if bigBracket.rounds.count == 6 {
            performSegue(withIdentifier: "toBracket64", sender: self)
        }
        
    }
    
    
    @IBAction func unwind(_seg: UIStoryboardSegue)
    {
        winnerMoment(r: sectionChoice-1, matNum: matIndex)
        matchesTable.reloadData()
    }
    
    @IBAction func unwind2(_seg: UIStoryboardSegue)
    {
        matchesTable.reloadData()
    }
    
    @IBAction func unwind3(_seg: UIStoryboardSegue)
    {
        matchesTable.reloadData()
    }
    
    @IBAction func unwind4(_seg: UIStoryboardSegue)
    {
        matchesTable.reloadData()
    }
    
    @IBAction func unwind5(_seg: UIStoryboardSegue)
    {
        matchesTable.reloadData()
    }
    
    @IBAction func unwind6(_seg: UIStoryboardSegue) {
        matchesTable.reloadData()
    }
    
    
    func gotTeams(match: MatchupClass)->Bool
    {
        if match.homeTeam.hasSuffix("masonshouldntgotoalabama") || match.awayTeam.hasSuffix("masonshouldntgotoalabama")
        {
            match.hasTeams = false
        }
        else
        {
            return true
        }
        
        
        return match.hasTeams
    }
    
    @IBAction func homeButton(_ sender: UIButton)
    {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    
    
    
    }
