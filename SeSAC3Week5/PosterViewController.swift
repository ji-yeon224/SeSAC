//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by 김지연 on 2023/08/16.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

protocol CollectionViewAttributeProtocol {
    
    func configureCollectionView()
    func configureCollectionViewLayout()
    
}

class PosterViewController: UIViewController {

    @IBOutlet var posterCollectionView: UICollectionView!
    
    
    var recList: [Recommendation] = [Recommendation(page: 0, results: [], totalResults: 0, totalPages: 0), Recommendation(page: 0, results: [], totalResults: 0, totalPages: 0), Recommendation(page: 0, results: [], totalResults: 0, totalPages: 0), Recommendation(page: 0, results: [], totalResults: 0, totalPages: 0)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureCollectionViewLayout()
        
        dispatchGroupNotify()
        
        for family in UIFont.familyNames {
            print(family)
            
            for names in UIFont.fontNames(forFamilyName: family){
                print("==\(names)")
            }
                    
        }
        
        
        
//        let id = [673, 674, 675, 675]
//        let group = DispatchGroup()
//
//        for item in id {
//            group.enter()
//            callRecommendation(id: item) { data in
//                if item == 673 {
//                    self.recList[0] = data
//                }
//                group.leave()
//            }
//        }
//
//        group.notify(queue: .main){
//            self.posterCollectionView.reloadData()
//        }
        
    }
    
    @IBAction func sendNotification(_ sender: UIButton) {
        
        //포그라운드에서 알림이 안뜨는 것이 디폴트
        
        //1. 컨텐츠 2. 언제 -> 알림보내
        let content = UNMutableNotificationContent()
        content.title = "다마고치에게 물을 주세요"
        content.body = "아직 레벨 3이에요. 물을 주세요"
        content.badge = 100
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //content와 trigger를 패키지에 담기
        let request = UNNotificationRequest(identifier: "\(Date())", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print(error)
        }
        
        
    }
    
    
    func dispatchGroupEnterLeave() {
        let group = DispatchGroup()
        
        group.enter() // 작업량 +1
        callRecommendation(id: 671) { data in
            self.recList[0] = data
            print("==1")
            group.leave() // -1
        }
        
        group.enter()
        callRecommendation(id: 567646) { data in
            self.recList[1] = data
            print("==2")
            group.leave()
        }
        
        group.enter()
        callRecommendation(id: 672) { data in
            self.recList[2] = data
            print("==3")
            group.leave()
        }
        
        group.enter()
        callRecommendation(id: 673) { data in
            self.recList[3] = data
            print("==4")
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("====END")
            self.posterCollectionView.reloadData()
        }
    }
    
    func dispatchGroupNotify() {
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            self.callRecommendation(id: 671) { data in
                self.recList[0] = data
                print("==1")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.callRecommendation(id: 567646) { data in
                self.recList[1] = data
                print("==2")
            }
        }
        DispatchQueue.global().async(group: group) {
            self.callRecommendation(id: 672) { data in
                self.recList[2] = data
                print("==3")
            }
        
        }
        DispatchQueue.global().async(group: group) {
            self.callRecommendation(id: 673) { data in
                self.recList[3] = data
                print("==4")
            }
        }
        
        
        group.notify(queue: .main) {
            print("END")
            self.posterCollectionView.reloadData()
        }
    }
    
    //976573 569094 567646 671
    func callRecommendation(id: Int, completionHandler: @escaping (Recommendation) -> Void ) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=59023ea9c13f6c04dd3c6170da84bb3d&language=ko-KR"
        
        //alamofire default method -> get
        AF.request(url).validate(statusCode: 200...500)
            .responseDecodable(of: Recommendation.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
        
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showAlert(title: "테스트 얼럿", message: "메세지 입니다", button: "배경색 변경") {
            print("저장 버튼을 클릭했습니다.")
            self.posterCollectionView.backgroundColor = .lightGray
        }
        //print("AAA")
        
    }
    
    
    


}

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //섹션 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recList.count
    }
    
    //각 섹션의 셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recList[section].results.count
    }
    
    //셀 데이터
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {
            return UICollectionViewCell()
        }
        let url = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2\(recList[indexPath.section].results[indexPath.item].posterPath ?? "")"
        
        cell.posterImageView.kf.setImage(with: URL(string: url))

        cell.posterImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier, for: indexPath) as? HeaderPosterCollectionReusableView else {
                return UICollectionReusableView()
            }
            
            view.titleLabel.text = "테스트 섹션"
            view.titleLabel.font = UIFont(name: "omyu_pretty", size: 15)
            return view
            
        } else {
            return UICollectionReusableView()
        }
    }
    
    
}

extension PosterViewController: CollectionViewAttributeProtocol {
    
    
    func configureCollectionView() {
        //Protocol as Type
        posterCollectionView.delegate = self
        posterCollectionView.dataSource = self
        
        posterCollectionView.register(
            UINib(nibName: PosterCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: PosterCollectionViewCell.identifier) //셀 등록
        posterCollectionView.register(
            UINib(nibName: HeaderPosterCollectionReusableView.identifier, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderPosterCollectionReusableView.identifier) //헤더 뷰 등록하기
        
    }
    
    func configureCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        posterCollectionView.collectionViewLayout = layout
    }
    
    
}
