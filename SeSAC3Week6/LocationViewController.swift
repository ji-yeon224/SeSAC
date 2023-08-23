//
//  LocationViewController.swift
//  SeSAC3Week6
//
//  Created by 김지연 on 2023/08/22.
//

import UIKit
import CoreLocation // 1. 위치 import
import MapKit
import SnapKit

class LocationViewController: UIViewController {
    
    // 2. 위치 매니저 생성: 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    let mapView = MKMapView()
    let cafeButton = UIButton()
    let foodButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(50)
        }
        
        view.addSubview(cafeButton)
        cafeButton.backgroundColor = .yellow
        cafeButton.addTarget(self, action: #selector(cafeButtonClicked), for: .touchUpInside)
        cafeButton.snp.makeConstraints { make in
            make.top.equalTo(view).inset(20)
            make.size.equalTo(50)
            make.leading.equalTo(view).offset(100)
            
            
        }
        view.addSubview(foodButton)
        foodButton.backgroundColor = .blue
        foodButton.snp.makeConstraints { make in
            make.top.equalTo(view).inset(20)
            make.size.equalTo(50)
            make.trailing.equalTo(view).offset(-100)
            
        }
       
        
        mapView.delegate = self
        // 3. 위치 프로토콜 연결
        locationManager.delegate = self
        
//        //info.plist <<< 얼럿 문구 띄우기
//        locationManager.requestWhenInUseAuthorization()
        
        checkDeviceLocationAuthorization()
        
        let center = CLLocationCoordinate2D(latitude: 37.51800, longitude: 126.88641)
        setRegionAndAnnotation(center: center)
        
        setAnnotation(type: 0)
        
    }
    
    @objc func cafeButtonClicked() {
        
        setAnnotation(type: 1) // 1
        print(#function)
        
    }
    
    func setAnnotation(type: Int) {
//        37.517746, 126.887131 // 오밥
//        37.517857, 126.886714 // 컴포즈
        
        
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 37.517857, longitude: 126.886714)
        
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 37.517746, longitude: 126.887131)
        
        if type == 0 { // viewDidLoad -> 둘 다 표시
            mapView.addAnnotations([annotation1, annotation2])
        } else if type == 1 {
            mapView.removeAnnotations(mapView.annotations) // 등록되어 있는 어노테이션 지워주기
            mapView.addAnnotation(annotation2)
        }
        
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        //지도 중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(region, animated: true) // 맵 뷰에 위치 표시하기
        
        //지도에 어노테이션 추가
        let annotation = MKPointAnnotation()
        annotation.title = "영캠이에요"
        annotation.coordinate = center
        
        mapView.addAnnotation(annotation)
        
        
    }
    
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            
            //print(UIApplication.openSettingsURLString) // 애플 제공
            // 설정에서 직접적으로 앱 설정 화면에 들어간 적이 없다면
            // 한번도 설정 앱에 들어가지 않았거나, 막 다운받은 앱이라서
            // 설정 페이지로 넘어갈지, 설정 상세 페이지 결정할 수 없다.
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
                
            }
                
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    
    //디바이스의 권한을 체크함
    func checkDeviceLocationAuthorization() {
        
        //iOS 위치 서비스 활성화 체크
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                
                //현재 사용자의 위치 상태를 가지고 옴
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                print(authorization)
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
               
                
            } else {
                print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
            }
        }
        
       
    }
    
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        print("check", status)
        
        
        
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
            showLocationSettingAlert() // 설정 페이지로 유도
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManager.startUpdatingLocation() //사용자가 사용할 때만 위치를 알려줌
        case .authorized:
            print("authorized")
        @unknown default: print("default") //위치 권한 동류가 더 생길 가능성 대비
        }
        
    }


}

// 4. 프로토콜 선언
extension LocationViewController: CLLocationManagerDelegate{
    
    // 5. 사용자의 위치를 성공적으로 가지고 온 경우
    // 사용자의 위치가 계속 변경되기 때문에 한 번만 실행 되는 것이 아님
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            setRegionAndAnnotation(center: coordinate) //위치가 바뀔 때 핀 찍기
        }
        locationManager.stopUpdatingLocation()
    }
    
    // 사용자의 위치를 가지고 오지 못한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    //사용자의 권한 상태가 바뀔 때를 알려줌
    //거부했다가 설정에서 변경을 했거나, 혹은 notDetermined 상태에서 허용을 했거나
    //허용해서 위치를 가지고 오는 도중에, 설정에서 거부를 하고 앱으로 다시 돌아올 때 등
    //iOS14 이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
    
    //사용자의 권한 상태가 바뀔 때를 알려줌
    //iOS14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
}

extension LocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(#function)
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print(#function)
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        print(#function)
//    }
    
    
}
