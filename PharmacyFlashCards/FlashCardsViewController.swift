//
//  FlashCardsViewController.swift
//  Top300AppliedDrugs
//
//  Created by Edwin Wong on 6/4/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class FlashCardsViewController: UIViewController {

    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var genericNameLabel: UILabel!
    
    @IBOutlet weak var backViewContainerView: UIView!
    var currentDrug: Drug?{
        get{
            return self.drugs![self.currentDrugIndex]
        }
    }
    var drugs: [Drug]?
    var currentDrugIndex: Int=0
    var flashCardsBackController: FlashCardsBackTableViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.frontView.layer.cornerRadius = 10
        self.backView.layer.cornerRadius = 10
        self.backViewContainerView.layer.cornerRadius = 10
        
        self.genericNameLabel.text = self.currentDrug?.generic
        // Do any additional setup after loading the view.
        showInstructions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func frontFlipAction(_ sender: UITapGestureRecognizer) {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(from: self.frontView, to: self.backView, duration: 0.5, options: transitionOptions, completion: nil)
        self.backView.isHidden = false
        self.frontView.isHidden = true
    }
    @IBAction func backFlipAction(_ sender: UITapGestureRecognizer) {
        performBackFlip(0.5, completion: nil)
    }

    @IBAction func swipeRightAction(_ sender: UISwipeGestureRecognizer) {
        if goToPrevDrug(){
            // backview is shown
            // flip it back
            if(self.backView.isHidden == false){
                performBackFlip(0.25){(value: Bool) in self.swipeFrontViewRight()}
            }else{
                self.swipeFrontViewRight()
            }
//            UIView.animateWithDuration(0.12, delay: 0.0, options: [.CurveEaseInOut ], animations: {
//                self.frontView.center.x += self.view.bounds.width
//                }, completion: {
//                    (value: Bool) in
//                    self.frontView.center.x = -200
//                    self.updateDrug()
//                    UIView.animateWithDuration(0.25, delay: 0.0, options: [.CurveEaseInOut ], animations: {
//                        self.frontView.center.x = self.view.center.x
//                        }, completion:nil
//                    )
//            })
        }
    }
    
    @IBAction func swipeLeftAction(_ sender: UISwipeGestureRecognizer) {
        if goToNextDrug() {
            
            // backview is shown
            // flip it back
            if(self.backView.isHidden == false){
                performBackFlip(0.25){(value: Bool) in self.swipeFrontViewLeft()}
            }
            else{
                self.swipeFrontViewLeft()
            }
//            UIView.animateWithDuration(0.12, delay: 0.0, options: [.CurveEaseInOut ], animations: {
//                self.frontView.center.x -= self.view.bounds.width
//                }, completion: {
//                    (value: Bool) in
//                    self.frontView.center.x = self.view.bounds.width+200
//                    self.updateDrug()
//                    UIView.animateWithDuration(0.25, delay: 0.0, options: [.CurveEaseInOut ], animations: {
//                        self.frontView.center.x = self.view.center.x
//                        }, completion:nil
//                     )
//            })
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "embedFlashCardsBack"{
            if let flashCardsBack = segue.destination as? FlashCardsBackTableViewController{
                flashCardsBack.drug = self.currentDrug
                flashCardsBackController = flashCardsBack
            }
        }
    }
 
    // MARK: - Helpers
    
    // increments drug index
    // returns true if currentDrugIndex < # of drugs
    //         false if currentDrugIndex is at max count of drugs
    fileprivate func goToNextDrug() -> Bool{
        var status:Bool = false
        if self.drugs != nil && self.drugs?.count > 0 && self.currentDrugIndex < self.drugs?.count{
            self.currentDrugIndex += 1
            status = true
        }
        return status
    }
    
    // decrements drug index
    // returns true if currentDrugIndex > 0
    //         false if currentDrugIndex is 0
    fileprivate func goToPrevDrug() -> Bool{
        var status:Bool = false
        if self.drugs != nil && self.drugs?.count > 0 && self.currentDrugIndex > 0 {
            self.currentDrugIndex -= 1
            status = true
        }
        return status
    }
    
    // update drug stats shown
    fileprivate func updateDrug(){
        self.genericNameLabel.text = self.currentDrug!.generic
        self.flashCardsBackController?.updateDrug(self.currentDrug!)
    }
    
    fileprivate func performBackFlip(_ duration: Double, completion: ((Bool) -> Void)?){
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        UIView.transition(from: self.backView, to: self.frontView, duration: duration, options: transitionOptions, completion: completion)
        self.frontView.isHidden = false
        self.backView.isHidden = true
    }
    
    // transition front view to the right
    fileprivate func swipeFrontViewRight(){
        UIView.animate(withDuration: 0.12, delay: 0.0, options: UIViewAnimationOptions(), animations: {
            self.frontView.center.x += self.view.bounds.width
            }, completion: {
                (value: Bool) in
                self.frontView.center.x = -200
                self.updateDrug()
                UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions(), animations: {
                    self.frontView.center.x = self.view.center.x
                    }, completion:nil
                )
        })
    }
    
    // transition front view to the left
    fileprivate func swipeFrontViewLeft(){
        UIView.animate(withDuration: 0.12, delay: 0.0, options: UIViewAnimationOptions(), animations: {
            self.frontView.center.x -= self.view.bounds.width
            }, completion: {
                (value: Bool) in
                self.frontView.center.x = self.view.bounds.width+200
                self.updateDrug()
                UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions(), animations: {
                    self.frontView.center.x = self.view.center.x
                    }, completion:nil
                )
        })
    }
    
    // show instrutions once
    fileprivate func showInstructions(){
        if UserSettingsService.service.isFlashCardInstructionsHidden() == false{
            let alert = UIAlertController(title: "Instructions", message: "Tap, swipe, and learn.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
                (action: UIAlertAction!) in
                UserSettingsService.service.hideFlashCardInstructions()
                
                })

            self.present(alert, animated: true, completion: nil)
        }
    }
}
