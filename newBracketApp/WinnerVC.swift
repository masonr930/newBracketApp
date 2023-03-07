//
//  WinnerVC.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/15/23.
//

import UIKit

class WinnerVC: UIViewController {

    var team1: String!
    var team2: String!
    var match: MatchupClass!
    var cell: VsCell!
    var segment: Int!
    var finalSegment: Int!
    
    @IBOutlet weak var homeLabel: UILabel!
    
    @IBOutlet weak var awayLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeLabel.text = team1
        awayLabel.text = team2
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
        
        if segment == finalSegment
        {
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
        
        if segment == finalSegment
        {
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
            
            if match.winner == true
            {
                nvc.text = "\(match.homeTeam) won!"
            }
            else
            {
                nvc.text = "\(match.awayTeam) won!"
            }
        }
    }
    
    @IBAction func backButton(_ sender: UIButton)
    {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
    

}
