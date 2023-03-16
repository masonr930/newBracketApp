//
//  Bracket64ViewController.swift
//  newBracketApp
//
//  Created by MAX WIDHALM on 3/16/23.
//

import UIKit

class Bracket64ViewController: UIViewController {

    var theBracket : BracketObject?
    var currentRound : Int!
    
    // LEFT SIDE OUTLETS
    @IBOutlet weak var r1t1: UITextField!
    @IBOutlet weak var r1t2: UITextField!
    @IBOutlet weak var r1t3: UITextField!
    @IBOutlet weak var r1t4: UITextField!
    @IBOutlet weak var r1t5: UITextField!
    @IBOutlet weak var r1t6: UITextField!
    @IBOutlet weak var r1t7: UITextField!
    @IBOutlet weak var r1t8: UITextField!
    @IBOutlet weak var r1t9: UITextField!
    @IBOutlet weak var r1t10: UITextField!
    @IBOutlet weak var r1t11: UITextField!
    @IBOutlet weak var r1t12: UITextField!
    @IBOutlet weak var r1t13: UITextField!
    @IBOutlet weak var r1t14: UITextField!
    @IBOutlet weak var r1t15: UITextField!
    @IBOutlet weak var r1t16: UITextField!
    @IBOutlet weak var r1t17: UITextField!
    @IBOutlet weak var r1t18: UITextField!
    @IBOutlet weak var r1t19: UITextField!
    @IBOutlet weak var r1t20: UITextField!
    @IBOutlet weak var r1t21: UITextField!
    @IBOutlet weak var r1t22: UITextField!
    @IBOutlet weak var r1t23: UITextField!
    @IBOutlet weak var r1t24: UITextField!
    @IBOutlet weak var r1t25: UITextField!
    @IBOutlet weak var r1t26: UITextField!
    @IBOutlet weak var r1t27: UITextField!
    @IBOutlet weak var r1t28: UITextField!
    @IBOutlet weak var r1t29: UITextField!
    @IBOutlet weak var r1t30: UITextField!
    @IBOutlet weak var r1t31: UITextField!
    @IBOutlet weak var r1t32: UITextField!
    
    @IBOutlet weak var r2t1: UITextField!
    @IBOutlet weak var r2t2: UITextField!
    @IBOutlet weak var r2t3: UITextField!
    @IBOutlet weak var r2t4: UITextField!
    @IBOutlet weak var r2t5: UITextField!
    @IBOutlet weak var r2t6: UITextField!
    @IBOutlet weak var r2t7: UITextField!
    @IBOutlet weak var r2t8: UITextField!
    @IBOutlet weak var r2t9: UITextField!
    @IBOutlet weak var r2t10: UITextField!
    @IBOutlet weak var r2t11: UITextField!
    @IBOutlet weak var r2t12: UITextField!
    @IBOutlet weak var r2t13: UITextField!
    @IBOutlet weak var r2t14: UITextField!
    @IBOutlet weak var r2t15: UITextField!
    @IBOutlet weak var r2t16: UITextField!
    
    @IBOutlet weak var r3t1: UITextField!
    @IBOutlet weak var r3t2: UITextField!
    @IBOutlet weak var r3t3: UITextField!
    @IBOutlet weak var r3t4: UITextField!
    @IBOutlet weak var r3t5: UITextField!
    @IBOutlet weak var r3t6: UITextField!
    @IBOutlet weak var r3t7: UITextField!
    @IBOutlet weak var r3t8: UITextField!
    
    @IBOutlet weak var r4t1: UITextField!
    @IBOutlet weak var r4t2: UITextField!
    @IBOutlet weak var r4t3: UITextField!
    @IBOutlet weak var r4t4: UITextField!
    
    @IBOutlet weak var f5t1: UITextField!
    @IBOutlet weak var f5t2: UITextField!
    
    @IBOutlet weak var f1: UITextField!
    
    // RIGHT SIDE OUTLETS
    @IBOutlet weak var f2: UITextField!
    
    @IBOutlet weak var f5t3: UITextField!
    @IBOutlet weak var f5t4: UITextField!
    
    @IBOutlet weak var r4t5: UITextField!
    @IBOutlet weak var r4t6: UITextField!
    @IBOutlet weak var r4t7: UITextField!
    @IBOutlet weak var r4t8: UITextField!
    
    @IBOutlet weak var r3t9: UITextField!
    @IBOutlet weak var r3t10: UITextField!
    @IBOutlet weak var r3t11: UITextField!
    @IBOutlet weak var r3t12: UITextField!
    @IBOutlet weak var r3t13: UITextField!
    @IBOutlet weak var r3t14: UITextField!
    @IBOutlet weak var r3t15: UITextField!
    @IBOutlet weak var r3t16: UITextField!
    
    @IBOutlet weak var r2t17: UITextField!
    @IBOutlet weak var r2t18: UITextField!
    @IBOutlet weak var r2t19: UITextField!
    @IBOutlet weak var r2t20: UITextField!
    @IBOutlet weak var r2t21: UITextField!
    @IBOutlet weak var r2t22: UITextField!
    @IBOutlet weak var r2t23: UITextField!
    @IBOutlet weak var r2t24: UITextField!
    @IBOutlet weak var r2t25: UITextField!
    @IBOutlet weak var r2t26: UITextField!
    @IBOutlet weak var r2t27: UITextField!
    @IBOutlet weak var r2t28: UITextField!
    @IBOutlet weak var r2t29: UITextField!
    @IBOutlet weak var r2t30: UITextField!
    @IBOutlet weak var r2t31: UITextField!
    @IBOutlet weak var r2t32: UITextField!
    
