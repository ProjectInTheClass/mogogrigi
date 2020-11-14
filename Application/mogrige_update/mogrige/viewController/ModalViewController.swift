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
    
    var selectedTitle: [String?] = []
    var selectedImg: [UIImage?] = [] 
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var textTitle: UITextView!
    @IBOutlet weak var textDescription: UITextView!
    
    // 뭔가 작성했을 때만 경고창 뜨는걸로 하고 싶었으나 실패!! 
    @IBAction func backToHome(_ sender: Any) {
        if textTitle.text != nil {
            // create the alert
            let alert = UIAlertController(title: "UIAlertController", message: "지금까지 작성한 내용은 저장되지 않습니다. 처음으로 돌아갈까요?", preferredStyle: UIAlertController.Style.alert)

            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "남아있기", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "처음으로", style: UIAlertAction.Style.cancel, handler: {ACTION in self.dismiss(animated: true)}))

            // show the alert
                self.present(alert, animated: true, completion: nil)
        } else {dismiss(animated: true)}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션 타이틀 폰트 변경
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSerifCJKkr-Medium", size: 15)!]
        
        
        // title Label에 랜덤키워드 띄우기
        self.mainTitle.text = "\(selectedTitle[0]!), \(selectedTitle[1]!), \(selectedTitle[2]!)"
        
        // textview placeholder 기본 설정
        textTitle.delegate = self
        textTitle.text = "세 단어로 하나의 타이틀 문장을 만들어 주세요"
        textTitle.textColor = UIColor.lightGray
        
        textDescription.delegate = self
        textDescription.text = "떠오른 영감을 설명해 주세요"
        textDescription.textColor = UIColor.lightGray
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = self.storyboard?.instantiateViewController(identifier: "DetailMoodboard") as? DetailViewController {
            vc.firstKeyWord = selectedTitle[0]
            vc.secondKeyWord = selectedTitle[1]
            vc.thirdKeyWord = selectedTitle[2]
            vc.textTitle = textTitle.text
            vc.textDescription =  textDescription.text
            vc.artworks = selectedImg
            
            present(vc, animated: true, completion: nil)
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
    
    // 선택한 이미지를 UIImageView에 띄우는 기능
    /*
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            
            let captureImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            mainImage.image = captureImage
            
            self.dismiss(animated: true, completion: nil)
        }

    }
    */
    
    // textView placeholder 구현 함수 //펑션나누기
    
    func firstTextViewSetupView() {
        if textTitle.text == "세 단어로 하나의 타이틀 문장을 만들어 주세요" {
            textTitle.text = ""
            textTitle.textColor = UIColor.black
        } else if textTitle.text == "" {
            textTitle.text = "세 단어로 하나의 타이틀 문장을 만들어 주세요"
            textTitle.textColor = UIColor.lightGray
        }
    }
    
    func secondTextViewSetupView() {
        if textDescription.text == "떠오른 영감을 설명해 주세요" {
            textDescription.text = ""
            textDescription.textColor = UIColor.black
        } else if textDescription.text == "" {
            textDescription.text = "떠오른 영감을 설명해 주세요"
            textDescription.textColor = UIColor.lightGray
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
        if textTitle.text == "" {
            firstTextViewSetupView()
        }
        
        if textDescription.text == "" {
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


/*
extension ModalViewController: PHPickerViewControllerDelegate {

    // UIImageView에 불러온 이미지 띄우는 기능
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        picker.dismiss(animated: true) // 1

        let itemProvider = results.first?.itemProvider // 2

        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) { // 3
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in // 4
                DispatchQueue.main.async {
                    self.mainImage.image = image as? UIImage // 5
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
    }
   */
    


