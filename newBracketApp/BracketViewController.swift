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
    var teams: [String] = []
    var matches: [MatchupClass] = []
    var teamCheck = false
    var rounds = 0
    var selectedMatch: MatchupClass!
    var sectionChoice = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        matchesTable.dataSource = self
        matchesTable.delegate = self
        print(matches[0].homeTeam)
        matchesTable.reloadData()
        addSegueButtons(rounds2: rounds)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("lmao")
        
        return matches.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell") as! VsCell
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
        print(sectionChoice)
    }
      
    //more rounds checkers
    var newMatches: [MatchupClass] = []
    
    
    
    }
