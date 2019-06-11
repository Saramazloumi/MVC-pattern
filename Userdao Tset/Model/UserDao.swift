

import Foundation
import UIKit
import CoreData

class UserDao {
    
    var appDelegate : AppDelegate?
    
    init(delegate: AppDelegate) {
        appDelegate = delegate
    }
    
    func getManageContext () -> NSManagedObjectContext? {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else {return nil}
        return manageContext
    }
    
    func getUserByUsername(username : String) -> User? {
        
        let context = getManageContext()!
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "User")
        request.predicate = NSPredicate(format: "username = %@", username)
        
        do{
            let result = try context.fetch(request)
            if result.count > 0 {
                let user = result[0] as! User
                return user
            }else {
                print("\(username) not found!")
                return nil
            }
        }catch{
            print("Can not fetch!")
            return nil
        }
    }
    
    
    func saveUser(user: User) -> Bool {
        
        if let existUser = getUserByUsername(username: user.username!) {
            print("\(existUser.username!) already exist!")
            return false
        }else {
            let context = getManageContext()!
            let saveUser = User(context: context)
            saveUser.firstname = user.firstname
            saveUser.lastname = user.lastname
            saveUser.username = user.username
            saveUser.password = user.password
            do{
                try context.save()
                return true
            }catch{
                print("Error in saving \(user.username!)")
                return false
            }
        }
    }
    
    func getAllUsers() -> [User] {
        let  context = getManageContext()!
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "User")
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                let user = result as! [User]
                return user
            }else{
                print("Error")
                return []
            }
        }catch{
            print("Error in fetching all users", error.localizedDescription)
            return []
        }
    }
    

}
