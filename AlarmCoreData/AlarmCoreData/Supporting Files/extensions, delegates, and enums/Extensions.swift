//
//  Extensions.swift
//  AlarmCoreData
//
//  Created by Gavin Craft on 4/29/21.
//

import Foundation
extension String{
    static func fromDate(_ date: Date) -> String{
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .short
        return dateFormat.string(from: date)
    }
}
extension MainListTableViewController: AlarmCellDelegate{
    func switchTapped(_ sender: AlarmCell) {
        guard let alarm = sender.alarm else {return}
        AlarmController.shared.toggleAlarmStatus(alarm: alarm)
        tableView.reloadData()
    }
}
