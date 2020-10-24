//
//  KeyListViewController.swift
//  mogrige
//
//  Created by Taylor Hyobeen Moon on 2020/10/20.
//
import Foundation
import UIKit

class KeyListViewController: UIViewController , UISearchBarDelegate {
    
    var filteredData: [String] = keywordList
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    /*
    //검색창 config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = []
        
        if filteredData == "" {
            filteredData = keywordList
        } else {
            for keyword in keywordList {
                if keyword.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(keyword)
                }
            }
        }
        
        self.UIView.reloadData()
    }
    */
}
