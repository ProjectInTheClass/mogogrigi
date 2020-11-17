//
//  ListViewController.swift
//  NewMogrige
//
//  Created by 장은비 on 2020/11/16.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {

    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func backToHome(_ segue: UIStoryboardSegue) {
        
    }
    
    var dummyData: [UIImage] = [UIImage(named: "dummy1")!, UIImage(named: "dummy2")!, UIImage(named: "dummy3")!, UIImage(named: "dummy4")!, UIImage(named: "dummy5")!]
    

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
    
    
    
    @IBAction func clickAddBttn(_ sender: Any) {
        performSegue(withIdentifier: "toRandom", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DataManager.shared.fetchBoard()
        tableView.reloadData()
        
        if DataManager.shared.boarList.count == 0 {
            DataManager.shared.addnewBoard("고양이", "저녁노을", "흔들의자", paraMainText: "#고양이는 #저녁노을 지는 창가앞 #흔들의자에 몸을 둥글게 말고 잠들었다.", paraSubText: "전체적으로 브라운과 오렌지의 노을 빛을 배색하고 나무질감의 흔들의자와 담요를 적절히 자리를 잡아 그린다. 고양이는 실루엣으로만 표현하고 전체적으로 대비를 강하게 한다.", dummyData)
            
            NotificationCenter.default.post(name: EditorViewController.newListDidInsert, object: nil)
        } else {
            return
        }
        
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviFont()
        addButton.floatinBtn()
        filterButton.filterBtn()
        tableView.backgroundColor = UIColor.clear
        
        let emptyImg = UIImage()
        searchBar.backgroundImage = emptyImg
        searchBar.backgroundColor = UIColor.clear

        
        token = NotificationCenter.default.addObserver(forName: EditorViewController.newListDidInsert, object: nil, queue: OperationQueue.main) {[weak self] (noti) in
            self?.tableView.reloadData()
        }
        
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.boarList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListViewTableViewCell
        
        let target = DataManager.shared.boarList[indexPath.row]
        cell.keywordTitle?.text = "\(target.keyword1!), \(target.keyword2!), \(target.keyword3!)"
        cell.dateLabel.text = formatter.string(for: target.date)
        
        cell.configure()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailMoodboard") as? DetailViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.board = DataManager.shared.boarList[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    
}
