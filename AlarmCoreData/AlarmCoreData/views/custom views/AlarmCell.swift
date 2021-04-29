//
//  _placeholder.swift
//  AlarmCoreData
//
//  Created by Gavin Craft on 4/29/21.
//
import UIKit
class AlarmCell: UITableViewCell{
    //MARK: - random instance vars
    var alarm: Alarm?
    weak var delegate:AlarmCellDelegate?
    
    //MARK: - IBoutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fireDateLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    //MARK: - lifecycle
    override class func awakeFromNib() {
        //literally nothing here
    }
    
    //MARK: - IBActions
    @IBAction func switchWasFlipped( _ sender: Any?){
        delegate?.switchTapped(self)
        print("ya flipped it")
    }
    
    //MARK: - custom functions
    func updateViews(){
        guard let alarm = alarm else {return}
        guard let date = alarm.fireDate else {return}
        print(alarm.isEnabled)
        titleLabel.text = alarm.title
        fireDateLabel.text = String.fromDate(date)
        alarmSwitch.isOn = alarm.isEnabled
    }
}
