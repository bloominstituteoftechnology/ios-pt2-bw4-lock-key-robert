//
//  7ViewController.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 2/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class SevenViewController: UIViewController {

    //MARK: - Properties
    
    let sharedController = SharedController()
    
    //MARK: - Outlets
    
    @IBOutlet weak var level7Button: UIButton!
    @IBOutlet weak var keysButton: UIButton!
    
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    
    
    @IBOutlet weak var holdGestureView: UIView!
    @IBOutlet var holdRecognizer: UILongPressGestureRecognizer!
    
    @IBOutlet weak var middleLeftSwipeView: UIView!
    @IBOutlet weak var middleRightButton: UIButton!
    
    //MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
        self.view.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        sharedController.fadeViewIn(view: self.view)
        bordersOn()
    }
    
    //MARK: - Methods
    
    private func bordersOn() {
        sharedController.setupButtonBorders(for: topLeftButton)
        sharedController.setupButtonBorders(for: bottomRightButton)
        sharedController.setupButtonBorders(for: topRightButton)
        sharedController.setupButtonBorders(for: bottomLeftButton)
        sharedController.setupButtonBorders(for: middleRightButton)
        
        sharedController.setupSwipeViewBorders(for: middleLeftSwipeView)
        sharedController.setUpHoldViewBorders(for: holdGestureView)
    }
    
    //MARK: - Actions
    
    @IBAction func level7ButtonTapped(_ sender: Any) {
        sharedController.addRiddleAlert(riddle: "", answer: "", clue: "", viewController: self, button: topLeftButton, gesture: nil, segue: "openingSegue")
    }
    
    @IBAction func topLeftButtonTapped(_ sender: Any) {
        sharedController.fadeKeysIn(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addRiddleAlert(riddle: "", answer: "", clue: "", viewController: self, button: self.bottomRightButton, gesture: nil, segue: "openingSegue")
        })
    }
    
    @IBAction func bottomRightButtonTapped(_ sender: Any) {
        sharedController.rotateKeysLeft(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addRiddleAlert(riddle: "", answer: "", clue: "", viewController: self, button: self.topRightButton, gesture: nil, segue: "openingSegue")
        })
    }
    
    @IBAction func topRightButtonTapped(_ sender: Any) {
        sharedController.rotateKeysDown(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addRiddleAlert(riddle: "", answer: "", clue: "", viewController: self, button: self.bottomLeftButton, gesture: nil, segue: "openingSegue")
        })
    }
    
    @IBAction func bottomLeftButtonTapped(_ sender: Any) {
        sharedController.rotateKeysRight(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addRiddleAlert(riddle: "", answer: "", clue: "", viewController: self, button: nil, gesture: self.holdRecognizer, segue: "openingSegue")
        })
    }
    
    @IBAction func holdComplete(_ sender: Any) {
        if holdRecognizer.state == .ended {
            sharedController.rotateKeysUp(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.sharedController.addTransitionRiddleAlert(riddle: "", answer: "", viewController: self, segue: "FinishSegue", level: "7", homeSegue: "openingSegue")
            })
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        sharedController.fadeViewOut(view: self.view)
        
        sharedController.segueAfterFadeOut(viewController: self, segue: "openingSegue")
    }
}
