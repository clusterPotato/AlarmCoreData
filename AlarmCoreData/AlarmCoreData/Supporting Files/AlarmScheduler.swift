//
//  AlarmScheduler.swift
//  AlarmCoreData
//
//  Created by Gavin Craft on 4/29/21.
//

import UIKit
protocol AlarmScheduler{
    static func scheduleUserNotifications(for alarm: Alarm)
    static func cancelUserNotifications(for alarm: Alarm)
}
extension AlarmScheduler{
    static func scheduleUserNotifications(for alarm:Alarm){
        let content: UNMutableNotificationContent = UNMutableNotificationContent()
        content.title = "Reminder"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "car.mp3"))
        content.body = "Alarm: \(alarm.title!)"
        let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: alarm.fireDate!)
        let trigger: UNCalendarNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuidString!, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { err in
            if let err = err{
                print("dere were error \(err)")
                print("Error in \(#function) : \(err.localizedDescription) \n---\n \(err)")
            }
        }
    }
    static func cancelUserNotifications(for alarm: Alarm){
        guard let id = alarm.uuidString else {return}
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
}
