//
//  FileManager+Extension.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/09/05.
//

//FileManager+Extension
import UIKit

extension UIViewController {
    //document 폴더에 이미지를 저장하는 메서드
    func saveImageToDocument(fileName: String, image: String) {
        // 1. 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 2. 저장할 경로 설정(세부 경로, 이미지를 저장할 위치)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        // 3. 이미지 변환
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: URL(string: image)!)
            let img = UIImage(data: data)!
            guard let data = img.jpegData(compressionQuality: 0.5) else { return }

            // 4. 이미지 저장
            do {
                try data.write(to: fileURL)
            } catch let error {
                print("file save error", error)
            }
         
        }
        
        
        
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage {
        
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "photo")! }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        print(fileURL)
        print(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)!
        } else {
            return UIImage(systemName: "book.closed.fill")!
        }
        
    }
}
