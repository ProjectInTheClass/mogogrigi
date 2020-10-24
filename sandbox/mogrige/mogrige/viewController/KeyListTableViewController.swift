//
//  KeyListTableViewController.swift
//  mogrige
//
//  Created by Hyunseok Yang on 2020/10/06.
//

import UIKit

class KeyListTableViewController: UITableViewController {
    
<<<<<<< HEAD:mogrige/mogrige/viewController/KeyListTableViewController.swift
    var fetchResult = UITableView()
    
=======
<<<<<<< Updated upstream:mogrige/mogrige/KeyListTableViewController.swift
=======

    
    var fetchResult = UITableView()
    
>>>>>>> Stashed changes:mogrige/mogrige/viewController/KeyListTableViewController.swift
>>>>>>> hyobeen:mogrige/mogrige/KeyListTableViewController.swift
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell" )
                tableView.delegate = self
                tableView.dataSource = self
    }
    


    // tableView 세팅
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // tableView 열 세팅
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Post_List.count
    }
    
    // tableView에 데이터 입력
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! KeyListTableViewCell
                
        let postListCell = Post_List[indexPath.row]

        cell.keywordTitle?.text = "#\(postListCell.keyword01), #\(postListCell.keyword02), #\(postListCell.keyword03)"
        cell.keywordDescription?.text = postListCell.memo
        cell.keywordImage?.image = UIImage(named: postListCell.artImg)

        return cell
    }
    
    //tableView 스와이프해서 삭제하기
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            Post_List.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }

}


    
    
