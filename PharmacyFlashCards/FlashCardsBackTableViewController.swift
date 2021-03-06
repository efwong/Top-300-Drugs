//
//  FlashCardsBackTableViewController.swift
//  Top300AppliedDrugs
//
//  Created by Edwin Wong on 6/4/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import UIKit

class FlashCardsBackTableViewController: BaseUITableViewController {

    //@IBOutlet weak var genericAnswerLabel: UILabel!
    @IBOutlet weak var brandAnswerLabel: UILabel!
    @IBOutlet weak var classificationAnswerLabel: UILabel!
    @IBOutlet weak var dosageAnswerLabel: UILabel!
    @IBOutlet weak var indicationAnswerLabel: UILabel!
    
    var drug: Drug?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 10
        super.tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0

        if UIScreen.main.nativeBounds.height <= 960.0 {
            brandAnswerLabel.font = brandAnswerLabel.font.withSize(14)
            classificationAnswerLabel.font = classificationAnswerLabel.font.withSize(14)
            dosageAnswerLabel.font = dosageAnswerLabel.font.withSize(14)
            indicationAnswerLabel.font = indicationAnswerLabel.font.withSize(14)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        updateText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // update drug text
    func updateText(){
        //self.genericAnswerLabel.text = self.drug!.generic
        self.brandAnswerLabel.text = self.drug!.brand
        self.classificationAnswerLabel.text = self.drug!.classification
        self.indicationAnswerLabel.text = self.drug!.indication
        self.dosageAnswerLabel.text = self.drug!.dosage
    }
    
    // update drug
    func updateDrug(_ newDrug: Drug){
        self.drug = newDrug;
        updateText()
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
