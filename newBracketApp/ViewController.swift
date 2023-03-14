//
//  ViewController.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/8/23.
//



import UIKit


import FirebaseCore
import FirebaseDatabase
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    
    
    var ref: DatabaseReference!
    var brackates: [BracketObject] = []
    var rowPick: Int = 0
    
    @IBOutlet weak var tableviewOutlet: UITableView!
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.observe(.childAdded, with: { (snapshot) in
            print("reading firebase")
                   // snapshot is a dictionary with a key and a dictionary as a value
                    // this gets the dictionary from each snapshot
                    let dict = snapshot.value as! [String:Any]
                   
                    // building a Student object from the dictionary
                    let s = BracketObject(dict: dict)
                    // adding the student object to the Student array
                    self.brackates.append(s)
        // should only add the student if the student isn’t already in the array
        // good place to update the tableview also
                    
                })

        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableClick"{
            let nvc = segue.destination as! BracketViewController
            nvc.bigBracket = brackates[rowPick]
        }
        else if segue.identifier == "bracketSegue"{
            let nvc = segue.destination as! NewBracketViewController
        }
    }

    @IBAction func unwind(seg: UIStoryboardSegue)
    {
        tableviewOutlet.reloadData()
    }
    
    @IBAction func enterKeyButton(_ sender: UIButton)
    {
        
        
        performSegue(withIdentifier: "bracketSegue", sender: nil)
    }
    

}

