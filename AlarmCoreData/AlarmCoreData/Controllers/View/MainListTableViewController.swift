//
//  MainListTableViewController.swift
//  AlarmCoreData
//
//  Created by Gavin Craft on 4/29/21.
//

import UIKit

class MainListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AlarmController.shared.fetchAlarms()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return AlarmController.shared.sections.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.shared.sections[section].count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell", for: indexPath) as? AlarmCell else {return UITableViewCell()}
        cell.alarm = AlarmController.shared.sections[indexPath.section][indexPath.row]
        cell.updateViews()
        cell.delegate = self
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AlarmController.shared.deleteAlarm(alarm: AlarmController.shared.sections[indexPath.section][indexPath.row], enabled: AlarmController.shared.sections[indexPath.section][indexPath.row].isEnabled)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Active"
        }else{
            return "Inactive"
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVc = segue.destination as? DetailTableViewController else {return}
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        destinationVc.alarm = AlarmController.shared.sections[indexPath.section][indexPath.row]
    }

}
