//
//  ViewController.swift
//  Msg-AlertController
//
//  Created by 이학진 on 2022/06/03.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var result: UILabel!
    
    @IBAction func alert(_ sender: Any) {
        // 메시지창 객체 생성
        let alert = UIAlertController(title: "선택", message: "항목을 선택해주세요.", preferredStyle: .alert)
        
        // 취소버튼
        let cancle = UIAlertAction(title: "취소", style: .cancel) { (btn) in
            self.result.text = "취소 버튼을 클릭했습니다."
        }
        // 확인버튼
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            self.result.text = "확인 버튼을 클릭했습니다."
        }
        // 실행 버튼
        let exec = UIAlertAction(title: "실행", style: .destructive) {(_) in
            self.result.text = "실행 버튼을 클릭했습니다."
        }
        // 중지 버튼
        let stop = UIAlertAction(title: "중지", style: .default) {(_) in
            self.result.text = "중지 버튼을 클릭했습니다."
        }
        
        // 버튼을 컨트롤러에 등록
        alert.addAction(ok)
        alert.addAction(cancle)
        alert.addAction(exec)
        alert.addAction(stop)
        
        // 메시지 창 실행
        self.present(alert, animated: true)
    }
    
    // 로그인 버튼
    @IBAction func login(_ sender: Any) {
        let title = "iTunes Store에 로그인"
        let message = "사용자의 Apple ID test@iCloud.com의 암호를 입력하십시오"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            if let tf = alert.textFields?.first {
                print("입력된 값은 \(tf.text!) 입니다.")
            } else {
                print("입력된 값이 없습니다.")
            }
        }
        alert.addAction(cancle)
        alert.addAction(ok)
        
        alert.addTextField(configurationHandler: { (tf) in
            tf.placeholder = "암호" // 안내메시지
            tf.isSecureTextEntry = true // 비밀번호 처리
        })
        
        self.present(alert, animated: true)
    }
    
    @IBAction func auth(_ sender: Any) {
        // 메시지 창 관련 객체 정의
        let msg = "로그인"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            let loginId = alert.textFields?.first?.text
            let loginPw = alert.textFields?[1].text
            
            if loginId == "qwe123" && loginPw == "1234" {
                self.result.text = "인증 성공"
            } else {
                self.result.text = "인증 실패"
            }
        }
        // 정의된 액션 버튼 객체를메시지창에 추가
        alert.addAction(cancle)
        alert.addAction(ok)
        
        // 아이디 필드 추가
        alert.addTextField(configurationHandler: { (tf) in
            tf.placeholder = "아이디" // textfield의 default msg
            tf.isSecureTextEntry = false // 입력시 문자 보임
        })
        
        // 비밀번호 필드 추가
        alert.addTextField(configurationHandler: { (tf) in
            tf.placeholder = "비밀번호" // textfield의 default msg
            tf.isSecureTextEntry = true // 입력시 문자 안보임
        })
        self.present(alert, animated: true)
    }
}

