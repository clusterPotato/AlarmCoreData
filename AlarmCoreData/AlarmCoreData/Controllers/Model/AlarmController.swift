//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by Gavin Craft on 4/29/21.
//

import CoreData
class AlarmController{
    //MARK: - instance variables
    static let shared = AlarmController()
    private lazy var fetchRequest: NSFetchRequest<Alarm> = {
        let request = NSFetchRequest<Alarm>(entityName: "Alarm")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    ///for reference, 0 is enabled and 1 is not
    var sections: [[Alarm]] = [[],[]]
    //MARK: - crud functions
    func createAlarm(title: String, isEnabled: Bool = false, fireDate: Date = Date()){//create
        let newAlarm = Alarm(title: title, isEnabled: isEnabled, fireDate: fireDate)
        if newAlarm.isEnabled{
            sections[0].append(newAlarm)
            AppDelegate.scheduleUserNotifications(for: newAlarm)
        }else{
            sections[1].append(newAlarm)
        }
        CoreDataStack.saveContext()
    }
    func fetchAlarms(){
        let alarms = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        for alarm in alarms{
            if alarm.isEnabled{
                sections[0].append(alarm)
            }else{
                sections[1].append(alarm)
            }
        }
    }
    func updateAlarmDetails(alarm: Alarm){
        CoreDataStack.saveContext()
        if(alarm.isEnabled){
            AppDelegate.cancelUserNotifications(for: alarm)
            AppDelegate.scheduleUserNotifications(for: alarm)
        }else{
            AppDelegate.cancelUserNotifications(for: alarm)
        }
    }
    func toggleAlarmStatus(alarm: Alarm){
        alarm.isEnabled.toggle()
        if(alarm.isEnabled){
            guard let index = sections[1].firstIndex(of: alarm) else {return}
            sections[1].remove(at: index)
            sections[0].append(alarm)
            AppDelegate.cancelUserNotifications(for: alarm)
            AppDelegate.scheduleUserNotifications(for: alarm)
        }else{
            guard let index = sections[0].firstIndex(of: alarm) else {return}
            sections[0].remove(at: index)
            sections[1].append(alarm)
            AppDelegate.cancelUserNotifications(for: alarm)
        }
        CoreDataStack.saveContext()
    }
    func deleteAlarm(alarm: Alarm, enabled: Bool){
        if enabled{
            guard let index = sections[0].firstIndex(of: alarm) else {return}
            sections[0].remove(at: index)
            CoreDataStack.context.delete(alarm)
        }else{
            guard let index = sections[1].firstIndex(of: alarm) else {return}
            sections[1].remove(at: index)
            CoreDataStack.context.delete(alarm)
        }
        CoreDataStack.saveContext()
    }
}

