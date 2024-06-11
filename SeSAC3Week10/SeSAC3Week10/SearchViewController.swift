//
//  SearchViewController.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/21.
//

import UIKit
import SnapKit


class SearchViewController: UIViewController, UICollectionViewDelegate, UISearchBarDelegate {
    
    let list = ["이모티콘", "새싹", "추석", "햄버거", "컬렉션뷰레이아웃", "고래밥"]
    
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureTagLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<Int, PhotoResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierachy()
        configureLayout()
        configureDataSource()
        
        let bar = UISearchBar()
        bar.delegate = self
        navigationItem.titleView = bar
        
        
    }
    
    private func configureHierachy() {
        
        view.addSubview(collectionView)
        
    }
    
    private func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        Network.shared.requestConvertible(type: Photo.self, api: .search(query: searchBar.text!)) { response in
            
            switch response {
            case .success(let success):
                // 데이터 + UI 스냅샷
                let ratios = success.results.map { Ratio(ratio: $0.width / $0.height) } // 이미지 비율 구하기
                let layout = PinterestLayout(columnsCount: 2, itemRatios: ratios, spacing: 10, contentWidth: self.view.frame.width)
                self.collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: layout.section)
                self.configureSnapshot(success)
                dump(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<SearchCollectionViewCell, PhotoResult> { cell, indexPath, itemIdentifier in
            cell.imageView.kf.setImage(with: URL(string: itemIdentifier.urls.thumb)!)
            cell.label.text = "\(itemIdentifier.created_at)"
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
       
    }
    
    func configureSnapshot(_ item: Photo){
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResult>()
        snapshot.appendSections([0])
        snapshot.appendItems(item.results)
        dataSource.apply(snapshot)
        
    }
    
   
    
    func configurePinterestLayout() -> UICollectionViewLayout{

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .estimated(150))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))

        //let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        group.interItemSpacing = .fixed(10) // 아이템 옆 간격
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10 // 줄 간격
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration

        return layout

    }
    
    
    func configureTagLayout() -> UICollectionViewLayout{

        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .absolute(30))

        //let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.interItemSpacing = .fixed(10) // 아이템 옆 간격
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10 // 줄 간격
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration

        return layout

    }

//    func configureCollectionLayout() -> UICollectionViewLayout{
//
//
//
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(1.0))
//
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
//
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 4)
//        group.interItemSpacing = .fixed(30) // 아이템 옆 간격
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30)
//        section.interGroupSpacing = 30 // 줄 간격
//
//        let configuration = UICollectionViewCompositionalLayoutConfiguration()
//        configuration.scrollDirection = .horizontal
//
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        layout.configuration = configuration
//
//        return layout
//
//    }
    
//    func configureCollectionLayout() -> UICollectionViewLayout{
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 50, height: 50)
//        layout.scrollDirection = .vertical
//
//        return layout
//
//    }
    
}


//class SearchViewController: UIViewController {
//
//    let scrollView = UIScrollView()
//    let contentView = UIView()
//
//    let imageView = UIImageView()
//    let label = UILabel()
//    let button = UIButton()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        configureHierachy()
//        configureLayout()
//        configureContentView()
//    }
//
//    private func configureContentView() {
//        contentView.addSubview(imageView)
//        contentView.addSubview(button)
//        contentView.addSubview(label)
//
//        imageView.backgroundColor = .orange
//        button.backgroundColor = .systemBlue
//        label.backgroundColor = .systemGreen
//        label.numberOfLines = 0
//        label.text = "asdfasdfa\nsdfasfsdfasdfa\n\nsdfasdfasdfasfsdfasdf\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfss\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasfs\nsdfasdfasdfasf"
//        label.textColor = .white
//
//        imageView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(200)
//        }
//
//        button.snp.makeConstraints { make in
//            make.bottom.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(80)
//        }
//
//        label.snp.makeConstraints { make in
//            make.horizontalEdges.equalTo(contentView)
//            make.top.equalTo(imageView.snp.bottom).offset(50)
//            make.bottom.equalTo(button.snp.top).offset(-50)
//        }
//
//    }
//
//    private func configureHierachy() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//
//
//    }
//
//    private func configureLayout() {
//        scrollView.backgroundColor = .lightGray
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//
//        contentView.backgroundColor = .white
//        contentView.snp.makeConstraints { make in
//            make.verticalEdges.equalTo(scrollView)
//            make.width.equalTo(scrollView.snp.width)
//
//        }
//
//
//
//
//    }
//
//}
//





//class SearchViewController: UIViewController {
//
//    let scrollView = UIScrollView()
//    let stackView = UIStackView()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        configureHierachy()
//        configureLayout()
//        configureStackView()
//
//    }
//
//    private func configureHierachy() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(stackView)
//    }
//
//
//    private func configureLayout() {
//        scrollView.backgroundColor = .lightGray
//        scrollView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(70)
//        }
//
//        stackView.spacing = 16
//        stackView.backgroundColor = .black
//        stackView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView)
//            make.height.equalTo(scrollView)
//        }
//    }
//
//    private func configureStackView() {
//
//        let label1 = UILabel()
//        label1.text = "안녕하세요"
//        label1.backgroundColor = .orange
//        label1.textColor = .white
//        stackView.addArrangedSubview(label1)
//
//        let label2 = UILabel()
//        label2.text = "아아안녕하세요"
//        label2.backgroundColor = .brown
//        label2.textColor = .white
//        stackView.addArrangedSubview(label2)
//
//        let label3 = UILabel()
//        label3.text = "444안녕하세요"
//        label3.backgroundColor = .yellow
//        label3.textColor = .white
//        stackView.addArrangedSubview(label3)
//
//        let label4 = UILabel()
//        label4.text = "999안녕하세요"
//        label4.backgroundColor = .magenta
//        label4.textColor = .white
//        stackView.addArrangedSubview(label4)
//
//        let label5 = UILabel()
//        label5.text = "하하하하안녕하세요"
//        label5.textColor = .white
//        stackView.addArrangedSubview(label5)
//
//    }
//}
