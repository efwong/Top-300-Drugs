//
//  SettingsTableViewController.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 4/16/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var firstHundredDrugs: UISwitch!
    @IBOutlet weak var secondHundredDrugs: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
        
        // get Drug statuses
        let drugOneStatus = UserSettingsService.service.isDrugOneSelected()
        let drugTwoStatus = UserSettingsService.service.isDrugTwoSelected()
        firstHundredDrugs.setOn(drugOneStatus, animated: false)
        secondHundredDrugs.setOn(drugTwoStatus, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func firstHundredDrugChange(sender: UISwitch){
        alertWhenBothDrugSwitchesOff(sender)
        
        //let status = UserSettingsService.service.isDrugOneSelected()
        UserSettingsService.service.saveDrugOneStatus(sender.on)
    }
    
    
    @IBAction func secondHundredDrugChange(sender: UISwitch) {
        alertWhenBothDrugSwitchesOff(sender)
        UserSettingsService.service.saveDrugTwoStatus(sender.on)
    }
    
    private func alertWhenBothDrugSwitchesOff(sender: UISwitch) -> Void{
        if(!firstHundredDrugs!.on && !secondHundredDrugs!.on){
            let alert = UIAlertController(title: "", message: "Choose at least one Drug set.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            sender.setOn(true, animated: true)
        }
    }
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
