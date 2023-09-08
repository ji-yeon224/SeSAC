//
//  DetailTableViewController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/09/04.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func didSelectRowAt(indexPath: IndexPath)
}

class DetailTableViewController: BaseViewController {
    
    let mainView = DetailView()
    override func loadView() {
        mainView.delegate = self
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callCreditData()
        
        
    }
    
    
    override func configureView() {
        title = "Detail Info"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .darkGray
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
}

extension DetailTableViewController {
    func callCreditData() {
        guard let trendData = mainView.trendData else {
            dismiss(animated: true)
            return
        }
        let parameter = "\(trendData.mediaType.rawValue)/\(trendData.id)/credits"
        TMDBApi.shared.callCreditRequest(endPoint: .credit, parameter: parameter) { credit in
            self.mainView.creditData = credit
            
            print(self.mainView.creditData)
            self.mainView.tableView.reloadData()
        }
        
        
    }
}

extension DetailTableViewController: DetailViewProtocol {
    func didSelectRowAt(indexPath: IndexPath) {
        print(indexPath)
        if indexPath.section == 1 {
            mainView.trendData!.isExpand.toggle()
            print(mainView.trendData?.isExpand)
            mainView.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
