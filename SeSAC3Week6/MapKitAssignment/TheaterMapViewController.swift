//
//  TheaterMapViewController.swift
//  SeSAC3Week6
//
//  Created by 김지연 on 2023/08/23.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation


class TheaterMapViewController: UIViewController {
    
    let locationManager = CLLocationManager()

    
    let mapView = MKMapView()
    let totalButton = setButton(title: "전체보기")
    let lotteButton = setButton(title: "롯데시네마")
    let megaBoxButton = setButton(title: "메가박스")
    let cgvButton = setButton(title: "CGV")
    let locationButton = {
        let btn = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.buttonSize = .small
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.titleAlignment = .center
        //config.image = UIImage(systemName: "location.circle")
        btn.configuration = config
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 25
        btn.layer.borderWidth = 1
        btn.setImage(UIImage(systemName: "location.circle"), for: .normal)
        
        
        return btn
    }()
    
    var annoList: [MKPointAnnotation] = []
    var lotteList: [MKPointAnnotation] = []
    var megaList: [MKPointAnnotation] = []
    var cgvList: [MKPointAnnotation] = []
    
    lazy var stackView = {
        let stackview = UIStackView(arrangedSubviews: [totalButton, lotteButton, megaBoxButton, cgvButton])
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.alignment = .fill
        
        stackview.spacing = 10
        return stackview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        mapView.delegate = self
        checkDeviceLocationAuthorization()
        
        setConstraints()
        setAttribute()
        setAnnotationList()
        setAnnotation(type: "all")
        
        
    }
    
  
    
    func setAnnotationList() {
        for item in TheaterList().mapAnnotations {
            
            let anot = MKPointAnnotation()
            anot.coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
            anot.title = item.location
            annoList.append(anot)
            if item.type == "롯데시네마" {
                lotteList.append(anot)
            } else if item.type == "메가박스" {
                megaList.append(anot)
            } else if item.type == "CGV" {
                cgvList.append(anot)
            }
        }
    }
    
    
    
    func setAnnotation(type: String) {
        
        mapView.removeAnnotations(mapView.annotations)
        if type == "all" {
            mapView.addAnnotations(annoList)
        } else if type == "lotte" {
            mapView.addAnnotations(lotteList)
        } else if type == "mega" {
            mapView.addAnnotations(megaList)
        } else if type == "cgv"{
            mapView.addAnnotations(cgvList)
        }
        
        
        
    }
    
    func checkDeviceLocationAuthorization() {
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
                
            } else {
                print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
            }
        }
        
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            showRequestLocationServiceAlert()
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        @unknown default: print("default")
        }
        
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D){
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 20000, longitudinalMeters: 20000)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        
        mapView.addAnnotation(annotation)
        
        
    }
    
    
    
    
    
    
    /*
     Location Authorization Custom Alert
     */

    func showRequestLocationServiceAlert() {
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
        
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      
      present(requestLocationServiceAlert, animated: true, completion: nil)
    }

}

extension TheaterMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //37.523844, 126.980249
//        let center = CLLocationCoordinate2D(latitude: 37.523844, longitude: 126.980249)
//        setRegionAndAnnotation(center: center)
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let center = CLLocationCoordinate2D(latitude: 37.51800, longitude: 126.88641)
        setRegionAndAnnotation(center: center)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        checkDeviceLocationAuthorization()
    }
    
    
    
}

extension TheaterMapViewController {
    

    func setAttribute() {
        
        totalButton.addTarget(self, action: #selector(clickedTotalButton), for: .touchUpInside)
        lotteButton.addTarget(self, action: #selector(clickedLotteButton), for: .touchUpInside)
        megaBoxButton.addTarget(self, action: #selector(clickedMegaButton), for: .touchUpInside)
        cgvButton.addTarget(self, action: #selector(clickedCGVButton), for: .touchUpInside)
        locationButton.addTarget(self, action: #selector(clickedLocationButton), for: .touchUpInside)
    }
    
    @objc func clickedLocationButton() {
        checkDeviceLocationAuthorization()
        //locationManager.startUpdatingLocation()
    }
    @objc func clickedTotalButton() {
        setAnnotation(type: "all")
    }
    @objc func clickedLotteButton() {
        setAnnotation(type: "lotte")
    }
    @objc func clickedMegaButton() {
        setAnnotation(type: "mega")
    }
    @objc func clickedCGVButton() {
        setAnnotation(type: "cgv")
    }
    
    
    static func setButton(title: String) -> UIButton {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.title = title
        config.buttonSize = .small
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .darkGray
        config.titleAlignment = .center
        
        button.configuration = config
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        return button
    }
    
    func setConstraints() {
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottomMargin.equalToSuperview().inset(10)
            make.height.equalTo(view).multipliedBy(0.7)
        }
        
        view.addSubview(locationButton)
        locationButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.trailingMargin.equalToSuperview().inset(20)
            make.bottomMargin.equalTo(mapView.snp.top).offset(-10)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.topMargin.equalToSuperview().inset(20)
            make.height.equalTo(70)
        }
        
        totalButton.snp.makeConstraints { make in
            make.verticalEdges.equalTo(stackView)
        
        }
        
        lotteButton.snp.makeConstraints { make in
            make.verticalEdges.equalTo(stackView)
        }
        
        
        megaBoxButton.snp.makeConstraints { make in
            make.verticalEdges.equalTo(stackView)
        }
        
        
        cgvButton.snp.makeConstraints { make in
            make.verticalEdges.equalTo(stackView)
        }
        
    }
    
    
    
}

extension TheaterMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(#function)
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print(#function)
    }
}

