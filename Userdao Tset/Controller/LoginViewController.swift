

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.text = username
        passwordTextField.text = password
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if validateFields() {
        
            let username = usernameTextField.text!
            let password = passwordTextField.text!
            
            if let user = userDao?.getUserByUsername(username: username) {
                if user.password == password {
                    statusLabel.text = "\(username) successfully logged in!"
                    return true
                }else{
                    statusLabel.text = "Wrong password!"
                    return false
                }
            }else{
                let alert = UIAlertController(title: "Error", message: "Exist or wrong username", preferredStyle: .alert)
                
                let registerAction = UIAlertAction(title: "Register?", style: .default) { (action) in
                    let storyBoard = UIStoryboard(name: "Login", bundle: nil)
                    let registerViewController = storyBoard.instantiateViewController(withIdentifier: "registration")
                    self.present(registerViewController, animated: true, completion: nil)
                }
                
                let tryAgainAction = UIAlertAction(title: "Try again?", style: .default) { (action) in
                    alert.dismiss(animated: true, completion: nil)
                }
                alert.addAction(registerAction)
                alert.addAction(tryAgainAction)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        return false
    }
    
    func validateFields() -> Bool {
        if usernameTextField.text == "" {
            statusLabel.text = "Enter username"
            return false
        }else if passwordTextField.text == "" {
            statusLabel.text = "Enter your password!"
            return false
        }
        return true
    }
    
}
