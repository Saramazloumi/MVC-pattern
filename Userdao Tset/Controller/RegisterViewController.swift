
import UIKit
import CoreData

var username = String ()
var password = String ()

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confimrTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    var userData = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        if validateFields() {
       var userForm = UserForm()
            userForm.firstname = firstnameTextField.text
            userForm.lastname = lastnameTextField.text
            userForm.username = usernameTextField.text
            userForm.password = passwordTextField.text
        
            if ((userDao?.saveUser(userForm: userForm))!) {
            username = usernameTextField.text!
            password = passwordTextField.text!
                
                let storyBorad = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyBorad.instantiateViewController(withIdentifier: "main")
                present(viewController, animated: true, completion: nil)
                statusLabel.text = "\(userForm.username!) successfully registered "
        }else{
            statusLabel.text = "\(userForm.username!) is exist!"
          }
        }
        userData.set(true, forKey: "tapped")
        userData.synchronize()
    }
    
    func validateFields() -> Bool {
        if firstnameTextField.text == "" {
            statusLabel.text = "Enter your first name, and try again!"
            return false
        }else if lastnameTextField.text == "" {
            statusLabel.text = "Enter your last name, and try again!"
            return false
        }else if usernameTextField.text == "" {
            statusLabel.text = "Enter your  username, and try again!"
            return false
        }else if passwordTextField.text == "" {
            statusLabel.text = "Choose a password, and try again!"
            return false
        }else if confimrTextField.text == "" {
            statusLabel.text = "Confirm your password, and try again!"
            return false
        }else if passwordTextField.text != confimrTextField.text {
            statusLabel.text = "Password not matched!"
            return false
        }
        return true
    }
}
