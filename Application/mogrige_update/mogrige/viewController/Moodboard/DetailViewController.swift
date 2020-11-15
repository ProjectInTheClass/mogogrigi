//
//  DetailViewController.swift
//  mogrige
//
//  Created by Hyunseok Yang on 2020/10/06.
//


import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var frame1: UIView!
    @IBOutlet weak var frame2: UIView!
    @IBOutlet weak var frame3: UIView!
    @IBOutlet weak var frame4: UIView!
    @IBOutlet weak var frame5: UIView!
    @IBOutlet weak var section1: UIView!
    
    @IBOutlet weak var moodboardImg1: UIImageView!
    @IBOutlet weak var moodboardImg2: UIImageView!
    @IBOutlet weak var moodboardImg3: UIImageView!
    @IBOutlet weak var moodboardImg4: UIImageView!
    @IBOutlet weak var moodboardImg5: UIImageView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var first: UILabel!
    @IBOutlet weak var second: UILabel!
    @IBOutlet weak var third: UILabel!
    
    
    @IBOutlet weak var textFrame2: UILabel!
    @IBOutlet weak var textFrame3: UILabel!
    
    
    /*
    var firstKeyWord: String?
    var secondKeyWord: String?
    var thirdKeyWord: String?
    var mainDescription: String?
    var subDescription: String?
    var artworks: [UIImage?] = []
    */
    let dummyImg = ["dummy_img1", "dummy_img2", "dummy_img3", "dummy_img4", "dummy_img5"]
    
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var frame = CGRect.zero
    
    var Board: Board?
    
    let paragraphStyle = NSMutableParagraphStyle()
    func textFrame2Style() {
        //textFrame2 의 줄간격 설정과 텍스트 넣는 곳
        paragraphStyle.lineSpacing = 4//이게 줄간격
        var attributedText: NSAttributedString
        if Board?.mainDescription == nil {
            attributedText = NSAttributedString(string: "부엌 창문에선 노을 볕이 길게 드리워지고 고양이는 초록 체크무늬 담요에 누워 잠들었다.", attributes: [.paragraphStyle : paragraphStyle])
        } else {
            attributedText = NSAttributedString(string: (Board?.mainDescription)!, attributes: [.paragraphStyle : paragraphStyle])
        }
        
        textFrame2.numberOfLines = 0
        textFrame2.sizeToFit()
        textFrame2.attributedText = attributedText
    }
    
    func textFrame3Style() {
        paragraphStyle.lineSpacing = 3.5//이게 줄간격
        var attributedText: NSAttributedString
        if Board?.subDescription == nil {
            attributedText = NSAttributedString(string: "전체적으로 브라운과 오렌지의 노을 빛으로 배색하고 포인트 컬러를 체크무늬에 표현한다. 늘어진 자세의 고양이는 검은 실루엣으로 하여 그림자와 그 형태로만 간접적으로 그려 쓸쓸함과 따뜻함을 동시에 보여준다.", attributes: [.paragraphStyle : paragraphStyle])
        } else {
            attributedText = NSAttributedString(string: (Board?.subDescription)!, attributes: [.paragraphStyle : paragraphStyle])
        }
        
        /// let
        textFrame3.numberOfLines = 0
        textFrame3.sizeToFit()
        textFrame3.attributedText = attributedText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ModalViewController에서 전달하는 이미지 받기
        if Board?.images?.count == 1 {
            moodboardImg1.image = UIImage(data: (Board?.images![0])!)
        } else if Board?.images?.count == 2 {
            moodboardImg1.image = UIImage(data: (Board?.images![0])!)
            moodboardImg2.image = UIImage(data: (Board?.images![1])!)
        } else if Board?.images?.count == 3 {
            moodboardImg1.image = UIImage(data: (Board?.images![0])!)
            moodboardImg2.image = UIImage(data: (Board?.images![1])!)
            moodboardImg3.image = UIImage(data: (Board?.images![2])!)
        } else if Board?.images?.count == 4 {
            moodboardImg1.image = UIImage(data: (Board?.images![0])!)
            moodboardImg2.image = UIImage(data: (Board?.images![1])!)
            moodboardImg3.image = UIImage(data: (Board?.images![2])!)
            moodboardImg4.image = UIImage(data: (Board?.images![3])!)
        } else if Board?.images?.count == 5 {
            moodboardImg1.image = UIImage(data: (Board?.images![0])!)
            moodboardImg2.image = UIImage(data: (Board?.images![1])!)
            moodboardImg3.image = UIImage(data: (Board?.images![2])!)
            moodboardImg4.image = UIImage(data: (Board?.images![3])!)
            moodboardImg5.image = UIImage(data: (Board?.images![4])!)
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
        
        
        //아트웍 이미지 갤러리
        pageControl.numberOfPages = Board!.images!.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.darkGray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        
        // 수정필요함
        setUpScreen()
        first?.text = Board?.keyword1
        second?.text = Board?.keyword2
        third?.text = Board?.keyword3
        
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
    
    
    //아트웍 갤러리
    func setUpScreen() {
        for index in 0..<Board!.images!.count {
            
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let imgView = UIImageView(frame: frame)
            imgView.contentMode = .scaleAspectFill
            //imgView.image = Board!.images![index]
            imgView.clipsToBounds = true
            
            self.scrollView.addSubview(imgView)
            scrollView.sendSubviewToBack(imgView)
        }
        
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(Board!.images!.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
    }
    
    //dot에 현재 페이지 표시해주기
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }

}



