//
//  DetailTableViewController.swift
//  AlarmCoreData
//
//  Created by Gavin Craft on 4/29/21.
//

import UIKit

class DetailTableViewController: UITableViewController {
    //MARK: - iboutlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var enabledButton: UIButton!
    @IBOutlet weak var datPicker: UIDatePicker!
    
    //MARK: - props
    var alarm:Alarm?
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    //MARK: - ibactions
    @IBAction func toggleIsEnabled(_ sender: Any) {
        guard let alarm = alarm else {
            enabledButton.setTitle(enabledButton.titleLabel!.text=="Off" ? "On" : "Off", for: .normal)
            return
        }
        if enabledButton.titleLabel!.text == "On"{
            AlarmController.shared.toggleAlarmStatus(alarm: alarm)
            enabledButton.setTitle("Off", for: .normal)
        }else if enabledButton.titleLabel!.text == "Off"{
            AlarmController.shared.toggleAlarmStatus(alarm: alarm)
            enabledButton.setTitle("On", for: .normal)
        }
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        iPressedButton()
    }
    
    //MARK: - funcs
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "When shall it go off?"
        case 1:
            return "Whats the alarm's name?"
        case 2:
            return "Do you really want it to go off?"
        default:
            return "thingy"
        }
    }
    func updateViews(){
        if let _ = alarm{}else{
            enabledButton.setTitle("Off", for: .normal)
        }
        guard let alarm = alarm else {return}
        titleTextField.text = alarm.title
        datePicker.date = alarm.fireDate!
        if(alarm.isEnabled){
            enabledButton.setTitle("On", for: .normal)
        }
        else{
            enabledButton.setTitle("Off", for: .normal)
        }
    }
    func iPressedButton(){
        guard let title = titleTextField.text, !title.isEmpty else {return}
        let date = datePicker.date
        let enabled = enabledButton.titleLabel?.text=="On" ? true : false
        if let alarm = alarm{
            alarm.title = title
            alarm.isEnabled = enabled
            alarm.fireDate = date
            AlarmController.shared.updateAlarmDetails(alarm: alarm)
        }else{
            AlarmController.shared.createAlarm(title: title, isEnabled: enabled, fireDate: date)
        }
        navigationController?.popViewController(animated: true)
    }
}
