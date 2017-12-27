//
//  activity-setClosingViewController.swift
//  truckApp
//
//  Created by Joe Sloan on 12/26/17.
//  Copyright © 2017 Joe Sloan. All rights reserved.
//

import UIKit

class activity_setClosingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func resetDate(animated: Bool) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "h:mm a"
        
        let defaultDate = dateFormatter.date(from: "12:00 pm")
        timePicker.setDate(defaultDate!, animated: animated)
    }
    
    var isSet = false
    
    
    func setUI(){
        
        if isSet == false {
            
            
            
            setClearButton.title = "Clear"
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "h:mm a"
            let selectedTime = outputFormatter.string(from: timePicker.date)
            
            self.title = "Closing at \(selectedTime)"
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.timePicker.alpha = 0.2
                self.tableView.alpha = 0.2
            })
            
            self.timePicker.isUserInteractionEnabled = false
            self.tableView.isUserInteractionEnabled = false

            isSet = true

        }else{
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.timePicker.alpha = 1
                self.tableView.alpha = 1
            })
            
            self.timePicker.isUserInteractionEnabled = true
            self.tableView.isUserInteractionEnabled = true
            
            setClearButton.title = "Set"
            self.title = "Set Closing Time"
            
            resetDate(animated: true)
            
            isSet = false
        }
    }
    
    @IBOutlet var timePicker: UIDatePicker!
    @IBOutlet var setClearButton: UIBarButtonItem!
    
    
    
    @IBAction func setClearPressed(_ sender: Any) {

        if isSet == false {
            
            //set the time
            let chosenTime = String()
            
            
            
            setClearButton.title = "Clear"
            
            var outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "h:mm a"
            var selectedTime = outputFormatter.string(from: timePicker.date)
            
            self.title = "Closing at \(selectedTime)"
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.timePicker.alpha = 0.2
                self.tableView.alpha = 0.2
                self.timePicker.isUserInteractionEnabled = false
                self.tableView.isUserInteractionEnabled = false
            })
            
            
            
            
            isSet = true
            
            
        }else{
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.timePicker.alpha = 1
                self.tableView.alpha = 1
                self.timePicker.isUserInteractionEnabled = true
                self.tableView.isUserInteractionEnabled = true
            })
            
            setClearButton.title = "Set"
            self.title = "Set Closing Time"
            
            resetDate(animated: true)
            
            isSet = false
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        //selectedTime = pickerView.selectedRow(inComponent: Int)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
    }
    

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isSet == false {
            
            
            
        }else{
            
            setClearButton.title = "Set"
            resetDate(animated: false)
            

        }

        // Do any additional setup after loading the view.
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
