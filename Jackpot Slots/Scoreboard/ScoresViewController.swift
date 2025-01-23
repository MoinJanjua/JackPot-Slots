//
//  ScoresViewController.swift
//  Jackpot Slots
//
//  Created by Unique Consulting Firm on 10/01/2025.
//

import UIKit

class ScoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak var usernameLb: UILabel!
    @IBOutlet weak var scorelb: UILabel!
    @IBOutlet weak var nodatalb: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Data
    private var scores: [(name: String, score: Int, date: String)] = []
    private var sortedScores: [(name: String, score: Int, date: String)] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        nodatalb.isHidden = true
        loadScoresFromUserDefaults()
        sortScoresAndUpdateUI()
    }

    // MARK: - Load Scores
    private func loadScoresFromUserDefaults() {
        if let savedScores = UserDefaults.standard.array(forKey: "SlotGameScores") as? [[String: Any]] {
            scores = savedScores.compactMap {
                guard let name = $0["name"] as? String,
                      let score = $0["score"] as? Int,
                      let date = $0["date"] as? String else { return nil }
                return (name: name, score: score, date: date)
            }
        }
        
        if scores.isEmpty
        {
            nodatalb.isHidden = false
        }
    }
    
    // MARK: - Sorting and UI Update
    private func sortScoresAndUpdateUI() {
        // Sort scores by highest score
        sortedScores = scores.sorted { $0.score > $1.score }
        
        // Update highest score and username labels
        if let topScore = sortedScores.first {
            usernameLb.text = "Top Player: \(topScore.name)"
            scorelb.text = "High Score: \(topScore.score)"
        }
        
        // Reload table view
        tableView.reloadData()
    }

    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedScores.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ScoresTableViewCell else {
            return UITableViewCell()
        }
        
        let score = sortedScores[indexPath.row]
        let rank = indexPath.row + 1
        
        // Configure cell
        cell.usernameLb.text = score.name
        cell.scorelb.text = "Scores :\(score.score)"
        cell.rankLb.text = "\(rank)"
        
        // Update rank label color
        switch rank {
        case 1:
            cell.rankLb.textColor = .green
        case 2:
            cell.rankLb.textColor = .yellow
        case 3:
            cell.rankLb.textColor = .red
        default:
            cell.rankLb.textColor = .black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    @IBAction func backbuttonPressed(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SlotGameViewController") as! SlotGameViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }
}
