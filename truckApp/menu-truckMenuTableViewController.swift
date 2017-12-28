//
//  menu-truckMenuTableViewController.swift
//  truckApp
//
//  Created by Joe Sloan on 12/26/17.
//  Copyright © 2017 Joe Sloan. All rights reserved.
//

import UIKit
import Parse
import CoreData

class menu_truckMenuTableViewController: UITableViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    var itemNames = [String]()
    var itemPrices = [String]()
    var itemDescriptions = [String]()
    var items: [NSManagedObject] = []
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewController.viewDidAppear(true)
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pull up the PersistentContainer from the appDelegate to start working with the NSManagedObjectContext
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Start a fetch request by setting its entity property, which declares the type of entity the fetch will deal with.
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MenuItem")
        
        //You hand the fetchRequest over to the ManagedObjectContext to implement it into a fetch.  a Fetch will return an array of objects that meet the criteria specified in the fetch request.
        
        do {items = try managedContext.fetch(fetchRequest)
            print(items)
        }catch let error as NSError {
            Utils.showAlert(vc: self, title: "Error", message: error.localizedDescription)
        }
        
        let itemsQuery = PFQuery(className: "MenuItem")
        itemsQuery.whereKey("author", equalTo: PFUser.current()!.value(forKey: "truck")!)
        
        itemsQuery.findObjectsInBackground { (objects, error) in
            if error == nil {
                if let items = objects{
                    for item in items{
                        
                        self.itemNames.append(item.value(forKey: "name") as! String)
                        self.itemPrices.append(item.value(forKey: "price") as! String)
                        self.itemDescriptions.append(item.value(forKey: "description") as! String)
                        
                        //print(item.value(forKey: "name"))
                        //print(item.value(forKey: "allergyInfo"))
                    }
                }
                self.tableView.reloadData()
            }else{
                Utils.showAlert(vc: self, title: "Error loading items", message: error!.localizedDescription)
            }
        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = items[indexPath.row]

        cell.textLabel?.text = item.value(forKeyPath: "name") as? String
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
