//
//  CreatorViewController.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/9/23.
//




import UIKit

class CreatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // added a comment
    
    @IBOutlet weak var numOutlet: UITextField!

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
    var brackates: [BracketObject] = []
    var visIndex = 0
    var numbers: [Int] = []
    var createdBracks: [BracketObject] = []

    
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
        
        if let items = UserDefaults.standard.data(forKey: "createdBrackets") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([BracketObject].self, from: items) {
                createdBracks = decoded
            }
        }
        
        
    }
    

    @IBAction func addTeamButton(_ sender: UIButton) {
        var canAdd = true
        
        for i in 0..<teams.count {
            if textfieldOutlet.text == teams[i] {
                let theAlert = UIAlertController(title: "Duplicate Team", message: "Make sure every team name is different", preferredStyle: .alert)
                let yesAction = UIAlertAction(title: "Ok", style: .destructive)
                theAlert.addAction(yesAction)
                present(theAlert, animated: true, completion: nil)
                canAdd = false
                break
            }
            else {
                canAdd = true
            }
        }
        
        if textfieldOutlet.text == "" {
            let theAlert = UIAlertController(title: "Enter a Team", message: "Enter a team name in the box on the left", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Ok", style: .destructive)
            theAlert.addAction(yesAction)
            present(theAlert, animated: true, completion: nil)
        }
        
        else if teams.count < 64 && canAdd {
            if let x = textfieldOutlet.text {
                teams.append(x)
                tableViewOutlet.reloadData()
                textfieldOutlet.text = ""
                
            }
            
        } else {
            let theAlert = UIAlertController(title: "Too many teams", message: "The bracket can only hold up to 64 teams", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Ok", style: .destructive)
            theAlert.addAction(yesAction)
            present(theAlert, animated: true, completion: nil)
        }
        
        
        
        
    }
    

    @IBAction func quickCreate(_ sender: UIButton) {
        var toAdd : Int = 0
        var canAdd = true
        
        if let blah = Int(numOutlet.text!) {
            toAdd = blah
        } else {
            let theAlert = UIAlertController(title: "Not a valid input", message: "Enter an integer between 3 and 64", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Ok", style: .destructive)
            theAlert.addAction(yesAction)
            present(theAlert, animated: true, completion: nil)
            canAdd = false
        }
        
        if canAdd {
            
            if toAdd < 3
            {
                let theAlert = UIAlertController(title: "Not enough teams", message: "The bracket needs at least 3 teams to be created", preferredStyle: .alert)
                let yesAction = UIAlertAction(title: "Ok", style: .destructive)
                theAlert.addAction(yesAction)
                present(theAlert, animated: true, completion: nil)
            }
            
            else if toAdd > 64
            {
                let theAlert = UIAlertController(title: "Too many teams", message: "The bracket can only hold up to 64 teams", preferredStyle: .alert)
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
            let yesAction = UIAlertAction(title: "Yes", style: .default) { action in
                for i in 0..<toAdd {
                    self.teams.append("Team \(i+1)")
                }
                self.performSegue(withIdentifier: "createBracket", sender: self)
            }
            let noAction = UIAlertAction(title: "No", style: .destructive)
            alert.addAction(yesAction)
            alert.addAction(noAction)
            present(alert, animated: true, completion: nil)
            
            name = nameOutlet.text!
        }
        
    }
   
    @IBAction func createButton(_ sender: UIButton)
    {
       
        //alert controller to confirm
        
        
        if teams.count < 3
        {
            let theAlert = UIAlertController(title: "Not enough teams", message: "The bracket needs at least 3 teams to be created", preferredStyle: .alert)
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
        
        for i in brackates
        {
            if keyTextField.text == i.bracketKey
            {
                let theAlert = UIAlertController(title: "Bracket code already in use", message: "Enter a different bracket code", preferredStyle: .alert)
                let yesAction = UIAlertAction(title: "Ok", style: .destructive)
                theAlert.addAction(yesAction)
                present(theAlert, animated: true, completion: nil)
            }
        }
        
        let alert = UIAlertController(title: "Are you sure?", message: "Is the bracket complete?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { action in
            self.performSegue(withIdentifier: "createBracket", sender: self)
        }
        let noAction = UIAlertAction(title: "No", style: .destructive)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
        
        name = nameOutlet.text!
        
        print(rounds)
        
            
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isMovingFromParent{
            performSegue(withIdentifier: "unwind25", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        

        if segue.identifier == "createBracket"
        {
            makeBracket(teams: teams)
            matches = seeds(teams: teams)
            rounding = makeRounds(rounds2: matches, r: rounds)
            Bracket1 = BracketObject(title: name, rounds: rounding, bracketKey: keyTextField.text!)
            Bracket1.bracketKey = keyTextField.text!
            byeCheck()
            Bracket1.owner = true
            Bracket1.saveToFirebase()
            createdBracks.append(Bracket1)
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(createdBracks) {
                    UserDefaults.standard.set(encoded, forKey: "createdBrackets")
            }
            
            let nvc = segue.destination as! BracketViewController
            nvc.teams = teams
            nvc.bigBracket = Bracket1
            nvc.rounds = rounds
            nvc.teamCheck = teamCheck
            nvc.visibleIndex = visIndex
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
                print("Perfect")
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
                    str1 = "Winner                                            masonshouldntgotoalabama"
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
                    str2 = "Winner masonshouldntgotoalabama"
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
    
    func seeds(teams: [String])-> [MatchupClass]
    {
            var matches: [MatchupClass] = []
            var perfect = false
            var count = teams.count
            var start = 0
            var bies = 0
            var teams2 = teams
            var end = teams.count
            //checks for perfect square
            
        var count2 = count
            while count2 > 1
            {
                if count2%2 == 0
                {
                    perfect = true
                    count2 = count2/2
                }
                else
                {
                    perfect = false
                    break
                }
            }
            // how many byes

            if perfect == false
            {
                var pow = 4
                while pow < count
                {
                   pow = pow*2
                }
                bies = pow-count
            }

            

            // adds matches by seeds for a perfect bracket

            if perfect == true
            {
                while start < end
                {
                    matches.append(MatchupClass(hTeam: teams[start], aTeam: teams[end-1], hScore: 0, aScore: 0, match: true))
                    start+=1
                    end-=1
                }
                
                var even: [MatchupClass] = []
                var odd: [MatchupClass] = []
                while matches.count > 0
                {
                    odd.append(matches.remove(at: 0))
                    even.append(matches.remove(at: 0))
                }
                
                if teams.count > 31
                {
                    var o1: [MatchupClass] = []
                    var o2: [MatchupClass] = []
                    var e1: [MatchupClass] = []
                    var e2: [MatchupClass] = []
                    
                    //odd side
                    while odd.count > 0
                    {
                        o1.append(odd.remove(at: 0))
                        o2.append(odd.remove(at: 0))
                    }
                    o2.reverse()
                    
                    while o1.count > 0 || o2.count > 0
                    {
                        matches.append(o1.remove(at: 0))
                        matches.append(o2.remove(at: 0))
                    }
                    
                    
                    //even side
                    while even.count > 0
                    {
                        e1.append(even.remove(at: 0))
                        e2.append(even.remove(at: 0))
                    }
                    e2.reverse()
                    
                    while e1.count > 0 || e2.count > 0
                    {
                        matches.append(e1.remove(at: 0))
                        matches.append(e2.remove(at: 0))
                    }
                    
                }
                else
                {
                    even.reverse()
                    
                    while even.count > 0 || odd.count > 0
                    {
                        matches.append(odd.remove(at: 0))
                        matches.append(even.remove(at: 0))
                    }
                }
            }

            // adds matches by seeds for a bracket with bies
            else
            {
                while bies > 0
                {
                    teams2.append("BYE")
                    bies = bies - 1
                }
                end = teams2.count - 1

                while start < end
                {
                    if teams2[end] == "BYE"
                    {
                        matches.append(MatchupClass(hTeam: teams2[start], aTeam: teams2[end], hScore: 0, aScore: 0, match: false))
                        start+=1
                        end-=1
                    }

                    else
                    {
                        matches.append(MatchupClass(hTeam: teams2[start], aTeam: teams2[end], hScore: 0, aScore: 0, match: true))
                        start+=1
                        end-=1
                    }

                }
                
                var even: [MatchupClass] = []
                var odd: [MatchupClass] = []
                
                while matches.count > 0
                {
                    odd.append(matches.remove(at: 0))
                    even.append(matches.remove(at: 0))
                }
                
                if teams.count > 31
                {
                    if teams.count > 31
                    {
                        var o1: [MatchupClass] = []
                        var o2: [MatchupClass] = []
                        var e1: [MatchupClass] = []
                        var e2: [MatchupClass] = []
                        
                        //odd side
                        while odd.count > 0
                        {
                            o1.append(odd.remove(at: 0))
                            o2.append(odd.remove(at: 0))
                        }
                        o2.reverse()
                        
                        while o1.count > 0 || o2.count > 0
                        {
                            matches.append(o1.remove(at: 0))
                            matches.append(o2.remove(at: 0))
                        }
                        
                        
                        //even side
                        while even.count > 0
                        {
                            e1.append(even.remove(at: 0))
                            e2.append(even.remove(at: 0))
                        }
                        e2.reverse()
                        
                        while e1.count > 0 || e2.count > 0
                        {
                            matches.append(e1.remove(at: 0))
                            matches.append(e2.remove(at: 0))
                        }
                        
                    }
                    else
                    {
                        even.reverse()
                        
                        while even.count > 0 || odd.count > 0
                        {
                            matches.append(odd.remove(at: 0))
                            matches.append(even.remove(at: 0))
                        }
                    }
                }
                else
                {
                    even.reverse()
                        
                    while even.count > 0 || odd.count > 0
                    {
                        matches.append(odd.remove(at: 0))
                        matches.append(even.remove(at: 0))
                    }
                }
            }
           return matches
        }

    func byeCheck(){
        var matNum = Bracket1.rounds[0].matches.count
        for i in 0 ..< matNum{
            if !Bracket1.rounds[0].matches[i].isMatch{
                Bracket1.rounds[0].matches[i].winnerCheck = true
                if i%2 == 0{
                    Bracket1.rounds[1].matches[(i/2)].homeTeam = Bracket1.rounds[0].matches[i].homeTeam
                    print("BOOOOO")
                }
                else {
                    Bracket1.rounds[1].matches[(i/2)].awayTeam = Bracket1.rounds[0].matches[i].homeTeam
                    print("hooray!")
                }
            }
        }
    }
    
    
    @IBAction func goBackButton(_ sender: UIButton) {
        performSegue(withIdentifier: "unwind25", sender: nil)
    }
    
    
}
