//
//  MoodboardViewController.swift
//  mogrige
//
//  Created by 장은비 on 2020/10/27.
//

import UIKit

class MoodboardViewController: UIViewController, UIScrollViewDelegate, UITextViewDelegate {

    @IBOutlet weak var frame1: UIView!
    @IBOutlet weak var frame2: UIView!
    @IBOutlet weak var frame3: UIView!
    @IBOutlet weak var frame4: UIView!
    @IBOutlet weak var frame5: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    @IBOutlet weak var keyword1: UILabel!
    @IBOutlet weak var keyword2: UILabel!
    @IBOutlet weak var keyword3: UILabel!
    
    
    @IBOutlet weak var description1: UITextView!
    
    
    
    
    //아트웍 이미지 어레이
    var artworks = [
        "IMG_9572",
        "dummy_img2",
        "dummy_img3",
        "dummy_img4",
        "dummy_img5"
    ]
    
    
    var frame = CGRect.zero
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        description1.clipsToBounds = true
        description1.delegate = self
        
        
        //아트웍 이미지 갤러리
        pageControl.numberOfPages = artworks.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.darkGray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        
        setUpScreen()
        

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
        for index in 0..<artworks.count {
            
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let imgView = UIImageView(frame: frame)
            imgView.contentMode = .scaleAspectFill
            imgView.image = UIImage(named: artworks[index])
            imgView.clipsToBounds = true
            
            self.scrollView.addSubview(imgView)
            scrollView.sendSubviewToBack(imgView)
        }
        
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(artworks.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
    }
    
    //dot에 현재 페이지 표시해주기
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }

}
