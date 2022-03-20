//
//  DataManager.swift
//  MyProductivityApp
//
//  Created by Yevhenii Shypitsyn on 3/19/22.
//

import Foundation
import UIKit

class DataManager {
    static var viewController:ViewController? = nil
    
    static var folderClassLabel: UILabel!
    
    static var navigationController:MainEntryViewController? = nil
    
    static var folderClass = 1
    
    static var notesArray = [Note]()
    static var tempArray = [Note]()
}
