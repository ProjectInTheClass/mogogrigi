//
//  ColorPickerViewController.swift
//  mogrige
//
//  Created by Hyunseok Yang on 2020/10/20.
//

import UIKit

class ColorPickerViewController: UIViewController {

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션 back 버튼 텍스트 없애기 + 색변경
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

        // Do any additional setup after loading the view.
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
