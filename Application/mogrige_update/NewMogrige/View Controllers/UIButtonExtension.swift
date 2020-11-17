//
//  UIButtonExtension.swift
//  NewMogrige
//
//  Created by 장은비 on 2020/11/16.
//

import UIKit

extension UIButton {
    func floatinBtn(){
        backgroundColor = UIColor.darkGray
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }
    
    
    func imgPickBtn(){
        //사진버튼 커스텀
        layer.cornerRadius = 23
        backgroundColor = UIColor(red: 222/255, green: 218/255, blue: 208/255, alpha: 1)
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2.5
        layer.shadowOpacity = 0.25
    }
}
