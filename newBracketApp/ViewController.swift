//
//  ViewController.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/8/23.
//
// MASON THIS IS THE GOOD ONE NOT THE OTHER ONE DONT DELETE THIS CAUSE THIS ONE IS THE ONE!!!!!!!!
//
//
// THIS ONE ********************
//
//
//

class AppData {
   static var loaded = false
}

import UIKit


import FirebaseCore
import FirebaseDatabase
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    
    
    var ref: DatabaseReference!
    var brackates: [BracketObject] = []
    var rowPick: Int = 0
    var visible: [BracketObject] = []
    
    @IBOutlet weak var tableviewOutlet: UITableView!
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = UserDefaults.standard.data(forKey: "visibleBrackets") {
                        let decoder = JSONDecoder()
                        if let decoded = try? decoder.decode([BracketObject].self, from: items) {
                            visible = decoded
                        }
                }
        ref = Database.database().reference()
        tableviewOutlet.dataSource = self
        tableviewOutlet.delegate = self
          
                   // snapshot is a dictionary with a key and a dictionary as a value
                    // this gets the dictionary from each snapshot
        
        ref.observe(.childAdded, with: { (snapshot) in
            if !AppData.loaded{
                
                print("reading firebase")
                let dict = snapshot.value as! [String:Any]
                print("Timer2")
                // building a Student object from the dictionary
                let s = BracketObject(dict: dict, reference: snapshot.key)
                print("timer3")
                // adding the student object to the Student array
                self.brackates.append(s)
                print("timer4")
            }
            // should only add the student if the student isn’t already in the array
            // good place to update the tableview also
                print("Trying to reload data")
                self.tableviewOutlet.reloadData()
                    })
        
        
        
        ref.observe(.childChanged) { snapshot  in
            print("changing")
           var replaced = false
            let dict = snapshot.value as! [String:Any]
            let s = BracketObject(dict: dict, reference: snapshot.key)
            s.fireKey = snapshot.key
            print(s.made)
            for i in 0 ..< self.brackates.count {
                print("count is \(self.brackates.count)")
//                print("FireKey is")
//                print(self.brackates[i].fireKey)
//                print("Normal Key")
//                print(s.fireKey)
                if s.fireKey == self.brackates[i].fireKey{
                    print(i)
                    replaced = true
                    print("replace")
                    s.made = true
                    self.brackates[i] = s
                    print(self.brackates[i].made)
                    if self.brackates[i].made{
                        s.made = true
                    }
                    else{
                        s.made = true
                        print(s.made)
                        print("made")
                        self.brackates.append(s)
                        print(self.brackates[self.brackates.count-1].made)
                        self.brackates[i].made = true
                    }
                }
                else{
                    print("Not Replace")
                }
            }
            if !replaced{
                s.made = true
                print("made")
                self.brackates.append(s)
            }
        }

        
                
        tableviewOutlet.reloadData()
        
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        tableviewOutlet.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visible.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableviewOutlet.dequeueReusableCell(withIdentifier: "bracketCell")
        cell!.textLabel!.text = visible[indexPath.row].title
        return cell!
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            visible.remove(at: indexPath.row)
            tableviewOutlet.deleteRows(at: [indexPath], with: .fade)
            tableviewOutlet.reloadData()
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(visible) {
                    UserDefaults.standard.set(encoded, forKey: "visibleBrackets")
            }
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(visible) {
                UserDefaults.standard.set(encoded, forKey: "visibleBrackets")
            print("Delete saved")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowPick = indexPath.row
        doSegue(brack: visible[rowPick])
//        performSegue(withIdentifier: "tableClick", sender: nil)
      }
    
    func doSegue(brack: BracketObject){
        print("Count is")
        print(brack.rounds.count)
        if(brack.owner){
            performSegue(withIdentifier: "tableClick", sender: nil)
        }
        else if brack.rounds.count == 2 {
            performSegue(withIdentifier: "toBracket4", sender: self)
        }
        else if brack.rounds.count == 3 {
            performSegue(withIdentifier: "toBracket8", sender: self)
        }
        else if brack.rounds.count == 4 {
            performSegue(withIdentifier: "toBracket16", sender: self)
        }
        else if brack.rounds.count == 5 {
            performSegue(withIdentifier: "toBracket32", sender: self)
        }
        else if brack.rounds.count == 6 {
            performSegue(withIdentifier: "toBracket64", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        AppData.loaded = true
        if segue.identifier == "tableClick"{
            let nvc = segue.destination as! BracketViewController
            nvc.bigBracket = visible[rowPick]
            nvc.visibleIndex = rowPick
        }
        else if segue.identifier == "create"{
            let nvc = segue.destination as! CreatorViewController
            nvc.brackates = brackates
            nvc.visIndex = visible.count
        }
        else if segue.identifier == "toBracket4"
        {
            let nvc = segue.destination as! Bracket4ViewController
            nvc.theBracket = visible[rowPick]
        }
        else if segue.identifier == "toBracket8"
        {
            let nvc = segue.destination as! Bracket8ViewController
            nvc.theBracket = visible[rowPick]
        }
        else if segue.identifier == "toBracket16"
        {
            let nvc = segue.destination as! Bracket16ViewController
            nvc.theBracket = visible[rowPick]
        }
        else if segue.identifier == "toBracket32"
        {
            let nvc = segue.destination as! NewBracketViewController
            nvc.theBracket = visible[rowPick]
        }
        else if segue.identifier == "toBracket64"
        {
            let nvc = segue.destination as! Bracket64ViewController
            nvc.theBracket = visible[rowPick]
        }
    }

    @IBAction func unwind(seg: UIStoryboardSegue)
    {
        if let items = UserDefaults.standard.data(forKey: "visibleBrackets") {
                        let decoder = JSONDecoder()
                        if let decoded = try? decoder.decode([BracketObject].self, from: items) {
                            visible = decoded
                        }
                }

        tableviewOutlet.reloadData()
    }
    
    @IBAction func unwind10(_seg: UIStoryboardSegue)
    {
        print("AYOO")
        tableviewOutlet.reloadData()
    }
    
    
    @IBAction func enterKeyButton(_ sender: UIButton)
    {
        for i in brackates{
            if (i.bracketKey == textFieldOutlet.text){
                var boo = false
                for j in visible{
                    if j.bracketKey == textFieldOutlet.text{
                        boo = true
                    }
                }
                if !boo{
                    visible.append(i)
                }
                
            }
            let encoder = JSONEncoder()
               if let encoded = try? encoder.encode(visible) {
                                UserDefaults.standard.set(encoded, forKey: "visibleBrackets")
                            }
        }
        tableviewOutlet.reloadData()
    }
    

}

