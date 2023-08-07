//
//  ViewController.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/07.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
    }

    
    func callRequest() {
        
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=20120101"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                let name = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
                print(name, "----")
            case .failure(let error):
                print(error)
            }
        }
        
    }

}

