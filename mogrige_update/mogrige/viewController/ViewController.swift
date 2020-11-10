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
    
    
    @IBAction func closeModal(
        _ segue: UIStoryboardSegue) {
    }
    
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
        
        
        /*if xFromCenter > 0 {
            message.text = "저장합니다"
        } else {
            message.text = "다음 키워드"
        }*/
        
        //message.alpha = abs(xFromCenter) / view.center.x
        
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
                //message.text = "저장합니다"
                return
            } else if card.center.x > (view.frame.width - 75) {
                // move off to the right side
                UIView.animate(withDuration: 0.3,animations: {
                    card.center = CGPoint(x: card.center.x + 300, y: card.center.y + 20)
                })
                //화면전환 "ModalViewController"의 sroryboardID 지정 필요
                let modalVC = self.storyboard?.instantiateViewController(withIdentifier: "modalVC")
                modalVC?.modalTransitionStyle = .coverVertical
                self.present(modalVC!, animated: true, completion: nil)
               
                cardFormatReset()
                //message.text = "다른 단어를 봅니다"
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
        
        //언더라인
        let thickness: CGFloat = 0.8
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.keyword01.frame.size.height + 5, width: self.keyword01.frame.width, height: thickness)
        bottomLine.backgroundColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1).cgColor
        keyword01.layer.addSublayer(bottomLine)
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
        
        //언더라인2
        let thickness: CGFloat = 0.8
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.keyword02.frame.size.height + 5, width: self.keyword02.frame.width, height: thickness)
        bottomLine.backgroundColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1).cgColor
        keyword02.layer.addSublayer(bottomLine)
        
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
        
        //언더라인3
        let thickness: CGFloat = 0.8
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.keyword03.frame.size.height + 5, width: self.keyword03.frame.width, height: thickness)
        bottomLine.backgroundColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1).cgColor
        keyword03.layer.addSublayer(bottomLine)
        
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
        

    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        randomPicked1()
        randomPicked2()
        randomPicked3()
        randomTips()
    }

    
    
    
    
    // 모달에 데이터 전달하기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let pickedKeword = [keyword01.text, keyword02.text, keyword03.text]

        guard let vc = segue.destination as? ModalViewController else { return }
        
        let selectedTitle:String! = "\(pickedKeword[0]!),  \(pickedKeword[1]!),  \(pickedKeword[2]!)"

        vc.selectedTitle = selectedTitle
        
    }


}


