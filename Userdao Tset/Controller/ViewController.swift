
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signOutBtn(_ logOutSegue: UIStoryboardSegue) {
        let storyBord = UIStoryboard.init(name: "Login", bundle: nil)
        let loginViewController = storyBord.instantiateViewController(withIdentifier: "login")
        present(loginViewController, animated: true, completion: nil)
    }
}

