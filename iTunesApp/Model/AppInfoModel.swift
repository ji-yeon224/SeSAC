//
//  AppInfoData.swift
//  iTunesApp
//
//  Created by 김지연 on 11/12/23.
//

import Foundation
import RxDataSources

struct AppInfoModel: SectionModelType {
    typealias Item = AppInfo
    
    var section: String
    var items: [Item]
}

extension AppInfoModel {
    init(original: AppInfoModel, items: [AppInfo]) {
        self = original
        self.items = items
    }
}
