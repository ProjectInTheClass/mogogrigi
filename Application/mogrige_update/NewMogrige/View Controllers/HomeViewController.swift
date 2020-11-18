//
//  ViewController.swift
//  mogrige_final
//
//  Created by Hyunseok Yang on 2020/11/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ratioView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var keyword01: UILabel!
    @IBOutlet weak var keyword02: UILabel!
    @IBOutlet weak var keyword03: UILabel!

    @IBOutlet weak var randomTip: UILabel!
    
    var divisor: CGFloat!
    var lastKeywords: Array<Any> = []
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //swipe animation 구현
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        //let scale = min(100/abs(xFromCenter), 1)
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        //카드 돌아가는 애니메이션
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
            //.scaledBy(x: scale, y: scale)
        
        //카드를 원래 자리로 복귀
        func cardFormatReset() {
            card.center = self.view.center
            //message.alpha = 0
            card.transform = CGAffineTransform.identity
            animate()
        }
        
        //******. 저장합니다는 잘되는데 다음키워드는 어느 x좌표의 순간! 지진이 나네요. ******
        if card.center.x < 0 {
            randomTip.text = "다음 키워드"
        } else {
            randomTip.text = "저장합니다"
        }
        
        
        //card fade away when it passes certain pointof x-axis
        if sender.state == UIGestureRecognizer.State.ended {
            
            if card.center.x < 85 {
                // move off to the left side
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 300, y: card.center.y + 20)
                })
                cardFormatReset()
                randomPicked1()
                randomPicked2()
                randomPicked3()
                randomTips()
                return
            } else if card.center.x > (view.frame.width - 75) {
                // move off to the right side
                UIView.animate(withDuration: 0.3,animations: {
                    card.center = CGPoint(x: card.center.x + 300, y: card.center.y + 20)
                })
                
                //화면전환
                self.performSegue(withIdentifier: "toEditor", sender: nil)
                
                cardFormatReset()
                
                return
            } else {
                cardFormatReset()
                randomTips()
            }
        }
    }
    
    
    
    //카드가 끝까지 넘어가지 않은 경우 원래 자리로 복귀
    func animate() {
        UIView.animate(withDuration: 0.2, animations: {
            self.cardView.center = self.view.center
        })
    }
    

    
    //랜덤 팁 띄우기
    func randomTips() {
        var resultSet = Set<String>()
        
        while resultSet.count < 3 {
            let randomIndext = Int.random(in: 0...tipList.count-1)
            resultSet.insert(tipList[randomIndext])
        }
        let resultArray = Array(resultSet)
        randomTip.text = resultArray[0]
        randomTip.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
        
        let lineStyle = NSMutableParagraphStyle()
        lineStyle.lineSpacing = 3
        lineStyle.alignment = .center
        let attributedLine = NSAttributedString(string: randomTip.text!, attributes: [.paragraphStyle: lineStyle])
        randomTip.attributedText = attributedLine
    }
    
    
    
    
    // 랜덤키워드 만들기 - 1
    func randomPicked1() {
        var resultSet = Set<String>()
        
        while resultSet.count < 3 {
            let randomIndext = Int.random(in: 0...keywordList1.count-1)
            resultSet.insert(keywordList1[randomIndext])
        }
        let resultArray = Array(resultSet)
        keyword01.text = resultArray[0]
        
    }
    
    // 랜덤키워드 만들기 - 2
    func randomPicked2() {
        var resultSet = Set<String>()
        
        while resultSet.count < 3 {
            let randomIndext = Int.random(in: 0...keywordList2.count-1)
            resultSet.insert(keywordList2[randomIndext])
        }
        let resultArray = Array(resultSet)
        keyword02.text = resultArray[1]
        
    }
    
    // 랜덤키워드 만들기 - 3
    func randomPicked3() {
        var resultSet = Set<String>()
        
        while resultSet.count < 3 {
            let randomIndext = Int.random(in: 0...keywordList3.count-1)
            resultSet.insert(keywordList3[randomIndext])
        }
        let resultArray = Array(resultSet)
        keyword03.text = resultArray[2]
        
    }
    
    
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        
        naviFont()
        
        //카드 tilt 애니메이션 추가
        divisor = (view.frame.width / 2) / 0.61
        //message.alpha = 0
        
        //그림자 만들기
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.11
        cardView.layer.shadowOffset = CGSize(width: 0, height: 11)
        cardView.layer.shadowRadius = 10
        
        
//        //탭바 커스텀
//        self.tabBarItem.image = UIImage(named: "mo_tabicon_homeOff")
//        self.tabBarItem.selectedImage = UIImage(named: "mo_tabicon_homeOn")
        

    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        randomPicked1()
        randomPicked2()
        randomPicked3()
        randomTips()
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditor" {
            if let destinationVC = segue.destination as? UINavigationController,
               let ChildVC = destinationVC.viewControllers.first as? EditorViewController{
                ChildVC.selectedTitle = [(keyword01.text!),  (keyword02.text!),  (keyword03.text!)]
            }
        }
    }
    }



