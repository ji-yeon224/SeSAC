//
//  BeerViewController.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/19.
//

import UIKit
import SnapKit

class BeerViewController: UIViewController {
    
    
    private let mainView = BeerView()
    private let viewModel = BeerViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        mainView.segmentedControl.selectedSegmentIndex = 0
        viewModel.fetchBeerRequest(router: .beers)
        updateSnapshot()
        bindData()
        
        
    }
    
    private func bindData() {
        viewModel.beerList.bind { value in
            self.updateSnapshot()
        }
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        mainView.segmentedControl.addTarget(self, action: #selector(indexChanged(_: )), for: .valueChanged)
    }
    
    @objc private func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.fetchBeerRequest(router: .beers)
        case 1:
            viewModel.fetchBeerRequest(router: .random)
        default:
            viewModel.fetchBeerRequest(router: .beers)
        }
        
    }
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Beer>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.beerList.value)
        mainView.dataSource.apply(snapshot)
    }
    
   
   
    
}


