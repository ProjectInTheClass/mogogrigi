//
//  ModalViewController.swift
//  mogrige
//
//  Created by Hyunseok Yang on 2020/10/06.
//

import UIKit
import MobileCoreServices
import YPImagePicker

class ModalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    var selectedTitle: [String] = []
    var selectedImg: [UIImage] = []
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var mainDescription: UITextView!
    @IBOutlet weak var subDescription: UITextView!
    
    // 뭔가 작성했을 때만 경고창 뜨는걸로 하고 싶었으나 실패!! 
    @IBAction func backToHome(_ sender: Any) {
        if subDescription.text != nil {
            // create the alert
            let alert = UIAlertController(title: "돌아가기", message: "지금까지 작성한 내용은 저장되지 않습니다. 처음으로 돌아갈까요?", preferredStyle: UIAlertController.Style.alert)

            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "남아있기", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "처음으로", style: UIAlertAction.Style.cancel, handler: {ACTION in self.dismiss(animated: true)}))

            // show the alert
                self.present(alert, animated: true, completion: nil)
        } else {dismiss(animated: true)}
    }
    
    
    @IBAction func save(_ sender: Any) {
        
        DataManager.shared.addnewText(selectedTitle[0], selectedTitle[1], selectedTitle[2], mainDescription.text, subDescription.text, selectedImg)
        
        NotificationCenter.default.post(name: ModalViewController.newListDidInsert, object: nil)
        
        dismiss(animated: true, completion: nil)
        
        self.performSegue(withIdentifier: "toMoodboard", sender: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션 타이틀 폰트 변경
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSerifCJKkr-Medium", size: 15)!]
        
        
        // title Label에 랜덤키워드 띄우기
        self.mainTitle.text = "\(selectedTitle[0]), \(selectedTitle[1]), \(selectedTitle[2])"
        
        // textview placeholder 기본 설정
        mainDescription.delegate = self
        mainDescription.text = "세 단어로 하나의 타이틀 문장을 만들어 주세요"
        mainDescription.textColor = UIColor.lightGray
        
        subDescription.delegate = self
        subDescription.text = "떠오른 영감을 설명해 주세요"
        subDescription.textColor = UIColor.lightGray
        
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
                //닫을 때 무드보드에 전달
                //아래 코드 실험했지만 실패, 이 부분에서 크러시남
//                let shareVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//                for index in 0..<selectedImg.count {
//                    shareVC.sharedImg.append(selectedImg[index])
                }
            }
        present(picker, animated: true, completion: nil)

        }
    
    // textView placeholder 구현 함수 //펑션나누기
    
    func firstTextViewSetupView() {
        if mainDescription.text == "세 단어로 하나의 타이틀 문장을 만들어 주세요" {
            mainDescription.text = ""
            mainDescription.textColor = UIColor.black
        } else if mainDescription.text == "" {
            mainDescription.text = "세 단어로 하나의 타이틀 문장을 만들어 주세요"
            mainDescription.textColor = UIColor.lightGray
        }
    }
    
    func secondTextViewSetupView() {
        if subDescription.text == "떠오른 영감을 설명해 주세요" {
            subDescription.text = ""
            subDescription.textColor = UIColor.black
        } else if subDescription.text == "" {
            subDescription.text = "떠오른 영감을 설명해 주세요"
            subDescription.textColor = UIColor.lightGray
        }
  
    }
}

// textView placeholder 상태 전달
extension ModalViewController: UITextViewDelegate {
    
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

extension ModalViewController {
    static let newListDidInsert = Notification.Name(rawValue: "newListDidInsert")
}
