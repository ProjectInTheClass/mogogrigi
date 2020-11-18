//
//  ListViewTableViewCell.swift
//  NewMogrige
//
//  Created by Hyunseok Yang on 2020/11/16.
//

import UIKit

class ListViewTableViewCell: UITableViewCell {
    
    //cell 커스터마이즈
    //let cellView: UIView
    var editTarget : Board?
    
    @IBOutlet weak var keywordTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var bookmarkBtn: UIButton!
    
    @IBOutlet weak var cellView: UIView! = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    @IBAction func clickedBookmark(_ sender: Any) {
        
        //        if   bookmark.tag == 0 {
        //             bookmark.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        //             bookmark.tag = 1
        //             }
        //
        //        else {
        //             bookmark.setImage(UIImage(systemName: "bookmark"), for: .normal)
        //             bookmark.tag = 0
        //        }
        
        //위에거 실행하면 이미지 클릭만 됨
        //https://www.youtube.com/watch?v=ZfuC1Ntasys&list=PLziSvys01OemZoYotSrwUVx_CbZUF7v17&index=20
        //https://stackoverflow.com/questions/49225531/create-a-favorite-button-that-connects-to-a-favorite-tableview-in-swift
        //위 주소들 방법 총동원해서 해볼 수 있지 않을까요
       
    }
    
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
