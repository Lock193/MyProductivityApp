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

}
