import UIKit

class SlotReelsViewController: UIViewController {
    
    // MARK: - Data
    private let symbols = ["🍎", "🍒", "🍋", "⭐️", "🔔"]
    private var timer: Timer?
    private var coinBalance: Int {
        get {
            return UserDefaults.standard.integer(forKey: "CoinBalance")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "CoinBalance")
        }
    }
    private var betAmount: Int {
        get {
            return UserDefaults.standard.integer(forKey: "BetAmount")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "BetAmount")
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var reelsStackView: UIStackView!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var coinsLabel: UILabel!
    @IBOutlet weak var viewcoinsLabel: UILabel!
    @IBOutlet weak var betAmountTextField: UITextField!
    @IBOutlet weak var betView: UIView!
    @IBOutlet weak var coinImage: UIImageView!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupReelsSafely()
        updateCoinsLabel()
        betAmountTextField.text = "\(betAmount)"
        if betAmount > 0
        {
            betView.isHidden = true
        }
        viewcoinsLabel.text = coinsLabel.text
        
        let jeremyGif = UIImage.gifImageWithName("ththt")
        coinImage.image = jeremyGif
    }
    
    // MARK: - Setup Reels
    private func setupReelsSafely() {
        guard reelsStackView != nil else {
            print("reelsStackView is nil!")
            return
        }
        for label in reelsStackView.arrangedSubviews {
            if let reelLabel = label as? UILabel {
                reelLabel.text = symbols.randomElement()
            }
        }
    }
    
    private func updateCoinsLabel() {
        coinsLabel.text = "\(coinBalance)"
        viewcoinsLabel.text = coinsLabel.text
    }
    
    // MARK: - Actions
    
    @IBAction func addBetAmount(_ sender: UIButton) {
        guard let bet = Int(betAmountTextField.text ?? "0"), bet > 0, bet <= coinBalance else {
           // resultLabel.text = "Invalid Bet Amount!"
            showAlert(title: "Invalid Bet Amount", message: "Please ensure you enter a valid amount that does not exceed your current coin balance.")
            return
        }
        betView.isHidden = true
        betAmount = bet
    }
    
    @IBAction func didTapSpin(_ sender: UIButton) {
        
        
        guard let bet = Int(betAmountTextField.text ?? "0"), bet > 0, bet <= coinBalance else {
            
            betView.isHidden = false
            resultLabel.text = "Invalid Bet Amount!"
            return
        }
        
        coinBalance -= bet
        updateCoinsLabel()
        
        spinButton.isEnabled = false
        resultLabel.text = "Spinning..."
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.updateReels()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.timer?.invalidate()
            self?.timer = nil
            self?.checkResult()
            self?.spinButton.isEnabled = true
        }
    }
    
    private func updateReels() {
        for label in reelsStackView.arrangedSubviews {
            if let reelLabel = label as? UILabel {
                reelLabel.text = symbols.randomElement()
            }
        }
    }
    
    private func checkResult() {
        let middleSymbols = reelsStackView.arrangedSubviews.compactMap { ($0 as? UILabel)?.text }
        
        // Check for a perfect match (all three symbols are the same)
        if Set(middleSymbols).count == 1 {
            let reward = betAmount * 5 // Example: 5x reward multiplier
            coinBalance += reward
            resultLabel.text = "🎉 JACKPOT! You matched all three symbols and won \(reward) coins! 🎉"
        }
        // Check for two matching symbols
        else if middleSymbols[0] == middleSymbols[1] || middleSymbols[1] == middleSymbols[2] || middleSymbols[0] == middleSymbols[2] {
            let partialReward = 10 // Example: 10 coins for two matches
            coinBalance += partialReward
            resultLabel.text = "🎉 You matched two symbols and earned \(partialReward) coins!"
        }
        // No match
        else {
            let loss = betAmount / 2 // Example: Lose half the bet amount
            coinBalance -= loss
            resultLabel.text = "No match. You lost \(loss) coins. Try again!"
        }
        
        // Update coins label
        updateCoinsLabel()
        
        // Check if the user is out of coins
        if coinBalance <= 0 {
            resultLabel.text = "You're out of coins! Please restart the game."
            showAlertAndRestart()
        }
    }
    
    private func showAlertAndRestart() 
    {
        let alert = UIAlertController(
            title: "Game Over",
            message: "You have run out of coins. Please save your score and restart the game.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Add Score", style: .default, handler: { _ in
            // Navigate back to the previous screen
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "AddScoresViewController") as! AddScoresViewController
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.score = "\(self.coinBalance)"
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }

    
    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }
    
    @IBAction func backbuttonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    @IBAction func addScorePressed(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AddScoresViewController") as! AddScoresViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.score = "\(self.coinBalance)"
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }

}