    @IBOutlet weak var r1t33: UITextField!
    @IBOutlet weak var r1t34: UITextField!
    @IBOutlet weak var r1t35: UITextField!
    @IBOutlet weak var r1t36: UITextField!
    @IBOutlet weak var r1t37: UITextField!
    @IBOutlet weak var r1t38: UITextField!
    @IBOutlet weak var r1t39: UITextField!
    @IBOutlet weak var r1t40: UITextField!
    @IBOutlet weak var r1t41: UITextField!
    @IBOutlet weak var r1t42: UITextField!
    @IBOutlet weak var r1t43: UITextField!
    @IBOutlet weak var r1t44: UITextField!
    @IBOutlet weak var r1t45: UITextField!
    @IBOutlet weak var r1t46: UITextField!
    @IBOutlet weak var r1t47: UITextField!
    @IBOutlet weak var r1t48: UITextField!
    @IBOutlet weak var r1t49: UITextField!
    @IBOutlet weak var r1t50: UITextField!
    @IBOutlet weak var r1t51: UITextField!
    @IBOutlet weak var r1t52: UITextField!
    @IBOutlet weak var r1t53: UITextField!
    @IBOutlet weak var r1t54: UITextField!
    @IBOutlet weak var r1t55: UITextField!
    @IBOutlet weak var r1t56: UITextField!
    @IBOutlet weak var r1t57: UITextField!
    @IBOutlet weak var r1t58: UITextField!
    @IBOutlet weak var r1t59: UITextField!
    @IBOutlet weak var r1t60: UITextField!
    @IBOutlet weak var r1t61: UITextField!
    @IBOutlet weak var r1t62: UITextField!
    @IBOutlet weak var r1t63: UITextField!
    @IBOutlet weak var r1t64: UITextField!
    
    
    @IBOutlet var round1Cells: [UITextField]!
    
    @IBOutlet var round2Cells: [UITextField]!
    
    @IBOutlet var round3Cells: [UITextField]!
    
    @IBOutlet var round4Cells: [UITextField]!
    
    @IBOutlet var round5Cells: [UITextField]!
    
    @IBOutlet var finalsCells: [UITextField]!
    
    
    @IBOutlet weak var bracketNameLabel: UILabel!
    @IBOutlet weak var championLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        print("yoooo")
//        for i in 1..<33 {
//
//            print("@IBOutlet weak var r1t\(i+32): UITextField!")
//        }
        
        bracketNameLabel.text = "\(theBracket!.title)"
        if theBracket!.rounds[5].matches[0].winnerCheck {
            if theBracket!.rounds[5].matches[0].winner {
                championLabel.text = "Champion:\n\(theBracket!.rounds[5].matches[0].homeTeam)"
            } else {
                championLabel.text = "Champion:\n\(theBracket!.rounds[5].matches[0].awayTeam)"
            }
        } else {
            championLabel.text = "Champion:\n(In Progress)"
        }
        
//        populateRound1()
//        populateRound2()
//        populateRound3()
//        populateRound4()
//        populateRound5()
//        populateFinals()
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
    
    func populateRound3() {
        for i in 0..<round3Cells.count {
            round3Cells[i].isUserInteractionEnabled = false
            round3Cells[i].textColor = UIColor.lightGray

            if theBracket!.rounds[1].matches[i].winnerCheck {
                round3Cells[i].textColor = UIColor.black
                if theBracket!.rounds[1].matches[i].winner {
                    round3Cells[i].text = "\(theBracket!.rounds[1].matches[i].homeTeam)"
                } else {
                    round3Cells[i].text = "\(theBracket!.rounds[1].matches[i].awayTeam)"
                }
            } else {
                round3Cells[i].text = "Round 2 Winner"
            }
            
        }
    }
    
    func populateRound4() {
        for i in 0..<round4Cells.count {
            round4Cells[i].isUserInteractionEnabled = false
            round4Cells[i].textColor = UIColor.lightGray

            if theBracket!.rounds[2].matches[i].winnerCheck {
                round4Cells[i].textColor = UIColor.black
                if theBracket!.rounds[2].matches[i].winner {
                    round4Cells[i].text = "\(theBracket!.rounds[2].matches[i].homeTeam)"
                } else {
                    round4Cells[i].text = "\(theBracket!.rounds[2].matches[i].awayTeam)"
                }
            } else {
                round4Cells[i].text = "Round 3 Winner"
            }
            
        }
    }
    
    func populateRound5() {
        for i in 0..<round5Cells.count {
            round5Cells[i].isUserInteractionEnabled = false
            round5Cells[i].textColor = UIColor.lightGray

            if theBracket!.rounds[3].matches[i].winnerCheck {
                round5Cells[i].textColor = UIColor.black
                if theBracket!.rounds[3].matches[i].winner {
                    round5Cells[i].text = "\(theBracket!.rounds[3].matches[i].homeTeam)"
                } else {
                    round5Cells[i].text = "\(theBracket!.rounds[3].matches[i].awayTeam)"
                }
            } else {
                round5Cells[i].text = "Round 4 Winner"
            }
            
        }
    }
    
    func populateFinals() {
        for i in 0..<finalsCells.count {
            finalsCells[i].isUserInteractionEnabled = false
            finalsCells[i].textColor = UIColor.lightGray

            if theBracket!.rounds[4].matches[i].winnerCheck {
                finalsCells[i].textColor = UIColor.black
                if theBracket!.rounds[4].matches[i].winner {
                    finalsCells[i].text = "\(theBracket!.rounds[4].matches[i].homeTeam)"
                } else {
                    finalsCells[i].text = "\(theBracket!.rounds[4].matches[i].awayTeam)"
                }
            } else {
                finalsCells[i].text = "Finalist"
            }
            
        }
    }
    
    
    
    @IBAction func backButton(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToBracket6", sender: nil)
    }

}
