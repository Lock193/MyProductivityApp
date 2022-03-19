//
//  MainEntryViewController.swift
//  MyProductivityApp
//
//  Created by Yevhenii Shypitsyn on 3/19/22.
//

import UIKit

class MainEntryViewController: UINavigationController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataManager.navigationController = self
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
