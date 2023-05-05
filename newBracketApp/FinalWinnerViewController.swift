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
        
        if indexPath.row == 0
        {
            cell!.backgroundColor = UIColor(red: 255.0/255, green: 215.0/255, blue: 0.0, alpha: 1)
        }
        else if indexPath.row == 1
        {
            cell!.backgroundColor = UIColor(red: 192.0/255, green: 192.0/255, blue: 192.0/255, alpha: 1)
        }
        else
        {
            cell!.backgroundColor = UIColor(red: 205.0/255, green: 127.0/255, blue: 50.0/255, alpha: 1)
        }
        return cell!
    }
    
}
