//
//  HomescreenViewController.swift
//  QuotePro
//
//  Created by Cory Alder on 2016-02-16.
//  Copyright © 2016 Cory Alder. All rights reserved.
//

import UIKit

class HomescreenViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // this code should be run when you select a cell, but it's here for testing purposes.
        
        let quoteView = NSBundle.mainBundle().loadNibNamed("QuoteView", owner: nil, options: nil).first! as! QuoteView
        
        quoteView.translatesAutoresizingMaskIntoConstraints = false
        
        let quote = Quote()
        quote.text = "YOLO"
        quote.author = "Cory"
        quote.photo = Photo(id: 10)
        
        quoteView.widthAnchor.constraintEqualToConstant(640).active = true
        quoteView.heightAnchor.constraintEqualToConstant(480).active = true
        
        quoteView.setupWithQuote(quote)
        
        quoteView.layoutIfNeeded()
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(quote.photo!.urlWithSize(quoteView.frame.size, blur: true)) {
            data, resp, err in
            
            if let data = data {
                
                dispatch_async(dispatch_get_main_queue()) {
                    quoteView.quotePhoto.image = UIImage(data: data)
                    
                    
                    UIGraphicsBeginImageContextWithOptions(quoteView.bounds.size, true, 0)
                    
                    quoteView.drawViewHierarchyInRect(quoteView.bounds, afterScreenUpdates: true)
                    
                    let image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    
                    
                    let avc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                    
                    self.presentViewController(avc, animated: true, completion: nil)
                    
                }
            }
            
        }
        
        task.resume()
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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
