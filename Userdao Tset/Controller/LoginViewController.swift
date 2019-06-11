

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
        if identifier == "done" {
            let username = usernameTextField.text!
            let password = passwordTextField.text!
            
            if let user = userDao?.getUserByUsername(username: username) {
                if user.password == password {
                    statusLabel.text = "\(username) successfully logged in!"
                    return true
                }else{
                    return false
                }
            }else{
               statusLabel.text = "\(username) not exist, register first!"
                let storyBoard = UIStoryboard(name: "Login", bundle: nil)
                let registerViewController = storyBoard.instantiateViewController(withIdentifier: "registration")
                present(registerViewController, animated: true, completion: nil)
                return false
            }
        }
        return false
    }
}
