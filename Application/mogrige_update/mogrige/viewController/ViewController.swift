//
//  ViewController.swift
//  mogrige
//
//  Created by Hyunseok Yang on 2020/09/23.
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
        //카드 tilt 애니메이션 추가
        divisor = (view.frame.width / 2) / 0.61
        //message.alpha = 0
        
        //그림자 만들기
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.11
        cardView.layer.shadowOffset = CGSize(width: 0, height: 11)
        cardView.layer.shadowRadius = 10
        
        //언더라인1
        let thickness: CGFloat = 0.8
        let bottomLine1 = CALayer()
        let bottomLine2 = CALayer()
        let bottomLine3 = CALayer()
        
        bottomLine1.frame = CGRect(x: 0.0, y: self.keyword01.frame.size.height + 5, width: self.keyword01.frame.width, height: thickness)
        bottomLine1.backgroundColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1).cgColor
        keyword01.layer.addSublayer(bottomLine1)
        
        //언더라인2
        bottomLine2.frame = CGRect(x: 0.0, y: self.keyword02.frame.size.height + 5, width: self.keyword02.frame.width, height: thickness)
        bottomLine2.backgroundColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1).cgColor
        keyword02.layer.addSublayer(bottomLine2)
        
        //언더라인3
        bottomLine3.frame = CGRect(x: 0.0, y: self.keyword03.frame.size.height + 5, width: self.keyword03.frame.width, height: thickness)
        bottomLine3.backgroundColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1).cgColor
        keyword03.layer.addSublayer(bottomLine3)
        
        
        
        

    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        randomPicked1()
        randomPicked2()
        randomPicked3()
        randomTips()
    }

    
    
    
    
    // 모달에 데이터 전달하기
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let vc = segue.destination as? ModalViewController else { return }
        
        vc.selectedTitle = "\(keyword01.text!),  \(keyword02.text!),  \(keyword03.text!)"
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditor" {
            if let destinationVC = segue.destination as? UINavigationController,
               let ChildVC = destinationVC.viewControllers.first as? ModalViewController{
                ChildVC.selectedTitle = [(keyword01.text!),  (keyword02.text!),  (keyword03.text!)]
            }
        }
    }

}


