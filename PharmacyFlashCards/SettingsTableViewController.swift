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
    @IBOutlet weak var thirdHundredDrugs: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
        
        // get Drug statuses
        let drugOneStatus = UserSettingsService.service.isDrugSelected(UserSettingsService.service.drugOneConstantKey)
        let drugTwoStatus = UserSettingsService.service.isDrugSelected(UserSettingsService.service.drugTwoConstantKey)
        let drugThreeStatus = UserSettingsService.service.isDrugSelected(UserSettingsService.service.drugThreeConstantKey)
        firstHundredDrugs.setOn(drugOneStatus, animated: false)
        secondHundredDrugs.setOn(drugTwoStatus, animated: false)
        thirdHundredDrugs.setOn(drugThreeStatus, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func firstHundredDrugChange(_ sender: UISwitch){
        alertWhenAllDrugSwitchesOff(sender)
        
        //let status = UserSettingsService.service.isDrugOneSelected()
        UserSettingsService.service.saveDrugStatus(UserSettingsService.service.drugOneConstantKey, status: sender.isOn)
    }
    
    
    @IBAction func secondHundredDrugChange(_ sender: UISwitch) {
        alertWhenAllDrugSwitchesOff(sender)
        UserSettingsService.service.saveDrugStatus(UserSettingsService.service.drugTwoConstantKey, status: sender.isOn)
    }
    
    @IBAction func thirdHundredDrugChange(_ sender: UISwitch) {
        alertWhenAllDrugSwitchesOff(sender)
        UserSettingsService.service.saveDrugStatus(UserSettingsService.service.drugThreeConstantKey, status: sender.isOn)
    }
    fileprivate func alertWhenAllDrugSwitchesOff(_ sender: UISwitch) -> Void{
        if(!firstHundredDrugs!.isOn && !secondHundredDrugs!.isOn && !thirdHundredDrugs!.isOn){
            let alert = UIAlertController(title: "", message: "Choose at least one Drug set.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0{
            let versionObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject?
            let version = versionObject as! String
            return "Created by Edwin Wong and David Lu\nApp Version \(version)"
        }
        return ""
    }
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
