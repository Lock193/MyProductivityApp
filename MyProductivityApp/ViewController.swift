//
//  ViewController.swift
//  MyProductivityApp
//
//  Created by Yevhenii Shypitsyn on 3/16/22.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, MenuViewControllerDelegate {

    private var alpha:CGFloat = 0.0
    
    @IBOutlet weak var notesTableView: UITableView!
    
    @IBOutlet weak var addNoteButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkingAPIFunctions.functions.fetchNotes()
        DataManager.folderClassLabel = self.folderClassLabel
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.notesTableView.register(NotePrototypeCell.self, forCellReuseIdentifier: "prototypeCell")
        //self.notesTableView.register(UINib(nibName: "prototypeCell", bundle: nil), forCellReuseIdentifier: "prototypeCell")
        NetworkingAPIFunctions.functions.fetchNotes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.notesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        DataManager.viewController = self
        alpha = self.mainBackView.alpha
        NetworkingAPIFunctions.functions.delegate = self
        NetworkingAPIFunctions.functions.fetchNotes()
        
        notesTableView.delegate = self
        notesTableView.dataSource = self
        menuButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        addNoteButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        self.view.layoutIfNeeded()
        // Do any additional setup after loading the view.
        //backViewForExit.isHidden = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.notesArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:NotePrototypeCell = self.notesTableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! NotePrototypeCell
            
            //customizes cell to set date, note and title
            cell.title.text = DataManager.notesArray[indexPath.row].title
            cell.note.text = DataManager.notesArray[indexPath.row].note
            cell.date.text = DataManager.notesArray[indexPath.row].date
            
            //cell.textLabel?.text = notesArray[indexPath.row].title
            return cell
        }
    
    var menuViewController:MenuViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "menuSegue"){
            if let controller = segue.destination as? MenuViewController {
                self.menuViewController = controller
                self.menuViewController?.delegate = self
            }
        } else if segue.identifier == "updateSegue" {
            
                let vc = segue.destination as!AddNoteViewController
            vc.note = DataManager.notesArray[notesTableView.indexPathForSelectedRow!.row]
            vc.update = true
        }
    }
    func hideMenu() {
        self.hideMenuProc()
    }
    
    @IBOutlet weak var folderClassLabel: UILabel!
    @IBOutlet weak var backViewForExit: UIView!
    
    @IBOutlet weak var menuView: UIView!
    
    
    @IBOutlet weak var mainBackView: UIView!
    
    private func hideMenuProc(){
        UIView.animate(withDuration: 0.2, animations: {
            self.leadingConstraint.constant = -300
            self.mainBackView.alpha = self.alpha
            self.view.layoutIfNeeded()
            
        }) {
            (status) in
            self.view.bringSubviewToFront(self.mainBackView)
            self.isMenuShown = false
            self.menuButton.setImage(UIImage(systemName: "folder.circle"), for: UIControl.State.normal)
            
            //DataManager.navigationController!.self
            //self.menuButton.isHidden = false
            //self.view.layoutIfNeeded()
        }
    }
    
    private func showMenu(){
        DataManager.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        DataManager.navigationController!.navigationController?.navigationBar.shadowImage = UIImage()
        DataManager.navigationController!.navigationController?.navigationBar.isTranslucent = true
        DataManager.navigationController!.navigationController?.view.backgroundColor = .clear
        let image = UIImage(contentsOfFile: "")
        self.menuButton.setImage(image, for: UIControl.State.normal)
        menuButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        //menuButton.contentVerticalAlignment = .fill
        //menuButton.contentHorizontalAlignment = .fill
        //menuButton.currentImage?.stretchableImage(withLeftCapWidth: 20, topCapHeight: 20)
        self.view.bringSubviewToFront(menuView)
        //self.menuButton.isHidden = true
        UIView.animate(withDuration: 0.2, animations: {
            self.leadingConstraint.constant = 0
            self.mainBackView.alpha = 0.25
            self.view.layoutIfNeeded()
            
        }) {
            (status) in
            self.isMenuShown = true
            
            UIView.animate(withDuration: 0.2, animations: {
                self.leadingConstraint.constant = -20
                self.view.layoutIfNeeded()
            }) {
                (status) in
                
                self.mainBackView.alpha = 0.25
                //self.backViewForExit.isHidden = true
                self.view.bringSubviewToFront(self.backViewForExit)
            }
        }
    }
    
    
    @IBAction func tappedOnBackView(_ sender: Any) {
        print("Tapped on exit!!")
        if self.isMenuShown == true {
            self.hideMenuProc()
            
        }
    }
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    private var isMenuShown:Bool = false
    
    @IBAction func menuButtonClicked(_ sender: Any) {
        self.showMenu()
        
    }
    
    private var beginPoint:CGFloat = 0.0
    private var difference:CGFloat = 0.0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (isMenuShown){
            if let touch = touches.first {
                let location = touch.location(in: backViewForExit)
                
                beginPoint = location.x
                //print("Started at ")
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (isMenuShown){
            if let touch = touches.first {
                let location = touch.location(in: backViewForExit)
                
                let differenceFromBeginPoint = beginPoint - location.x
                
                if (differenceFromBeginPoint>0 && differenceFromBeginPoint<300){
                self.leadingConstraint.constant = -differenceFromBeginPoint
                    difference = differenceFromBeginPoint
                    self.mainBackView.alpha = 0.25+(0.25*differenceFromBeginPoint/300)
                    //print("Moved at ")
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (isMenuShown){
            if (difference>150){
                //close the menu
                hideMenu()
                
            } else {
                //keep the menu open
                showMenu()
            }
        }
    }
}


// MARK: - Custom Delegates
protocol DataDelegate {
    func updateArray(newArray: String)
}

extension ViewController: DataDelegate {
    func updateArray(newArray: String) {
        print("FUNCTION CALLED")
        do {
            DataManager.notesArray.removeAll()
            DataManager.tempArray.removeAll()
            DataManager.tempArray = try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
            print(DataManager.tempArray)
            //var note:Note = nil
            for note in DataManager.tempArray {
                if Int(note.folder) == DataManager.folderClass {
                    DataManager.notesArray.append(note)
                }
            }
            
        } catch {
            print("Failed to decode JSON!")
            
        }
        
        DataManager.viewController?.notesTableView.reloadData()
        DataManager.viewController?.view.layoutIfNeeded()
        
    }
}

