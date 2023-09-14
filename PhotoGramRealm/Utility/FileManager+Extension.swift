//
//  FIleManager+Extension.swift
//  PhotoGramRealm
//
//  Created by 김지연 on 2023/09/05.
//

import UIKit

extension UIViewController {
    
    func documentDirectoryPath() -> URL? {
        // 1. 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory
        
    }
    
    func getFilePath(fileName: String) -> URL? {
        // 1. 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        // 2. 저장할 경로 설정(세부 경로, 이미지를 저장할 위치)
        return documentDirectory.appendingPathComponent(fileName)
    }
    
    //document 폴더에 이미지를 저장하는 메서드
    func saveImageToDocument(fileName: String, image: UIImage) {
        
        guard let fileURL = getFilePath(fileName: fileName) else { return }
        // 3. 이미지 변환
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        // 4. 이미지 저장
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
            // 사용자에게 보여줄 액션을 구현해야 한다.
        }
    }
    
    // document 폴더에서 이미지를 가져오는 메서드
    func loadImageFromDocument(fileName: String) -> UIImage {
        
        guard let fileURL = getFilePath(fileName: fileName) else { return UIImage(systemName: "photo")! }
        //print(fileURL)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)!
        } else {
            return UIImage(systemName: "photo")!
        }
        
    }
    
    
    func removeImageFromDocument(fileName: String) {
        
        guard let fileURL = getFilePath(fileName: fileName) else { return }
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error)
        }
        
    }
    
    
}

