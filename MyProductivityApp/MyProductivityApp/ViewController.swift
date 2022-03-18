//
//  ViewController.swift
//  MyProductivityApp
//
//  Created by Yevhenii Shypitsyn on 3/16/22.
//

import UIKit

class ViewController: UIViewController, MenuViewControllerDelegate {

    private var alpha:CGFloat = 0.0
    
    @IBOutlet weak var menuButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        alpha = self.mainBackView.alpha
        // Do any additional setup after loading the view.
        //backViewForExit.isHidden = true
        
    }
    
    var menuViewController:MenuViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "menuSegue"){
            if let controller = segue.destination as? MenuViewController {
                self.menuViewController = controller
                self.menuViewController?.delegate = self
            }
        }
    }
    func hideMenu() {
        self.hideMenuProc()
    }
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
            self.menuButton.isHidden = false
            //self.view.layoutIfNeeded()
        }
    }
    
    private func showMenu(){
        self.view.bringSubviewToFront(menuView)
        self.menuButton.isHidden = true
        UIView.animate(withDuration: 0.2, animations: {
            self.leadingConstraint.constant = 0
            self.mainBackView.alpha = 0.5
            self.view.layoutIfNeeded()
            
        }) {
            (status) in
            self.isMenuShown = true
            
            UIView.animate(withDuration: 0.2, animations: {
                self.leadingConstraint.constant = -20
                self.view.layoutIfNeeded()
            }) {
                (status) in
                
                self.mainBackView.alpha = 0.5
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
                    self.mainBackView.alpha = 0.5+(0.5*differenceFromBeginPoint/300)
                    //print("Moved at ")
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (isMenuShown){
            if let touch = touches.first {
                if (difference>150){
                    //close the menu
                    hideMenu()
                    
                } else {
                    //keep the menu open
                    showMenu()
                }
                let location = touch.location(in: backViewForExit)
                
                //print("Started at ")
            }
        }
    }
}

