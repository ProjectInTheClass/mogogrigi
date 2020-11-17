//
//  EditorViewController.swift
//  NewMogrige
//
//  Created by EunBee Jang on 2020/11/15.
//

import UIKit
import MobileCoreServices
import YPImagePicker

class EditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    //게시물 수정을 위한 코드
    var editTarget : Board?
    
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    var selectedTitle: [String] = []
    var selectedImg: [UIImage] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var mainDescription: UITextView!
    @IBOutlet weak var subDescription: UITextView!
    @IBOutlet weak var mainDesBack: UIView!
    @IBOutlet weak var subDesBack: UIView!
    @IBOutlet weak var imgPickButton: UIButton!
    
    @IBOutlet weak var photoGuide: UILabel!
    
    
    @IBAction func toListView(_ sender: Any) {
        if subDescription?.text != nil {
            // create the alert
            let alert = UIAlertController(title: "", message: "지금까지 작성한 내용은 저장되지 않습니다. 처음으로 돌아갈까요?", preferredStyle: UIAlertController.Style.alert)

            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "남아있기", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "처음으로", style: UIAlertAction.Style.cancel, handler: {ACTION in self.performSegue(withIdentifier: "UnwindToHome", sender: self)}))

            // show the alert
                self.present(alert, animated: true, completion: nil)
        } else {performSegue(withIdentifier: "UnwindToHome", sender: self)}
    }
    
    
    @IBAction func save(_ sender: Any) {
        
        DataManager.shared.addnewBoard(selectedTitle[0], selectedTitle[1], selectedTitle[2], paraMainText: mainDescription.text, paraSubText: subDescription.text, selectedImg)
        
        NotificationCenter.default.post(name: EditorViewController.newListDidInsert, object: nil)
        
        performSegue(withIdentifier: "UnwindToHome", sender: self)
        
    }
    

    
        
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //게시물 수정코드
        if let board = editTarget {
            navigationItem.title = "Edit a Board"
            mainDescription.text = board.text1
            subDescription.text = board.text2
            mainTitle.text = "\(editTarget?.keyword1), \(editTarget?.keyword2), \(editTarget?.keyword3)"
        }else {
            navigationItem.title = "Create New Board"
            mainDescription.text = "Place Holder"
            subDescription.text = "Place Holder"
            mainTitle.text = "\(selectedTitle[0]),\(selectedTitle[1]), \(selectedTitle[2])"
        }
        
        naviFont()
        photoGuide.textColor = UIColor(red: 180/255, green: 176/255, blue: 168/255, alpha: 1)
        
        // title Label에 랜덤키워드 띄우기
        
        
        // textview placeholder 기본 설정
        mainDescription.delegate = self
        mainDescription.text = "#고양이는 #저녁노을 지는 창가앞 #흔들의자에 몸을 둥글게 말고 잠들었다."
        mainDescription.textColor = UIColor.lightGray
        
        subDescription.delegate = self
        subDescription.text = "전체적으로 브라운과 오렌지의 노을 빛을 배색하고 나무질감의 흔들의자와 담요를 적절히 자리를 잡아 그린다. 고양이는 실루엣으로만 표현하고 전체적으로 대비를 강하게 한다."
        subDescription.textColor = UIColor.lightGray
        
        //텍스트 가리는 키보드 대응코드1
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisapear), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //텍스트박스 커스텀
        mainDescription?.layer.cornerRadius = 4
        mainDesBack.layer.cornerRadius = 4
        mainDesBack.layer.shadowColor = UIColor.darkGray.cgColor
        mainDesBack.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainDesBack.layer.shadowRadius = 2.5
        mainDesBack.layer.shadowOpacity = 0.1
        
        subDescription?.layer.cornerRadius = 4
        subDesBack.layer.cornerRadius = 4
        subDesBack.layer.shadowColor = UIColor.darkGray.cgColor
        subDesBack.layer.shadowOffset = CGSize(width: 0, height: 2)
        subDesBack.layer.shadowRadius = 2.5
        subDesBack.layer.shadowOpacity = 0.1
         
        
        imgPickButton.imgPickBtn()
        
    } //========viewDidLoad===========//
    
    
    
    //텍스트 가리는 키보드 대응코드2
    var isExpand : Bool = false
    @objc func keyboardApear(){
        if !isExpand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 250)
            isExpand = true
        }
    }

    @objc func keyboardDisapear(){
        if !isExpand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 250)
            isExpand = false
        }
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = self.storyboard?.instantiateViewController(identifier: "DetailMoodboard") as? DetailViewController {
            vc.firstKeyWord = selectedTitle[0]
            vc.secondKeyWord = selectedTitle[1]
            vc.thirdKeyWord = selectedTitle[2]
            vc.mainDescription = mainDescription.text
            vc.subDescription = subDescription.text
            vc.artworks = selectedImg
            
            present(vc, animated: true, completion: nil)
        }
    }
    */
    
    // 이미지 추가 버튼 클릭시 액션시트 구현 및 카메라, 포토라이브러리 설정
    @IBAction func buttonDidTap(_ sender: UIButton) {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 5

        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [self, unowned picker] items, cancelled in

            //이미지 넣을 빈배열 > 이게 코어데이터에 있어야하지 않을까

            if cancelled {
                picker.dismiss(animated: true, completion: nil)
                return
            }

            for item in items {
                switch item {
                case .photo(let photo):
                    //이미지를 배열에 넣어주는 code
                    selectedImg.append(photo.image)
                    print(photo)

                default:
                    print("")
                }
            }

            picker.dismiss(animated: true) {
                }
            }
        present(picker, animated: true, completion: nil)

        }
    
    // textView placeholder 구현 함수 //펑션나누기
    func firstTextViewSetupView() {
        if mainDescription?.text == "세 단어로 하나의 타이틀 문장을 만들어 주세요" {
            mainDescription?.text = ""
            mainDescription?.textColor = UIColor.black
        } else if mainDescription?.text == "" {
            mainDescription?.text = "세 단어로 하나의 타이틀 문장을 만들어 주세요"
            mainDescription?.textColor = UIColor.lightGray
        }
    }
    
    func secondTextViewSetupView() {
        if subDescription?.text == "떠오른 영감을 설명해 주세요" {
            subDescription?.text = ""
            subDescription?.textColor = UIColor.black
        } else if subDescription?.text == "" {
            subDescription?.text = "떠오른 영감을 설명해 주세요"
            subDescription?.textColor = UIColor.lightGray
        }
  
    }
}

// textView placeholder 상태 전달
extension EditorViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        firstTextViewSetupView()
        secondTextViewSetupView()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if mainDescription.text == "" {
            firstTextViewSetupView()
        }
        if subDescription.text == "" {
            secondTextViewSetupView()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
}

extension EditorViewController {
    static let newListDidInsert = Notification.Name(rawValue: "newListDidInsert")
}

