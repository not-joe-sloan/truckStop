//
//  menu-addItemViewController.swift
//  
//
//  Created by Joe Sloan on 12/23/17.
//

import UIKit
import Parse
import CoreData

class menu_addItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
// MARK: Protocol Conformations
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = pickerData[row] as String
        
    }
    
    
    
    
    
    
    
    
    //Custom Variables
    var pickerData: [String] = [String]()
    var selectedAllergyItems = [Int]()
    var customAllergyItems = [String]()
    var selectedCategory = String()
    var items: [NSManagedObject] = []
    
    //Custom Functions
    func save(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        
        //Set up the managed context, sort of like a "git add" type action.  Sets the whole transfer up for queueing
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Create a new managedObject, and essentially create a link between it and the managedObjectContext, for later when the managedContext needs to work with it???
        let entity = NSEntityDescription.entity(forEntityName: "MenuItem", in: managedContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        //Here you set the values for the menuitem
        item.setValue(itemNameField.text, forKey: "name")
        item.setValue(itemDescriptionField.text, forKey: "itemDescription")
        item.setValue(itemPriceField.text, forKey: "price")
        item.setValue(PFUser.current()?.value(forKey: "truck"), forKey: "author")
        item.setValue(selectedAllergyItems, forKey: "allergyInfo")
        item.setValue(selectedCategory, forKey: "category")
        
        do {
            try managedContext.save()
            items.append(item)
            print(item.value(forKeyPath: "name"), item.value(forKeyPath: "itemDescription"))
        } catch let error as NSError{
            Utils.showAlert(vc: self, title: "Error", message: "Could not save to CoreData")
        }
    }
    func parseSave(){
        let item = PFObject(className: "MenuItem")
        item["author"] = PFUser.current()?.value(forKey: "truck")
        item["name"] = itemNameField.text
        item["price"] = itemPriceField.text
        item["description"] = itemDescriptionField.text
        item["category"] = selectedCategory
        item["allergyInfo"] = selectedAllergyItems
        
        item.saveInBackground(block: { (success, error) in
            if success{
                print("Success!")
                self.dismiss(animated: true, completion: nil)
            }else{
                Utils.showAlert(vc: self, title: "Error", message: error!.localizedDescription)
            }
        })
    }
    
    
//MARK: OUTLETS
    @IBOutlet var itemNameField: UITextField!
    @IBOutlet var itemPriceField: UITextField!
    @IBOutlet var itemDescriptionField: UITextView!
    @IBOutlet var picker: UIPickerView!

//MARK: ACTIONS

    //Cancel Adding
    @IBAction func cancelAddingPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    //Logging Allergy Info
    @IBAction func logAllergyInfo(_ sender: Any) {
        let button = sender as! UIButton
        print(button.tag)
        
        if button.tag != 8{
            if button.backgroundColor != globalConstants.mainOrange{
                button.backgroundColor = globalConstants.mainOrange
                button.setTitleColor(UIColor.white, for: .normal)
                selectedAllergyItems.append(button.tag)
                print(selectedAllergyItems)
                
            }else{
                
                button.backgroundColor = globalConstants.mainGray
                button.setTitleColor(UIColor.white, for: .normal)
                
                
                if let itemToRemoveIndex = selectedAllergyItems.index(of: button.tag) {
                    selectedAllergyItems.remove(at: itemToRemoveIndex)
                }
                
                print(selectedAllergyItems)
            }
        } else {
            let alert = UIAlertController(title: "Add Allergy Item", message: nil , preferredStyle: UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "Add", style: .default) { (alertAction) in
                let textField = alert.textFields![0] as UITextField
                
                if alert.textFields![0].text != "" {
                    self.customAllergyItems.append(alert.textFields![0].text!)
                }
                print(self.customAllergyItems)
            }
            
            alert.addTextField { (textField) in
                textField.placeholder = "Allergy item name"
            }
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: {
                
            })
        }
    }
    
    //
    //
//MARK: Saving a menu item
    @IBAction func saveWasPressed(_ sender: Any) {
        

        self.save()
        self.parseSave()
        
    }

//MARK: BACKGROUND SWIFT STUFF
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Connect Data
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        //Input data into the Array:
        pickerData = ["Appetizers", "Drinks", "Sides", "Entrées", "Desserts", "Specials"]

        itemDescriptionField.layer.cornerRadius = 5
        itemDescriptionField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        itemDescriptionField.layer.borderWidth = 0.5
        itemDescriptionField.clipsToBounds = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
// MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
