//
//  TextViewController.swift
//  SeSAC3Week6
//
//  Created by 김지연 on 2023/08/22.
//

import UIKit
import SnapKit

class TextViewController: UIViewController {
    
    // 1. 인스턴스 가져오기
    let picker = UIColorPickerViewController()
    
    
    
    // 익명함수 이용하기
    lazy var photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemMint
        view.contentMode = .scaleAspectFill
        
        return view
    }() // 이름 없는 함수 호출
    
    let titleTextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "제목을 입력해주세요"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        
        return view
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        [photoImageView, titleTextField].forEach {
            view.addSubview($0)
        }
        
        setupConstraints()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 2. available - 갤러리에 접근할 수 있는지 권한
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("갤러리 사용 불가, 사용자에게 토스트/얼럿") //-> 권한 허용해달라 설정 페이지 유도
            return
        }
//        picker.delegate = self
//        picker.sourceType = .camera  //.photoLibrary
//        picker.allowsEditing = true // 편집 화면
        
        // 갤러리 화면 띄우기
        present(picker, animated: true)
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view).multipliedBy(0.3) // 높이가 뷰의 30퍼 차지한다
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            //make.leading.equalTo(view).inset(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
    
    
    func setImageView() -> UIImageView {
        let view = UIImageView()
        view.backgroundColor = .systemMint
        view.contentMode = .scaleAspectFill
        
        return view
    }

}

extension TextViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 취소 버튼 클릭 시
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
        print(#function)
    }
    
    // 사진을 선택하거나 카메라 촬영 직후 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //미디어에 대한 정보 선택이 끝났을 때 무얼 해줘야 하나
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.photoImageView.image = image
            dismiss(animated: true)
        }
    }
    
}
