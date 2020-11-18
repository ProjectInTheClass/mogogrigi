//
//  UIButtonExtension.swift
//  NewMogrige
//
//  Created by 장은비 on 2020/11/16.
//

import UIKit

extension UIButton {
    func floatinBtn(){
        backgroundColor = UIColor(red: 124/255, green: 82/255, blue: 40/255, alpha: 1)
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }
    
    
    func imgPickBtn(){
        //사진버튼 커스텀
        layer.cornerRadius = 23
        backgroundColor = UIColor(red: 213/255, green: 208/255, blue: 196/255, alpha: 1)
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 7)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.15
    }
    
    func filterBtn() {
        backgroundColor = UIColor(red: 213/255, green: 208/255, blue: 196/255, alpha: 1)
        layer.cornerRadius = frame.height / 2
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.2)
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.4
    }
    
}
