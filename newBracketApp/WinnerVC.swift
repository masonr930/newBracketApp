//
//  WinnerVC.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/15/23.
//

import UIKit

class WinnerVC: UIViewController {

    var bracket: BracketObject!
    var team1: String!
    var team2: String!
    var match: MatchupClass!
    var cell: VsCell!
    var segment: Int!
    var finalSegment: Int!
    var medalists: [String] = []
    var visible: [BracketObject] = []
    var index: Int?
    
    @IBOutlet weak var homeLabel: UILabel!
    
    @IBOutlet weak var awayLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeLabel.text = team1
        awayLabel.text = team2
        if let items = UserDefaults.standard.data(forKey: "visibleBrackets") {
                        let decoder = JSONDecoder()
                        if let decoded = try? decoder.decode([BracketObject].self, from: items) {
                            visible = decoded
                        }
                }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if isMovingFromParent
        {
            performSegue(withIdentifier: "unwindSegue", sender: nil)
        }
    }
    
    @IBAction func homeButton(_ sender: UIButton){
        
        match.winner = true
        match.winnerCheck = true
        bracket.update(dictB: bracket.createDict())
        for i in 0..<visible.count{
            if(visible[i].bracketKey == bracket.bracketKey){
                index = i
            }
        }
        if let j = index{
            visible[j] = bracket
        }
        else{
            print("Index not found")
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(visible) {
                UserDefaults.standard.set(encoded, forKey: "visibleBrackets")
        }
        
        if segment == finalSegment - 1
        {
            medalists.append(match.awayTeam)
            performSegue(withIdentifier: "unwindSegue", sender: nil)
        }
        
        else if segment == finalSegment
        {
            medalists.append(match.awayTeam)
            medalists.append(match.homeTeam)
            performSegue(withIdentifier: "finalWinnerSegue", sender: nil)
        }
        else
        {
            performSegue(withIdentifier: "unwindSegue", sender: nil)
        }
    }
    
    @IBAction func awayButton(_ sender: UIButton) {
        
        match.winner = false
        match.winnerCheck = true
        bracket.update(dictB: bracket.createDict())
        
        if segment == finalSegment - 1
        {
            medalists.append(match.homeTeam)
        }
        
        if segment == finalSegment
        {
            medalists.append(match.homeTeam)
            medalists.append(match.awayTeam)
            performSegue(withIdentifier: "finalWinnerSegue", sender: nil)
        }
        else
        {
            performSegue(withIdentifier: "unwindSegue", sender: nil)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finalWinnerSegue"
        {
            let nvc = segue.destination as! FinalWinnerViewController
            nvc.medalists = medalists
            
        }
    }
    
    @IBAction func backButton(_ sender: UIButton)
    {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
    

}
