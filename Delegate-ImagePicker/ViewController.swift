//
//  ViewController.swift
//  Delegate-ImagePicker
//
//  Created by 이학진 on 2022/07/05.
//

import UIKit

class ViewController: UIViewController , UINavigationControllerDelegate{
    @IBOutlet var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pick(_ sender: Any) {
        // 이미지 피커 컨트롤러 생성
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary // 이미지 소스로 사진 라이브러리 선택
        picker.allowsEditing = true // 이미지 편집 기능 On
        // 델리게이트 지정
        picker.delegate = self
        
        // 이미지 피커 컨트롤러 실행
        self.present(picker, animated: false)
    }

}
// MARK: 이미지 피커 컨트롤러 델리게이트 메소드
extension ViewController: UIImagePickerControllerDelegate {
    // 이미지 피커에서 이미지를 선택하지 않고 취소했을 때 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 이미지 피커 컨트롤러 창 닫기
        print("이미지 선택하지않고 취소한 경우")
        
        self.dismiss(animated: false) { () in
            // 알림 창 호출
            let alert = UIAlertController(title: "", message: "이미지 선택이 취소되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
        }
    }
    // 이미지 피커에서 이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("이미지 선택")
        // 이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: false) { () in
            // 이미지를 이미지 뷰에 표시
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.imgView.image = img
        }
    }
}


