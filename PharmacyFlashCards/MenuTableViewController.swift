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
        return 4
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
            loadMenuItemCell(cell, name: "Play", leftRightIndex: 0, rowIndex: index)
            loadMenuItemCell(cell, name: "Generic", leftRightIndex: 1, rowIndex: index)
        case 1:
            loadMenuItemCell(cell, name: "Brand", leftRightIndex: 0, rowIndex: index)
            loadMenuItemCell(cell, name: "Classification", leftRightIndex: 1, rowIndex: index)
        case 2:
            loadMenuItemCell(cell, name: "Dosage", leftRightIndex: 0, rowIndex: index)
            loadMenuItemCell(cell, name: "Indication", leftRightIndex: 1, rowIndex: index)
        case 3:
            loadMenuItemCell(cell, name: "Settings", leftRightIndex: 0, rowIndex: index)
            // clear right side
            cell.rightImageView.backgroundColor = UIColor(white: 1, alpha: 0.0)
            cell.rightImageTitle.text = ""
            cell.rightImage.image = nil
        default: break
        }
    }
    
    // Load menu item cell with image, text, gestureRecognizer and restorationId
    // parameters:
    //      cell: MenuTableViewCell
    //      name: String -> restorationId or name used to generate icons and text
    //      leftRingIndex: 0-> left, 1-> right, etc.
    private func loadMenuItemCell(cell: MenuTableViewCell, name: String, leftRightIndex: Int, rowIndex: Int){
        // add gesture action
        let gesture = UITapGestureRecognizer(target: self, action: #selector(MenuTableViewController.menuItemCellTapRecognizer(_:)))
        let iconName = "\(name)Icon"
        if leftRightIndex == 0{
            cell.leftImage.image = UIImage(named: iconName)
            cell.leftImageTitle.text = name
            cell.leftImageView.addGestureRecognizer(gesture)
            cell.leftImageView.restorationIdentifier = name
        }else{
            cell.rightImage.image = UIImage(named: iconName)
            cell.rightImageTitle.text = name
            cell.rightImageView.addGestureRecognizer(gesture)
            cell.rightImageView.restorationIdentifier = name
        }
        
        let even = rowIndex % 2
        if even == 0{
            cell.leftImageView.backgroundColor = CommonUtility.service.lightRedColor
            cell.rightImageView.backgroundColor = CommonUtility.service.pinkColor
        }else{
            cell.leftImageView.backgroundColor = CommonUtility.service.pinkColor
            cell.rightImageView.backgroundColor = CommonUtility.service.lightRedColor
        }
    }
    
    // Recognizes menuItemCellTap
    func menuItemCellTapRecognizer(sender:UITapGestureRecognizer){
        // do other task
        if let view = sender.view{
            if view.restorationIdentifier == "Settings"{
                performSegueWithIdentifier("showSettingsScene", sender: sender)
            }else{
                performSegueWithIdentifier("showQuestionScene", sender: sender)
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let view = sender!.view as UIView?{
            if segue.identifier == "showSettingsScene"{
                // show settings
            }else{
                // show questions
                let questionType:QuestionType? = QuestionUtility.getQuestionType(view)
                let isGameModeEnabled:Bool = (view.restorationIdentifier == "Play")
                // grab new drug set
                var selectedDrugs = [Drug]?()
                
                if !isGameModeEnabled{
                    // question mode -> get drug list by user settings
                    selectedDrugs = drugService?.selectByUserSettings()
                }else{
                    // game mode -> get all drugs
                    selectedDrugs = drugService?.selectAll()
                }
                
                if questionType != nil {
                    // Get the new view controller using segue.destinationViewController.
                    if let destinationVC = segue.destinationViewController as? QuestionViewController{
                        destinationVC.allDrugs = selectedDrugs
                        destinationVC.questionType = questionType
                        destinationVC.gameModeEnabled = isGameModeEnabled
                    }
                }
            }
        }
    }
}
