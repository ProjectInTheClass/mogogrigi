//
//  ViewController.swift
//  mogrige
//
//  Created by Hyunseok Yang on 2020/09/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var keyword01: UILabel!
    @IBOutlet weak var keyword02: UILabel!
    @IBOutlet weak var keyword03: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBAction func resetButton(_ sender: Any) {
        resetCard()
    }
    
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
        let scale = min(100/abs(xFromCenter), 1)
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        //카드 돌아가는 애니메이션
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor).scaledBy(x: scale, y: scale)
        
        //카드를 원래 자리로 복귀
        func cardFormatReset() {
            card.center = self.view.center
            thumbImageView.alpha = 0
            card.transform = CGAffineTransform.identity
        }
        
        
        if xFromCenter > 0 {
            thumbImageView.image = UIImage(named: "thumbsUp")
        } else {
            thumbImageView.image = UIImage(named: "thumbsDown")
        }
        
        thumbImageView.alpha = abs(xFromCenter) / view.center.x
        
        //card fade away when it passes certain pointof x-axis
        if sender.state == UIGestureRecognizer.State.ended {
            
            if card.center.x < 85 {
                // move off to the left side
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 300, y: card.center.y + 61)
                })
                lastKeywords = [keyword01.text!, keyword02.text!, keyword03.text!]
                cardFormatReset()
                randomPicked()
                return
            } else if card.center.x > (view.frame.width - 85) {
                // move off to the right side
                UIView.animate(withDuration: 0.3,animations: {
                    card.center = CGPoint(x: card.center.x + 300, y: card.center.y + 61)
                })
                //화면전환 "ModalViewController"의 sroryboardID 지정 필요
                let modalVC = self.storyboard?.instantiateViewController(withIdentifier: "modalVC")
                modalVC?.modalTransitionStyle = .coverVertical
                self.present(modalVC!, animated: true, completion: nil)
               
                cardFormatReset()
                return
            }
        }
    }
    
    
    
    //카드가 끝까지 넘어가지 않은 경우 원래 자리로 복귀
    func animate() {
        UIView.animate(withDuration: 0.2, animations: {
            self.cardView.center = self.view.center
        })
    }
    
    // 랜덤키워드 만들기
    func randomPicked() {
        var resultSet = Set<String>()
        
        while resultSet.count < 3 {
            let randomIndext = Int.random(in: 0...keywordList.count-1)
            resultSet.insert(keywordList[randomIndext])
        }
        let resultArray = Array(resultSet)
        
        keyword01.text = resultArray[0]
        keyword02.text = resultArray[1]
        keyword03.text = resultArray[2]
        
    }
    
    //직전 단어 다시 보기 버튼
    func resetCard() {
        animate()
        self.thumbImageView.alpha = 0
        self.cardView.alpha = 1
        self.cardView.transform = .identity
        
        keyword01.text = lastKeywords[0] as? String
        keyword02.text = lastKeywords[1] as? String
        keyword03.text = lastKeywords[2] as? String
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //카드 tilt 애니메이션 추가
        divisor = (view.frame.width / 2) / 0.61
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        randomPicked()
    }

    
    
    // 리픽 버튼 눌렀을때 랜덤픽하기 ---> swipe 적용으로 리픽버튼 OFF
//    @IBAction func rePick(_ sender: Any) {
//        randomPicked()
//    }
    
    
    
    // 모달에 데이터 전달하기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let pickedKeword = [keyword01.text, keyword02.text, keyword03.text]

        guard let vc = segue.destination as? ModalViewController else { return }
        
        let selectedTitle:String! = "\(pickedKeword[0]!),  \(pickedKeword[1]!),  \(pickedKeword[2]!)"

        vc.selectedTitle = selectedTitle
        
    }


}

