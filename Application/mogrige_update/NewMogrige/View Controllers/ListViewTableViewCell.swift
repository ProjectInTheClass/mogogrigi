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
    
    
    @IBOutlet weak var keywordTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    @IBOutlet weak var cellView: UIView! = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    @IBOutlet weak var bookmarkButton: UIButton!
    
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
