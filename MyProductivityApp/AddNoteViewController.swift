//
//  AddNoteViewController.swift
//  MyProductivityApp
//
//  Created by Yevhenii Shypitsyn on 3/19/22.
//

import UIKit

class AddNoteViewController: UIViewController {

    @IBOutlet weak var deleteButton: UIButton!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    
    
    var note: Note?
        var update = false
    
    // MARK - UI Buttons
    @IBAction func deleteButtonClick(_ sender: Any) {
        print("CLICKEDdeleted")
        NetworkingAPIFunctions.functions.deleteNote(id: note!._id)
        //returns the screen back to the main screen
        self.navigationController?.popViewController(animated: true)
    }
        
    @IBAction func saveButtonClick(_ sender: Any) {
        // creates a date string that we can pass in to the database
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =
            "yyyy-MM-dd HH:mm"
        
        let date = dateFormatter.string(from: Date())
        
        //if the user is updating, update the note rather than saving
        if update == true {
            NetworkingAPIFunctions.functions.updateNote(date: date, title: titleTextField.text!, note: bodyTextView.text, id: note!._id, folder: String(DataManager.folderClass))
            //returns the screen back to the main screen
            self.navigationController?.popViewController(animated: true)
        } else if titleTextField.text != "" && bodyTextView.text != "" {
            NetworkingAPIFunctions.functions.AddNote(date: date, title: titleTextField.text!, note: bodyTextView.text, folder: String(DataManager.folderClass))
            
            //returns the screen back to the main screen
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
        // MARK: - LifeCycle Hooks
        override func viewWillAppear(_ animated: Bool) {
            //disables the delete button if the user is adding a note (can't delete something that doesnt exist)
            
            
            /*** If needed Assign Title Here ***/
            
            if update == false {
                self.deleteButton.isEnabled = false
                self.deleteButton.isHidden = true
            } else {
                self.deleteButton.isHidden = false
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //prepopulates the text field if the user is updating a note
            if update == true{
                titleTextField.text = note!.title
                bodyTextView.text = note!.note
            }
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
