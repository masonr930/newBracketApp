//
//  Bracket16ViewController.swift
//  ScrollViewNotes
//
//  Created by MAX WIDHALM on 3/9/23.
//

import UIKit

class Bracket8ViewController: UIViewController {

    var theBracket : BracketObject?
    var currentRound : Int!
    
    // LEFT SIDE OUTLETS
    @IBOutlet weak var r1t1: UITextField!
    @IBOutlet weak var r1t2: UITextField!
    @IBOutlet weak var r1t3: UITextField!
    @IBOutlet weak var r1t4: UITextField!
    
    @IBOutlet weak var r2t1: UITextField!
    @IBOutlet weak var r2t2: UITextField!
    
    @IBOutlet weak var f1: UITextField!
    
    // RIGHT SIDE OUTLETS
    @IBOutlet weak var f2: UITextField!
    
    @IBOutlet weak var r2t3: UITextField!
    @IBOutlet weak var r2t4: UITextField!
    
    @IBOutlet weak var r1t5: UITextField!
    @IBOutlet weak var r1t6: UITextField!
    @IBOutlet weak var r1t7: UITextField!
    @IBOutlet weak var r1t8: UITextField!
    
    
    @IBOutlet var round1Cells: [UITextField]!
    
    @IBOutlet var round2Cells: [UITextField]!
    
    @IBOutlet var finalsCells: [UITextField]!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        populateRound1()
        populateRound2()
        populateFinals()
    }
    
    // theBracket.roundMatches[0].matches[0].homeTeam
    func populateRound1() {
        var i = 0 // cells index
        var n = 0 // match index
        while i < round1Cells.count {
            round1Cells[i].isUserInteractionEnabled = false
            round1Cells[i].textColor = UIColor.black
            
            round1Cells[i].text = "\(theBracket!.rounds[0].matches[n].homeTeam)"
            i+=1
            round1Cells[i].isUserInteractionEnabled = false
            if theBracket!.rounds[0].matches[n].isMatch {
                round1Cells[i].text = "\(theBracket!.rounds[0].matches[n].awayTeam)"
            } else {
                round1Cells[i].textColor = UIColor.lightGray
                round1Cells[i].text = "-Bye-"
            }
            
            i+=1
            n+=1
        }
        print("yuh")
    }
    
    func populateRound2() {
        for i in 0..<round2Cells.count {
            round2Cells[i].isUserInteractionEnabled = false
            round2Cells[i].textColor = UIColor.lightGray

            if theBracket!.rounds[0].matches[i].winnerCheck {
                round2Cells[i].textColor = UIColor.black
                if theBracket!.rounds[0].matches[i].winner {
                    round2Cells[i].text = "\(theBracket!.rounds[0].matches[i].homeTeam)"
                } else {
                    round2Cells[i].text = "\(theBracket!.rounds[0].matches[i].awayTeam)"
                }
            } else {
                round2Cells[i].text = "Round 1 Winner"
            }
            
        }
    }
    
    func populateFinals() {
        for i in 0..<finalsCells.count {
            finalsCells[i].isUserInteractionEnabled = false
            finalsCells[i].textColor = UIColor.lightGray

            if theBracket!.rounds[1].matches[i].winnerCheck {
                finalsCells[i].textColor = UIColor.black
                if theBracket!.rounds[1].matches[i].winner {
                    finalsCells[i].text = "\(theBracket!.rounds[1].matches[i].homeTeam)"
                } else {
                    finalsCells[i].text = "\(theBracket!.rounds[1].matches[i].awayTeam)"
                }
            } else {
                finalsCells[i].text = "Finalist"
            }
            
        }
    }
    
    
    
    @IBAction func backButton(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToBracket4", sender: nil)
    }
    

}
