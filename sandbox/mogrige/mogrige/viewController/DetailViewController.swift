//
//  DetailViewController.swift
//  mogrige
//
//  Created by Hyunseok Yang on 2020/10/06.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    // 더미 데이터
    @IBOutlet weak var artImg: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        artImg.image = UIImage(named: "thumbsUp")
    }
    
    
    //공유기능(더미사진)
    @IBAction func shareButtonPressed(_ sender: Any) {
        let items = [artImg.image!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
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
