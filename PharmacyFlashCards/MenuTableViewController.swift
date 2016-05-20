//
//  MenuTableViewController.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 3/6/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import UIKit

class MenuTableViewController: BaseUITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "GenericBrandMenuItemRow"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MenuTableViewCell
        setMenuTableCell(cell, index: indexPath.row)
        return cell
    }

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

    // MARK: Helpers
    private func setMenuTableCell(cell: MenuTableViewCell, index: Int){
        switch(index){
        case 0:
            cell.leftImage.image = UIImage(named: "GenericIcon")
            cell.leftImageTitle.text = "Generic"
            cell.rightImage.image = UIImage(named: "BrandIcon")
            cell.rightImageTitle.text = "Brand"
        case 1:
            cell.leftImage.image = UIImage(named: "ClassificationIcon")
            cell.leftImageTitle.text = "Classification"
            cell.rightImage.image = UIImage(named: "DosageIcon")
            cell.rightImageTitle.text = "Dosage"
        case 2:
            cell.leftImage.image = UIImage(named: "IndicationIcon")
            cell.leftImageTitle.text = "Indication"
            cell.rightImage.image = UIImage(named: "SettingsIcon")
            cell.rightImageTitle.text = "Settings"
        default: break
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        let selectedDrugs = drugService?.selectAll()
//        let questionType = getQuestionType(segue.identifier!)
//        
//        if questionType != nil {
//            if let destinationVC = segue.destinationViewController as? QuestionViewController{
//                destinationVC.allDrugs = selectedDrugs
//                destinationVC.questionType = questionType
//            }
//        }
//    }
    
//    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
//        let questionType = getQuestionType(identifier!)
//        if questionType == nil {
//            return false
//        }
//        return true
//    }

//    private func getQuestionType(segueIdentifier: String) -> QuestionType?{
//        var questionType: QuestionType? = nil
//        switch(segueIdentifier){
//        case "GenericQuestionSegue":
//            questionType = QuestionType.GenericName
//        case "BrandQuestionSegue":
//            questionType = QuestionType.BrandName
//        case "ClassificationQuestionSegue":
//            questionType = QuestionType.Classification
//        case "DosageQuestionSegue":
//            questionType = QuestionType.Dosage
//        case "IndicationQuestionSegue":
//            questionType = QuestionType.Indication
//        default:
//            questionType = nil
//        }
//        return questionType
//    }
    
}
