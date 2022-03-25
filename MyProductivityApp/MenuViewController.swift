//
//  MenuViewController.swift
//  MyProductivityApp
//
//  Created by Yevhenii Shypitsyn on 3/16/22.
//

import UIKit

protocol MenuViewControllerDelegate {
    func hideMenu()
}

class MenuViewController: UIViewController {
    
    var delegate : MenuViewControllerDelegate?
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var mainBackgroundView: UIView!
    
    @IBOutlet var menuView: UIView!
    
    
    /*@IBAction func menuButtonClicked(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            
        })
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupMenuUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupMenuUI(){
        self.mainBackgroundView.layer.cornerRadius = 30
        self.mainBackgroundView.clipsToBounds = true
        
        //self.profilePicture.layer.cornerRadius = 100
        //self.profilePicture.clipsToBounds = true
        
    }
    
    @IBAction func doTodayFolderClick(_ sender: Any) {
        print("class 1")
        DataManager.folderClass = 1
        DataManager.folderClassLabel.text = "Do today"
        NetworkingAPIFunctions.functions.fetchNotes(userId: DataManager.userId)
        self.delegate!.hideMenu()
    }
    
    @IBAction func doThisWeekFolderClick(_ sender: Any) {
        print("class 2")
        DataManager.folderClass = 2
        DataManager.folderClassLabel.text = "Do this week"
        NetworkingAPIFunctions.functions.fetchNotes(userId: DataManager.userId)
        self.delegate!.hideMenu()
        
    }
    
    
    @IBAction func otherTasksFolderClick(_ sender: Any) {
        print("class 3")
        DataManager.folderClass = 3
        DataManager.folderClassLabel.text = "Others"
        NetworkingAPIFunctions.functions.fetchNotes(userId: DataManager.userId)
        self.delegate!.hideMenu()
        
    }
    
    @IBAction func logoutClick(_ sender: Any) {
        self.delegate!.hideMenu()
        DataManager.viewController!.loginRequired()
        
    }

}
