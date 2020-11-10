//
//  KeyListTableViewController.swift
//  mogrige
//
//  Created by Hyunseok Yang on 2020/10/06.
//

import UIKit
import CoreData

class KeyListTableViewController: UITableViewController {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchResult = UITableView()
    
    var postlist:[MoodboardList]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell" )
                tableView.delegate = self
                tableView.dataSource = self
        
        saveNewUser()
        fetchMoodboardList()
    }
    
    func saveNewUser() {
        let Moodboard = MoodboardList(context: context)
        Moodboard.keyword1 = "구름"
        Moodboard.keyword2 = "바다"
        Moodboard.keyword3 = "파랑"
        Moodboard.image1 = "01"
        Moodboard.mainDescription = "파란 바다를 마주 앉아 새하얀 구름을 바라봄"
        
        do {
        try context.save()
        }
        catch {
            
        }
    }

    func fetchMoodboardList() {
        
        // Fetch the data from Core Dara to display in the tableview
        do {
            let request = MoodboardList.fetchRequest() as NSFetchRequest<MoodboardList>
            
            self.postlist = try context.fetch(request)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            
        }
    }

    
    // tableView 세팅
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // tableView 열 세팅
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postlist!.count
    }
    
    // tableView에 데이터 입력
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! KeyListTableViewCell
                
        let postListCell = postlist?[indexPath.row]
        
        cell.keywordTitle?.text = "\(postListCell?.keyword1), \(postListCell?.keyword1), \(postListCell?.keyword1)"
        cell.keywordDescription?.text = postListCell?.mainDescription
        cell.keywordImage?.image = UIImage(named: (postListCell?.image1)!)

        return cell
    }
    
    //tableView 스와이프해서 삭제하기
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Creat swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            // Which person to remove
            let moodboardToRemove = self.postlist![indexPath.row]
            
            // Remone the person
            self.context.delete(moodboardToRemove)
            
            // Save the data
            do {
                try self.context.save()
            }
            catch {
                
            }
            // Re-fetch the data
            self.fetchMoodboardList()
        }
        
        // Return swipe actions
        return UISwipeActionsConfiguration(actions: [action])
    }

}


    
    
