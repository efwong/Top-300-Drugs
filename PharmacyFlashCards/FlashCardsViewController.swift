//
//  FlashCardsViewController.swift
//  Top300AppliedDrugs
//
//  Created by Edwin Wong on 6/4/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import UIKit

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
    
    @IBAction func frontFlipAction(sender: UITapGestureRecognizer) {
        let transitionOptions: UIViewAnimationOptions = [.TransitionFlipFromRight, .ShowHideTransitionViews]
        UIView.transitionFromView(self.frontView, toView: self.backView, duration: 0.5, options: transitionOptions, completion: nil)
        self.backView.hidden = false
        self.frontView.hidden = true
    }
    @IBAction func backFlipAction(sender: UITapGestureRecognizer) {
        performBackFlip(0.5, completion: nil)
    }

    @IBAction func swipeRightAction(sender: UISwipeGestureRecognizer) {
        if goToPrevDrug(){
            // backview is shown
            // flip it back
            if(self.backView.hidden == false){
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
    
    @IBAction func swipeLeftAction(sender: UISwipeGestureRecognizer) {
        if goToNextDrug() {
            
            // backview is shown
            // flip it back
            if(self.backView.hidden == false){
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "embedFlashCardsBack"{
            if let flashCardsBack = segue.destinationViewController as? FlashCardsBackTableViewController{
                flashCardsBack.drug = self.currentDrug
                flashCardsBackController = flashCardsBack
            }
        }
    }
 
    // MARK: - Helpers
    
    // increments drug index
    // returns true if currentDrugIndex < # of drugs
    //         false if currentDrugIndex is at max count of drugs
    private func goToNextDrug() -> Bool{
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
    private func goToPrevDrug() -> Bool{
        var status:Bool = false
        if self.drugs != nil && self.drugs?.count > 0 && self.currentDrugIndex > 0 {
            self.currentDrugIndex -= 1
            status = true
        }
        return status
    }
    
    // update drug stats shown
    private func updateDrug(){
        self.genericNameLabel.text = self.currentDrug!.generic
        self.flashCardsBackController?.updateDrug(self.currentDrug!)
    }
    
    private func performBackFlip(duration: Double, completion: ((Bool) -> Void)?){
        let transitionOptions: UIViewAnimationOptions = [.TransitionFlipFromLeft, .ShowHideTransitionViews]
        UIView.transitionFromView(self.backView, toView: self.frontView, duration: duration, options: transitionOptions, completion: completion)
        self.frontView.hidden = false
        self.backView.hidden = true
    }
    
    // transition front view to the right
    private func swipeFrontViewRight(){
        UIView.animateWithDuration(0.12, delay: 0.0, options: [.CurveEaseInOut ], animations: {
            self.frontView.center.x += self.view.bounds.width
            }, completion: {
                (value: Bool) in
                self.frontView.center.x = -200
                self.updateDrug()
                UIView.animateWithDuration(0.25, delay: 0.0, options: [.CurveEaseInOut ], animations: {
                    self.frontView.center.x = self.view.center.x
                    }, completion:nil
                )
        })
    }
    
    // transition front view to the left
    private func swipeFrontViewLeft(){
        UIView.animateWithDuration(0.12, delay: 0.0, options: [.CurveEaseInOut ], animations: {
            self.frontView.center.x -= self.view.bounds.width
            }, completion: {
                (value: Bool) in
                self.frontView.center.x = self.view.bounds.width+200
                self.updateDrug()
                UIView.animateWithDuration(0.25, delay: 0.0, options: [.CurveEaseInOut ], animations: {
                    self.frontView.center.x = self.view.center.x
                    }, completion:nil
                )
        })
    }
    
    // show instrutions once
    private func showInstructions(){
        if UserSettingsService.service.isFlashCardInstructionsHidden() == false{
            let alert = UIAlertController(title: "Instructions", message: "Tap, swipe, and learn.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){
                (action: UIAlertAction!) in
                UserSettingsService.service.hideFlashCardInstructions()
                
                })

            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
