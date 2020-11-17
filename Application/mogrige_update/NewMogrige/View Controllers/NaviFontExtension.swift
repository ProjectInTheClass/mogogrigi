//
//  NaviFontExtension.swift
//  NewMogrige
//
//  Created by 장은비 on 2020/11/16.
//

import Foundation
import UIKit

extension UIViewController {
    
    func naviFont() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSerifCJKkr-Medium", size: 15) as Any]
    }
    
    
}
