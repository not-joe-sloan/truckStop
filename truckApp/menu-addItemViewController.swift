//
//  menu-addItemViewController.swift
//  
//
//  Created by Joe Sloan on 12/23/17.
//

import UIKit
import Parse

class menu_addItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Protocol Conformations
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedCategory = pickerData[row] as String

    }
    
    @IBAction func cancelAddingPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func savePressed(_ sender: Any) {
        
        
        
    }
    @IBOutlet var picker: UIPickerView!
    var pickerData: [String] = [String]()
    
    var selectedAllergyItems = [Int]()
    var customAllergyItems = [String]()
    var selectedCategory = String()
    
    @IBOutlet var itemNameField: UITextField!
    @IBOutlet var itemPriceField: UITextField!
    @IBOutlet var itemDescriptionField: UITextView!
    
    @IBAction func saveWasPressed(_ sender: Any) {
        
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
