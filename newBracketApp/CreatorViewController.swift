//
//  CreatorViewController.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/9/23.
//




import UIKit

class CreatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // added a comment
    
    

    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var textfieldOutlet: UITextField!
    @IBOutlet weak var nameOutlet: UITextField!
     var teams: [String] = []
     var numberOfTeams = 0
    var matches: [MatchupClass] = []
    var teamCheck = false
    var rounds = 0
    var name = ""
    var Bracket1: BracketObject!
    var rounding:[RoundClass] = []
    var seededMatches: [MatchupClass] = []

    
    @IBOutlet weak var tableViewOutlet: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
print("I'm having fun!")
        // Do any additional setup after loading the view.
        
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        tableViewOutlet.dragInteractionEnabled = true
        tableViewOutlet.isEditing = true
        tableViewOutlet.allowsSelectionDuringEditing = true
    }
    
    @IBAction func addTeamButton(_ sender: UIButton) {
        if let x = textfieldOutlet.text {
            teams.append(x)
            tableViewOutlet.reloadData()
            textfieldOutlet.text = ""
            
        }
    }
    

   
    @IBAction func createButton(_ sender: UIButton)
    {
       
        //alert controller to confirm
        
        
        if teams.count < 3
        {
            let theAlert = UIAlertController(title: "Not enough teams", message: "The bracket needs at least 3 teams", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Ok", style: .destructive)
            theAlert.addAction(yesAction)
            present(theAlert, animated: true, completion: nil)
        }
        
        else if nameOutlet.text == ""
        {
            let theAlert = UIAlertController(title: "No bracket name", message: "Enter a bracket name", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Ok", style: .destructive)
            theAlert.addAction(yesAction)
            present(theAlert, animated: true, completion: nil)
        }
        
        
        else if keyTextField.text == "" || keyTextField.text == nil
        {
            let theAlert = UIAlertController(title: "No bracket code", message: "Enter a bracket code", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Ok", style: .destructive)
            theAlert.addAction(yesAction)
            present(theAlert, animated: true, completion: nil)
        }
        
        let alert = UIAlertController(title: "Are you sure?", message: "Is the bracket complete?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { action in
            self.performSegue(withIdentifier: "createBracket", sender: self)
        }
        let noAction = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
        
        name = nameOutlet.text!
        
        print(rounds)
        
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        makeBracket(teams: teams)
        matches = seeds(teams: teams)
        rounding = makeRounds(rounds2: matches, r: rounds)
        Bracket1 = BracketObject(title: name, rounds: rounding)
        Bracket1.bracketKey = keyTextField.text!
        Bracket1.saveToFirebase()
        if segue.identifier == "createBracket"
        {
            
            let nvc = segue.destination as! BracketViewController
            nvc.teams = teams
            nvc.bigBracket = Bracket1
            nvc.rounds = rounds
            nvc.teamCheck = teamCheck
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "teamCell")!
        cell.textLabel?.text = teams[indexPath.row]
        cell.detailTextLabel?.text = "Seed: \(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            teams.remove(at: indexPath.row)
            tableViewOutlet.deleteRows(at: [indexPath], with: .fade)
            tableViewOutlet.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        teams.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        tableViewOutlet.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    //Making this do the whole bracket (Trying). The number is the amount of people who move on to round 2 without having to play anyone. Should be correct.
    func makeBracket(teams: [String]){
        //checks if a bracket is a power of 2 or even
        var tempTeams = teams
        var check = false
        var bies = 0
        var perfect = false
        var count = teams.count
        var firstRoundMatches: Int
        rounds = 0
        if (count%2 == 0){
            while (count%2 == 0 ){
                count = count/2
            }
            if (count == 1){
                perfect = true
                count = teams.count
                Swift.print("Perfect")
            }
            else{
                perfect = false
                count = teams.count
            }
        }
        if(!perfect){
            while(!check){
                count+=1
                bies+=1
                if (count%2 == 0){
                    var temp = count
                    while (temp%2 == 0 ){
                        temp = temp/2
                    }
                    if (temp == 1){
                       check = true
                    }
                }
            }
        }
       
        firstRoundMatches = firstRoundMatchesCalc(perfect: perfect, teams: teams, bies: bies)
        var newCount = firstRoundMatches
        newCount = (firstRoundMatches + bies)/2
        rounds = 2
        while(newCount != 1){
            newCount = newCount/2
            rounds += 1
        }
//        addSegueButtons(rounds2: rounds)
        
        
        matches = seeds(teams: teams)
        
        //this if else covers first round matches and places them into the table, we need to find a way to show a seperate table for seperate matches
//        if(perfect){
//            var teamsTemp = teams
//            for _ in 0..<firstRoundMatches {
//                matches.append(MatchupClass.init(hTeam:tempTeams[0], aTeam: tempTeams[1], hScore: 0, aScore: 0, match: true))
//                print(teamsTemp)
//                tempTeams.remove(at: 0)
//                tempTeams.remove(at:0)
//                print(matches[0].homeTeam)
//            }
//            make table just print one array[0] and array [1] into each seperate spot and then delete them from the temporary array this is only minimum and first round only populate table with first round matches cells only
//        }
//        else{
//            var teamsTemp = teams
//            for _ in 0..<firstRoundMatches {
//                matches.append(MatchupClass.init(hTeam:tempTeams[0], aTeam: tempTeams[1], hScore: 0, aScore: 0, match: true))
//                print(teamsTemp)
//                tempTeams.remove(at: 0)
//                tempTeams.remove(at:0)
//                print(matches[0].homeTeam)
//            }
//            for _ in 0..<bies
//            {
//                matches.append(MatchupClass.init(hTeam: tempTeams[0], aTeam: "BYE", hScore: 0, aScore: 0, match: false))
//                tempTeams.remove(at: 0)
//            }
//
//  populate table with only the amount of cells as first round matches and only run the loop to put people in that many times
//        }
//        print("Test")
//        print(rounds)
    }
    
    //calclulates first roundMatches
    func firstRoundMatchesCalc(perfect: Bool, teams: [String], bies: Int)-> Int{
        var firstRoundMatches = 0
        if(perfect){
            firstRoundMatches = teams.count/2
        }
        else{
            firstRoundMatches = (teams.count+bies)/2 - bies
        }
        return firstRoundMatches
    }
    
    func randomSeeds(teams: [String])
    {
        self.teams.shuffle()
        tableViewOutlet.reloadData()
    }
    
    @IBAction func shuffleButton(_ sender: UIButton) {
        randomSeeds(teams: teams)
    }
    
    //This creates a dictionary of rounds which can be updated by the table
    
    func makeRounds(rounds2: [MatchupClass], r: Int) -> [RoundClass]{
        
        var rounder: [RoundClass] = []
        rounder.append(RoundClass(bMatches: matches, brounds: 1))
        for i in 1 ..< r {
            var ron = RoundClass(bMatches: rounds2, brounds: 0)
            ron = newRound(rounds: rounder[i-1] , r: i+1)
            rounder.append(ron)
            
        }
        return rounder
    }
    
   
        
    //This creates a round based on the round before it
    func newRound(rounds: RoundClass, r: Int) -> RoundClass{
        var mats = rounds.matches
        var str1 = ""
        var str2 = ""
        var bool = true
        var newMats: [MatchupClass] = []
        
        for i in 0 ..< mats.count {
            if bool{
                if mats[i].winnerCheck == false{
                    str1 = "Winner of round \(i+1) masonshouldntgotoalabama"
                }
                else{
                    if mats[i].winnerCheck{
                        str1 = mats[i].homeTeam
                    }
                    else{
                        str1 = mats[i].awayTeam
                    }
                }
                bool = false
            }
            else{
                if mats[i].winnerCheck == false{
                    str2 = "Winner of round \(i+1) masonshouldntgotoalabama"
                }
                else{
                    if mats[i].winnerCheck{
                        str2 = mats[i].homeTeam
                    }
                    else{
                        str2 = mats[i].awayTeam
                    }
                }

                newMats.append(MatchupClass(hTeam: str1, aTeam: str2, hScore: 0, aScore: 0, match: true))
                bool = true
            }
        }
        let nRound = RoundClass(bMatches: newMats, brounds: r)
        
        return nRound
    }
    
    func seeds(teams: [String])-> [MatchupClass]{
        var matches: [MatchupClass] = []
        var perfect = false
        var count = teams.count
        var start = 0
        var bies = 0
        var teams2 = teams
        var end = teams2.count

        //checks for perfect square
        var count2 = count
        while count2 > 1{
            if count2%2 == 0{
                perfect = true
                count2 = count/2
            }
            else{
                perfect = false
                break
            }
        }
        
        // how many byes
        if perfect == false{
            
            var pow = 4
            while pow < count{
               pow = pow*2
            }
            bies = pow-count
            
        }
        
        // adds matches by seeds for a perfect bracket
        if perfect == true{
            var a = 0
            var b = 1
            var c = 1
            while start < end{
                if a % 2 == 0{
                    matches.insert(MatchupClass(hTeam: teams2[start], aTeam: teams2[end], hScore: 0, aScore: 0, match: true), at: matches.count - b)
                    b+=1
                    start+=1
                    end-=1
                }
                else{
                    matches.insert(MatchupClass(hTeam: teams2[start], aTeam: teams2[end], hScore: 0, aScore: 0, match: true), at: c)
                    c+=1
                    start+=1
                    end-=1
                }
                a+=1
            }
        }
        // adds matches by seeds for a bracket with bies
        else{
            while bies > 0{
                teams2.append("BYE")
                bies = bies - 1
            }
            end = teams2.count - 1
            
            
            var n = 0
            var x = 1
            var y = 1
            while start < end{
                if teams2[end] == "BYE"{
                    if n > 2{
                        if n % 2 == 0{
                            matches.insert(MatchupClass(hTeam: teams2[start], aTeam: teams2[end], hScore: 0, aScore: 0, match: false), at: matches.count - x)
                            x+=1
                            start+=1
                            end-=1
                        }
                        else{
                            matches.insert(MatchupClass(hTeam: teams2[start], aTeam: teams2[end], hScore: 0, aScore: 0, match: false), at: y)
                            y+=1
                            start+=1
                            end-=1
                        }
                    }
                }
                else{
                    if n % 2 == 0{
                        matches.insert(MatchupClass(hTeam: teams2[start], aTeam: teams2[end], hScore: 0, aScore: 0, match: true), at: matches.count - x)
                        x+=1
                        start+=1
                        end-=1
                    }
                    else{
                        matches.insert(MatchupClass(hTeam: teams2[start], aTeam: teams2[end], hScore: 0, aScore: 0, match: true), at: y)
                        y+=1
                        start+=1
                        end-=1
                    }
                }
                n+=1
            }
        }
       return matches
    }
    
    
}
