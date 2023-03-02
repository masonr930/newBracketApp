//
//  ViewController.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/8/23.
//



import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    
    
    
    var brackates: [BracketObject] = []
    var rowPick: Int = 0
    
    @IBOutlet weak var tableviewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        tableviewOutlet.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brackates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableviewOutlet.dequeueReusableCell(withIdentifier: "bracketCell")
        cell!.textLabel!.text = brackates[indexPath.row].title
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowPick = indexPath.row
        performSegue(withIdentifier: "tableClick", sender: nil)
      }

    @IBAction func unwind(seg: UIStoryboardSegue)
    {
        let svc = seg.source as! ViewController
    }

}

