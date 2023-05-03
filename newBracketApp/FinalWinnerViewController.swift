//
//  FinalWinnerViewController.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/27/23.
//

import UIKit

class FinalWinnerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableviewOutlet: UITableView!
    
    var medalists: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewOutlet.dataSource = self
        tableviewOutlet.delegate = self
        
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
        cell!.textLabel!.text = medalists[indexPath.row]
        if indexPath.row + 1 < 3
        {
            cell!.detailTextLabel!.text = "Place: \(indexPath.row + 1)"
        }
        else
        {
            cell!.detailTextLabel!.text = "Place: 3"
        }
        
        
        return cell!
    }
    
}
