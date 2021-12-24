//
//  ViewController.swift
//  BucketList(iOS Client-Side)
//
//  Created by admin on 19/05/1443 AH.
//

import UIKit

class BucketList: UITableViewController, BucketListDelegate{
    
    var itemsList: [taskCharacter] = []
    
    struct taskCharacter {
        let createdAt: String
        var objective: String
        
        
        
        init?(dict: [String: Any]){
            guard let createdAt = dict["objective"] as? String,
                  let objective = dict["createdAt"] as? String else {
                      return nil
                  }
            
            self.createdAt = createdAt
            self.objective = objective
            
            
        }
    }
    
    override func viewDidLoad() {
        TaskModel.getAllTasks() {
            data, response, error in
            do {
                if let tasks = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: Any]] {
                    for task in tasks{
                        if let taskObj = taskCharacter.init(dict: task){
                        self.itemsList.append(taskObj)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        }}
                    
                    
                    print(tasks)
                }
            } catch {
                print("Something went wrong")
            }
        }
        super.viewDidLoad()
        
    }
    
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        let addToBucketListCV = storyboard?.instantiateViewController(withIdentifier: "AddToBucketList") as! AddToBucketList
        addToBucketListCV.delegate = self
        self.navigationController?.pushViewController(addToBucketListCV, animated: true)
    }
    
    func itemSaved(with text: String, at indexPath: NSIndexPath?){
        
        if let ip = indexPath {
            
            itemsList[ip.row].objective = text
        }
        else{
            
            //   itemsList[indexPath.row].objective = text
            
        }
        tableView.reloadData()
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = itemsList[indexPath.row].createdAt
        cell.detailTextLabel?.text =  itemsList[indexPath.row].objective
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let addToBucketListCV = storyboard?.instantiateViewController(withIdentifier: "AddToBucketList") as! AddToBucketList
        
        addToBucketListCV.delegate = self
        
        let indexPath = indexPath as NSIndexPath
        let item = itemsList[indexPath.row].objective
        
        addToBucketListCV.item = item
        addToBucketListCV.indexPath = indexPath
        
        self.navigationController?.pushViewController(addToBucketListCV, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        itemsList.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    
    
}

