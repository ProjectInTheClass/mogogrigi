//
//  DetailViewController.swift
//  NewMogrige
//
//  Created by EunBee Jang on 2020/11/15.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var frame1: UIView!
    @IBOutlet weak var frame2: UIView!
    @IBOutlet weak var frame3: UIView!
    @IBOutlet weak var frame4: UIView!
    @IBOutlet weak var frame5: UIView!
    @IBOutlet weak var section1: UIView!
    @IBOutlet weak var section2: UIView!
    
    @IBOutlet weak var moodboardImg1: UIImageView!
    @IBOutlet weak var moodboardImg2: UIImageView!
    @IBOutlet weak var moodboardImg3: UIImageView!
    @IBOutlet weak var moodboardImg4: UIImageView!
    @IBOutlet weak var moodboardImg5: UIImageView!
    

    @IBOutlet weak var first: UILabel?
    @IBOutlet weak var second: UILabel?
    @IBOutlet weak var third: UILabel?
    
    @IBOutlet weak var boardDate: UILabel?
    
    @IBOutlet weak var textFrame2: UILabel!
    @IBOutlet weak var textFrame3: UILabel!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    var frame = CGRect.zero
    var capture:[UIImage] = []
    
    var board: Board?
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .full
        f.timeStyle = .none
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    let paragraphStyle = NSMutableParagraphStyle()
    func textFrame2Style() {
        //textFrame2 의 줄간격 설정과 텍스트 넣는 곳
        paragraphStyle.lineSpacing = 4//이게 줄간격
        var attributedText: NSAttributedString
        if board?.text1 == nil {
            attributedText = NSAttributedString(string: "부엌 창문에선 노을 볕이 길게 드리워지고 고양이는 초록 체크무늬 담요에 누워 잠들었다.", attributes: [.paragraphStyle : paragraphStyle])
        } else {
            attributedText = NSAttributedString(string: (board?.text1)!, attributes: [.paragraphStyle : paragraphStyle])
        }
        
        textFrame2?.sizeToFit()
        textFrame3?.sizeToFit()
        textFrame2?.attributedText = attributedText
    }
    
    func textFrame3Style() {
        paragraphStyle.lineSpacing = 3.5//이게 줄간격
        var attributedText: NSAttributedString
        if board?.text2 == nil {
            attributedText = NSAttributedString(string: "전체적으로 브라운과 오렌지의 노을 빛을 배색하고 나무질감의 흔들의자와 담요를 적절히 자리잡아 그린다. 고양이는 실로엣으로 표현하고 전체적으로 대비를 강하게 준다.", attributes: [.paragraphStyle : paragraphStyle])
        } else {
            attributedText = NSAttributedString(string: (board?.text2)!, attributes: [.paragraphStyle : paragraphStyle])
        }
        
        textFrame3.adjustsFontSizeToFitWidth = true
        textFrame3.adjustsFontForContentSizeCategory = true
        textFrame3.minimumScaleFactor = 0.5
        textFrame3?.numberOfLines = 0
        //view.addSubview(textFrame3)
        textFrame3?.sizeToFit()
        textFrame3?.attributedText = attributedText
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? ModifyViewController {
            vc.editTarget = board
        }
    }
    
    // 보드 삭제 액션
    @IBAction func delet(_ sender: Any) {
        
        let alert = UIAlertController(title: "삭제확인", message: "정말로 삭제할까요?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "삭제", style: .destructive) {[weak self] (action) in
            DataManager.shared.deletBoard(self?.board)
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        
        naviFont()
        
        first?.text = board?.keyword1
        second?.text = board?.keyword2
        third?.text = board?.keyword3
        
        boardDate?.text = formatter.string(for: board?.date)
        
        
        if board?.images?.count == 1 {
            moodboardImg1.image = UIImage(data: (board?.images![0])!)
        } else if board?.images?.count == 2 {
            moodboardImg1.image = UIImage(data: (board?.images![0])!)
            moodboardImg2.image = UIImage(data: (board?.images![1])!)
        } else if board?.images?.count == 3 {
            moodboardImg1.image = UIImage(data: (board?.images![0])!)
            moodboardImg2.image = UIImage(data: (board?.images![1])!)
            moodboardImg3.image = UIImage(data: (board?.images![2])!)
        } else if board?.images?.count == 4 {
            moodboardImg1.image = UIImage(data: (board?.images![0])!)
            moodboardImg2.image = UIImage(data: (board?.images![1])!)
            moodboardImg3.image = UIImage(data: (board?.images![2])!)
            moodboardImg4.image = UIImage(data: (board?.images![3])!)
        } else if board?.images?.count == 5 {
            moodboardImg1.image = UIImage(data: (board?.images![0])!)
            moodboardImg2.image = UIImage(data: (board?.images![1])!)
            moodboardImg3.image = UIImage(data: (board?.images![2])!)
            moodboardImg4.image = UIImage(data: (board?.images![3])!)
            moodboardImg5.image = UIImage(data: (board?.images![4])!)
        } else {
            moodboardImg1.image = UIImage(named: dummyImg[0])
            moodboardImg2.image = UIImage(named: dummyImg[1])
            moodboardImg3.image = UIImage(named: dummyImg[2])
            moodboardImg4.image = UIImage(named: dummyImg[3])
            moodboardImg5.image = UIImage(named: dummyImg[4])
            return
        }
        
        view.backgroundColor = UIColor(red: 240/255, green: 239/255, blue: 238/255, alpha: 1)

        
        
        textFrame2Style()
        textFrame3Style()
        
        
        //frame1 그림자
        frame1.layer.shadowColor = UIColor.black.cgColor
        frame1.layer.shadowOpacity = 0.3
        frame1.layer.shadowRadius = 2
        frame1.layer.shadowOffset = CGSize(width: 1, height: 2)
        ///frame1 그림자 끝
        
        //frame1 백그라운드 컬러
        self.frame1.backgroundColor = UIColor.init(red: 230/255, green: 229/255, blue: 226/255, alpha: 1)
        
        //frame2 그림자
        frame2.layer.shadowColor = UIColor.black.cgColor
        frame2.layer.shadowOpacity = 0.5
        frame2.layer.shadowRadius = 2
        frame2.layer.shadowOffset = CGSize(width: 1, height: 2)
        ///frame2 그림자 끝
        
        //frame3 그림자
        frame3.layer.shadowColor = UIColor.black.cgColor
        frame3.layer.shadowOpacity = 0.3
        frame3.layer.shadowRadius = 2
        frame3.layer.shadowOffset = CGSize(width: 1, height: 2)
        ///frame3 그림자 끝
        
        //frame4 그림자
        frame4.layer.shadowColor = UIColor.black.cgColor
        frame4.layer.shadowOpacity = 0.3
        frame4.layer.shadowRadius = 2
        frame4.layer.shadowOffset = CGSize(width: 1, height: 2)
        ///frame4 그림자 끝
        
        //frame5 그림자
        frame5.layer.shadowColor = UIColor.black.cgColor
        frame5.layer.shadowOpacity = 0.3
        frame5.layer.shadowRadius = 2
        frame5.layer.shadowOffset = CGSize(width: 1, height: 2)
        ///frame5 그림자 끝
        
        //frame5 백그라운드 컬러
        self.frame5.backgroundColor = UIColor.init(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
    }
    
    // toast messge setting
    func showToast(messge: String, font: UIFont = UIFont.systemFont(ofSize: 14.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = messge
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

    
    
    func capturImg() {
        
        let renderer1 = UIGraphicsImageRenderer(size: section1.bounds.size)
        let image1 = renderer1.image { ctx in
            section1.drawHierarchy(in: section1.bounds, afterScreenUpdates: true)
        }
        capture.append(image1)
        
        let renderer2 = UIGraphicsImageRenderer(size: section1.bounds.size)
        let image2 = renderer2.image { ctx in
            section2.drawHierarchy(in: section2.bounds, afterScreenUpdates: true)
        }
        capture.append(image2)
    }
    
    
    // 공유하기 버튼
    @IBAction func share(_ sender: Any) {
        
        capturImg()
        
        let activityVC = UIActivityViewController(activityItems: capture, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true)
        
        activityVC.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                self.showToast(messge: "share success")
            } else {
                self.showToast(messge: "share cancel")
            }
            if let shareError = error {
                self.showToast(messge: "\(shareError.localizedDescription)")
            }
        }
        
        }
    
        
}
