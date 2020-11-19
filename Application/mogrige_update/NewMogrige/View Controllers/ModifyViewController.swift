//
//  ModyfyViewController.swift
//  NewMogrige
//
//  Created by Hyunseok Yang on 2020/11/19.
//

import UIKit
import MobileCoreServices
import YPImagePicker

class ModifyViewController: UIViewController, UITextViewDelegate {

    var editTarget: Board?
    var selectedImg: [UIImage] = []
    var prepareTitle: [String] = []
    var legacyImg:[UIImage] = []
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
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
        
        prepareTitle = [((editTarget?.keyword1)!), ((editTarget?.keyword2)!), ((editTarget?.keyword3)!)]
        
        if legacyImg.count < 5{
                    let photoAlert = UIAlertController(title: "", message: "반드시 5장의 사진을 선택해주세요.", preferredStyle: UIAlertController.Style.alert)
                    photoAlert.addAction(UIAlertAction(title: "계속하기", style: UIAlertAction.Style.default, handler: nil))
                    
                    self.present(photoAlert, animated: true, completion: nil)
                } else {
                    //코어데이터 전달
                    DataManager.shared.deletBoard(self.editTarget)
                    DataManager.shared.addnewBoard(prepareTitle[0], prepareTitle[1], prepareTitle[2], paraMainText: mainDescription.text, paraSubText: subDescription.text, legacyImg, false)
                    NotificationCenter.default.post(name: EditorViewController.newListDidInsert, object: nil)
                    performSegue(withIdentifier: "UnwindToHome", sender: self)
                    DataManager.shared.saveContext()
                }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light

        naviFont()
        photoGuide.textColor = UIColor(red: 180/255, green: 176/255, blue: 168/255, alpha: 1)
        
        // title Label에 랜덤키워드 띄우기
        mainTitle.text = "\((editTarget?.keyword1)!),\((editTarget?.keyword2)!), \((editTarget?.keyword3)!)"
        
        // textview placeholder 기본 설정
        mainDescription.delegate = self
        mainDescription.text = editTarget!.text1
        
        subDescription.delegate = self
        subDescription.text = editTarget!.text2
        
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
        
        
        let legacyImgSource1: UIImage = UIImage(data: (editTarget?.images![0])!)!
        let legacyImgSource2: UIImage = UIImage(data: (editTarget?.images![0])!)!
        let legacyImgSource3: UIImage = UIImage(data: (editTarget?.images![0])!)!
        let legacyImgSource4: UIImage = UIImage(data: (editTarget?.images![0])!)!
        let legacyImgSource5: UIImage = UIImage(data: (editTarget?.images![0])!)!
        legacyImg = [legacyImgSource1, legacyImgSource2, legacyImgSource3, legacyImgSource4, legacyImgSource5]
                
        imgPickButton.imgPickBtn()
        
        self.hideKeyboard()
    }
    
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
            legacyImg = selectedImg
            picker.dismiss(animated: true) {
                }
            }
        present(picker, animated: true, completion: nil)

        }
    
    //최대 글자수 제한
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        var newText = textView.text!
        newText.removeAll { (character) -> Bool in
        return character == " " || character == "\n" }
        if textView == mainDescription {return (newText.count + text.count) <= 50}
        else if textView == subDescription{return (newText.count + text.count) <= 100}
        return true
    }
    
}
