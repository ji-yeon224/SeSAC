//
//  BackupViewController.swift
//  PhotoGramRealm
//
//  Created by 김지연 on 2023/09/07.
//

import UIKit
import SnapKit
import Zip


class BackupViewController: BaseViewController {
    
    let backupButton = {
        let view = UIButton()
        view.backgroundColor = .systemOrange
        return view
    }()
    
    let restoreButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    let backupTableView = {
        let view = UITableView()
        view.rowHeight = 50
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backupTableView.delegate = self
        backupTableView.dataSource = self
    }
    
    override func configure() {
        super.configure()
        
        view.addSubview(backupButton)
        view.addSubview(restoreButton)
        view.addSubview(backupTableView)
        backupButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
    }
    
    @objc func backupButtonTapped() {
        
        // 1. 백업하고자 하는 파일들의 경로 배열 생성
        var urlPaths = [URL]()
        
        // 2. 도큐먼트 위치
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        // 3. 백업하고자 하는 파일 경로 ex) ~~~/~~/~~~/Document/default.realm
        let realmFile = path.appendingPathComponent("default.realm")
        
        //4. 3번 경로가 유효한지 확인
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            print("백업할 파일이 없습니다.")
            return
        }
        
        // 5. 압축하고자 하는 파일을 배열에 추가
        urlPaths.append(realmFile)
        
        // 6. 압축
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "JYArchive")
            print("location: \(zipFilePath)")
        } catch {
            print("압축을 실패했어요")
        }
        
        
        
        
    }
    
    @objc func restoreButtonTapped () {
        // 파일 앱을 활용한 복구
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false // 다중 선택 방지
        
        
        present(documentPicker, animated: true)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        backupTableView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
        }
        
        backupButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.leading.equalTo(view.safeAreaLayoutGuide)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
}


extension BackupViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else { // 파일 앱 내의 url 주소
            print("선택한 파일에 오류가 있어요")
            return
        }
        
        
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있어요")
            return
        }
        
        // 도큐먼트 폴더 내 저장할 경로 설정
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        print(sandboxFileURL)
        
        // 경로에 복구할 파일(zip)이 이미 있는지 확인
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            let fileURL = path.appendingPathComponent("JYArchive.zip") // 백업할 파일
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in // 진행률
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in // 압축 해제 완료
                    print("압축 해제 완료: \(unzippedFile)")
                })
            } catch {
                print("압축 해제 실패")
            }
            
        } else {
            
            // 경로에 복구할 파일이 없을 때의 대응
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                let fileURL = path.appendingPathComponent("JYArchive.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in // 진행률
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in // 압축 해제 완료
                    print("압축 해제 완료: \(unzippedFile)")
                    
                    exit(0) // 앱 강제종료, 좋은 코드는 아니다.
                    
                })
                
            } catch {
                print("압축 해제 실패")
            }
        }
        
        
    }
}


extension BackupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func fetchZipList() -> [String] {
        var list: [String] = []
        
        do {
            guard let path = documentDirectoryPath() else { return list }
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            let zip = docs.filter { $0.pathExtension == "zip"} // 확장자가 zip인 파일들만 가져오기
            for i in zip {
                list.append(i.lastPathComponent)
            }
        } catch {
            print("ERROR")
        }
        
        return list
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchZipList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        cell.textLabel?.text = fetchZipList()[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showActivityViewController(fileName: fetchZipList()[indexPath.row])
    }
    
    func showActivityViewController(fileName: String) {
        
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있어요")
            return
        }
        let backupFileURL = path.appendingPathComponent(fileName)
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: nil)
        present(vc, animated: true)
    }
    
}
