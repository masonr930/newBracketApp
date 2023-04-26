//
//  FinalWinnerViewController.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/27/23.
//

import UIKit

class FinalWinnerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableviewOutlet: UITableView!
    var medalists: [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        medalists.reverse()
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medalists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableviewOutlet.dequeueReusableCell(withIdentifier: "myCell")
        cell?.textLabel?.text = medalists[indexPath.row]
        cell?.detailTextLabel?.text = "\(indexPath.row + 1)"
        return cell!
    }
    
}
