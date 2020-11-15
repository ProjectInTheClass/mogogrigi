//
//  KeywordListViewController.swift
//  mogrige
//
//  Created by Taylor Hyobeen Moon on 2020/10/25.
//

import UIKit

//필수 프로토콜 추가(dataSource, Delegate)
class KeywordListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()

    var token: NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    var filteredData:[String] = []
    var keywordsData:[String] = []
    let cellIdentifier: String = "cell"
    let customCellIdentifier: String = "customCell"
    
    
    @IBOutlet var keywordListView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var keywordListTableView: UITableView!
    @IBOutlet weak var boardTotalNum: UILabel!
    
    @IBAction func closeModal(_ segue: UIStoryboardSegue) {
        
        }
    
    //
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    //Cell 높이 조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    // tableView 열 세팅
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return filteredData.count
        return DataManager.shared.boarList.count
    }
    
    // tableView 세팅
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // tableView에 데이터 입력
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! KeywordListTableViewCell
                
        let target = DataManager.shared.boarList[indexPath.row]
        cell.keywordTitle?.text = "\(String(describing: target.keyword1)), \(String(describing: target.keyword2)), \(String(describing: target.keyword3))"
        cell.detailTextLabel?.text = formatter.string(for: target.registrationDate)
        //cell.detailTextLabel?.text = formatter.string(for: target.insertDate)
        
        // let postListCell = filteredData[indexPath.row]
        
        //board 내 그림 번호 설정 > 삭제
        //cell.boardNum?.text = "Board #\(indexPath.row + 1)"
        
        //키워드로 타이틀 설정
        //cell.keywordTitle?.text = postListCell
        cell.configure()

        return cell
    }
    
    //tableView 스와이프해서 삭제하기
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        var target = DataManager.shared.boarList
        if editingStyle == UITableViewCell.EditingStyle.delete {
            target.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            boardTotalNum.text = "총\(target.count)개의 보드"
        }
        
    }
    
    
    
    //기본 세팅
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = NotificationCenter.default.addObserver(forName: ModalViewController.newListDidInsert, object: nil, queue: OperationQueue.main) {[weak self] (noti) in
            //self?.tableView.reloadData()
        }
        
        //UIview뷰 배경화면 적용
        let backgroundImg = UIImage(named: "background_grain_big")
        view.backgroundColor = UIColor(patternImage: backgroundImg!)
        //테이블뷰 배경화면색 투명으로 적용
        keywordListTableView.backgroundColor = UIColor.clear
        //검색바 적용
        searchBar.delegate = self
        
        let target = DataManager.shared.boarList
        
        for item in target {
            keywordsData.append(contentsOf: [item.keyword1!, item.keyword2!, item.keyword3!])
        }
        
        filteredData = keywordsData

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let target = DataManager.shared.boarList
        boardTotalNum.text = "총 \(target.count)개의 보드"
        //keywordListTableView.tableFooterView = UIView(frame: CGRect.zero)
        DataManager.shared.fetchBoard()
        //tableView.reloadData()
    }
    
    //검색바 config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = []
        
        if searchText == "" {
            filteredData = keywordsData
        } else {
            for keyword in keywordsData {

                if keyword.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(keyword)
                }
            }
        }
        self.keywordListTableView.reloadData()
        
        let searchBar = UISearchBar()
                searchBar.placeholder = "Search"
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
        
        //적용안되고 있음! 수정필요
//        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
//            //서치바 백그라운드 컬러
//            textfield.backgroundColor = UIColor.black
//            //플레이스홀더 글씨 색 정하기
//            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
//            //서치바 텍스트입력시 색 정하기
//            textfield.textColor = UIColor.white
//        }

    }
    
    /*
    public protocol UITableViewDataSource : NSObjectProtocol {

        
        @available(iOS 2.0, *)
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Post_List.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! KeywordListTableViewCell
        
        
        return cell
        }
     */
    
    //TableView 수동설정
    /*
    let listTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = UIColor.white
        return tv
    }()
    */
    
    
    
    
    /*
    func setupTableView() {
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "customCell")
        listTableView.delegate = self
        listTableView.dataSource = self
        
        view.addSubview(listTableView)
            
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            listTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            listTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
        
        listTableView.register(KeywordListTableViewCell.self, forCellReuseIdentifier: "customCell")
    }
    */
}
