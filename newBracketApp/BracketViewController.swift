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
    
    func addSegueButtons(rounds2: Int){
        if(rounds2 > 2){
            for i in 0 ... rounds2-3 {
                segmentedController.insertSegment(withTitle: labels[i], at: i+2, animated: false)
            }
        }
    }
    
    
    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        if segmentedController.value(forKey: "First"){
            
        }
    }
    
    
}
