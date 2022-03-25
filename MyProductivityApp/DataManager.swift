//
//  DataManager.swift
//  MyProductivityApp
//
//  Created by Yevhenii Shypitsyn on 3/19/22.
//

import Foundation
import UIKit

//This class acts as a data access object (DAO) between view controllers
class DataManager {
    //MARK: - App vars
    static var viewController:ViewController? = nil
    static var folderClassLabel: UILabel!
    static var navigationController:MainEntryViewController? = nil
    static var loginController:LoginController? = nil
    static var folderClass = 1
    static var userId = "0"
    static var notesArray = [Note]()
    static var tempArray = [Note]()
    
}
