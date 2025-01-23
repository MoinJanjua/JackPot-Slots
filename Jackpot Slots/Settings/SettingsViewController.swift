
import UIKit

class SettingsViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var MianView: UIView!
    @IBOutlet weak var SettingTB: UITableView!
    @IBOutlet weak var vesion_Label: UILabel!
    @IBOutlet weak var userView1: UIView!
    
    @IBOutlet weak var userBioLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var UserProfileShow: UIImageView!
    
    
    var settingList = [String]()
    //var settingImgs = ["h","a","c","f","s","p"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //applyCornerRadiusToBottomCorners(view: MianView, cornerRadius: 35)
        settingList = ["Home","Our Story","Remove All","Suggestions","Share","Privacy Policy"]
        SettingTB.delegate = self
        SettingTB.dataSource = self
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "N/A"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] ?? "N/A"
        vesion_Label.text = "Version \(version) (\(build))"
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    func makeImageViewCircular(imageView: UIImageView) {
        // Ensure the UIImageView is square
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
    }
    
    private func NavToWelcome() {
        // Implement your data clearing logic here
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SlotGameViewController") as! SlotGameViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }
    
    private func clearUserData() {
        // Remove keys related to user data but not login information
        UserDefaults.standard.removeObject(forKey: "SlotGameScores")
        UserDefaults.standard.set(100, forKey: "CoinBalance")
        UserDefaults.standard.set(0, forKey: "BetAmount")
        NavToWelcome()
        
    }
    
    private func showResetConfirmation() {
        let confirmationAlert = UIAlertController(title: "Reset Complete", message: "Your data has been reset successfully.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        confirmationAlert.addAction(okAction)
        self.present(confirmationAlert, animated: true, completion: nil)
    }
    
    
    
}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuTableViewCell
        
       // cell.sMenuImgs?.image = UIImage(named: settingImgs[indexPath.row])
        cell.sidemenu_label.text = settingList[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SlotGameViewController") as! SlotGameViewController
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
        else if indexPath.item == 1 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "AboutUSViewController") as! AboutUSViewController
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
        else if indexPath.item == 2 {
            let alert = UIAlertController(title: "Reset Data", message: "You're sure you want to remove all the data.", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                // Step 2: Clear user-specific data
                self.clearUserData()
                
                // Step 3: Optionally, refresh UI or notify the user that data has been reset
                self.showResetConfirmation()
                
                // Step 4: Navigate to WelcomeViewController after reset
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "SlotGameViewController") as! SlotGameViewController
                newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                newViewController.modalTransitionStyle = .crossDissolve
                self.present(newViewController, animated: true, completion: nil)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        else if indexPath.item == 3 {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
        else if indexPath.item == 4 {
            let appID = "JackpotSlots"
            let appURL = URL(string: "https://apps.apple.com/app/id\(appID)")!
            let activityViewController = UIActivityViewController(activityItems: [appURL], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        }
        else if indexPath.item == 5 {
            // Open Privacy Policy Link
            if let url = URL(string: "https://jtechapps.pages.dev/privacy") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
    }
    @IBAction func backbtnPressed(_ sender:UIButton)
    {
        self.dismiss(animated: true)
    }
}


class SideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sMenuImgs: UIImageView!
    @IBOutlet weak var sidemenu_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 12
        
        // Set up shadow properties
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowRadius = 4.0
        contentView.layer.masksToBounds = false
        
        // Set background opacity
        contentView.alpha = 1.5 // Adjust opacity as needed
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
