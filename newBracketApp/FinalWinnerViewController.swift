//
//  FinalWinnerViewController.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/27/23.
//

import UIKit

class FinalWinnerViewController: UIViewController {

    @IBOutlet weak var winnerLabel: UILabel!
    var text: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winnerLabel.text = text
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isMovingFromParent
        {
            performSegue(withIdentifier: "toHome", sender: nil)
        }
    }

    
    @IBAction func backToHome(_ sender: UIButton)
    {
        performSegue(withIdentifier: "toHome", sender: nil)
    }
    
}
