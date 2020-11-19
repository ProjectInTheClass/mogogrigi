//
//  ListViewTableViewCell.swift
//  NewMogrige
//
//  Created by Hyunseok Yang on 2020/11/16.
//

import UIKit
import CoreData

class ListViewTableViewCell: UITableViewCell {
    
    //cell 커스터마이즈
    //let cellView: UIView
    var editTarget : Board?
    var buttonIsSelected = false
    
    @IBOutlet weak var keywordTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var bookmarkBtn: UIButton!
    
    @IBOutlet weak var cellView: UIView! = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    @IBAction func clickedBookmark(_ sender: Any) {
        
        //https://www.youtube.com/watch?v=ZfuC1Ntasys&list=PLziSvys01OemZoYotSrwUVx_CbZUF7v17&index=20
        //https://stackoverflow.com/questions/49225531/create-a-favorite-button-that-connects-to-a-favorite-tableview-in-swift
        //위 주소들 방법 총동원해서 해볼 수 있지 않을까요
        
        
        buttonIsSelected = !buttonIsSelected
        if buttonIsSelected == true {
            bookmarkBtn.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            editTarget?.bookmark = true
        } else if buttonIsSelected == false {
            bookmarkBtn.setImage(UIImage(systemName: "bookmark"), for: .normal)
            editTarget?.bookmark = false
            
        }
        saveBool(bool: buttonIsSelected)

    }

//    //save to core data
    func saveBool(bool: Bool) {
        if bool == true {
            print("favorite")
            print("buttonIsSelected \(buttonIsSelected)")
            let liked = Board(context: NewMogrige.DataManager.shared.mainContext)
            liked.bookmark = bool
            DataManager.shared.saveContext()
           
        } else if bool == false {
            print("unfavorite")
            print("buttonIsSelected \(buttonIsSelected)")
            let liked = Board(context: DataManager.shared.mainContext)
            liked.bookmark = bool
            DataManager.shared.deletBoard(self.editTarget)
            
            DataManager.shared.saveContext()
            
        }
        
    }
//    clears core data so it doens't get full
//    func resetAllRecord(entity: Bool) {
//        let context = PersistenceService.persistentContainer.viewContext
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//        do
//        {
//            try context.execute(deleteRequest)
//            try context.save()
//        }
//        catch
//        {
//            print ("There was an error")
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
        
        //언더라인 디자인
        let thickness: CGFloat = 0.4
        let bottomLine1 = CALayer()
        
        bottomLine1.frame = CGRect(x: 0.0, y: self.dateLabel.frame.size.height + 5, width: self.dateLabel.frame.width, height: thickness)
        bottomLine1.backgroundColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1).cgColor
        dateLabel.layer.addSublayer(bottomLine1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        //setupView()
    }
    
    
    //cell design
    func configure() {
        cellView.layer.cornerRadius = 3.0
        cellView.layer.shadowColor = UIColor.darkGray.cgColor
        cellView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cellView.layer.shadowOpacity = 0.15
        cellView.layer.masksToBounds = false

    }

    func setupView() {
        addSubview(cellView)

        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

    }

}
