//
//  DiaryTableViewController.swift
//  OneLineDiary
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit

class DiaryTableViewController: UITableViewController {
    
    var list = ["테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1", "테스트 2테스트 2테스트 2테스트 2테스트 2테스트 2테스트 2테스트 2테스트 2테스트 2테스트 2테스트 2테스트 2", "테스트 3테스트 3테스트 3테스트 3테스트 3테스트 3테스트 3테스트 3테스트 3테스트 3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        
        //XIB로 테이블 뷰셀을 생성할 경우, 테이블 뷰에 사용할 셀을 등록해주는 과정 필요
        let nib = UINib(nibName: "DiaryTableViewCell", bundle: nil) //nil로 설정하면 메인 번들로 설정됨
        tableView.register(nib, forCellReuseIdentifier: "DiaryTableViewCell")

        //Dynamic Height: 1. automaticDimension 2. label numberOfLines 3. AutoLayout(여백)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    @IBAction func searchBarButtonItemClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchCollectionViewController") as! SearchCollectionViewController
        
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    @IBAction func addBarButtonClicked(_ sender: UIBarButtonItem) {
        
        //1. 스토리보드 파일 찾기
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        //2. 스토리 보드 파일 내 뷰컨트롤러 찾기
        let vc = sb.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        
        //2-1(옵션). 네비게이션 컨트롤러가 있는 형태(제목바)로 Present 하고 싶은 경우
        //네비게이션 컨트롤러에 뷰 컨트롤러를 담아서 present 시키기
        //nav를 사용한다면, present와 화면 전환 방식도 nav로 수정해야 한다.
        let nav = UINavigationController(rootViewController: vc) //네비게이션 컨트롤러에 루트 뷰를 연결해서 사용
        
        //3. 화면 전환 방식 설정하기(옵션)
       // vc.modalTransitionStyle = .crossDissolve //모달 애니메이션
        nav.modalPresentationStyle = .fullScreen   //모달 방식(풀 스크린)
        
        //4. 화면 띄우기
        present(nav, animated: true)
        
        
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryTableViewCell") as? DiaryTableViewCell else {
            return UITableViewCell()
        } //nil값 발생하면 빈 테이블 뷰 셀 리턴하도록
        
        cell.contentLabel.text = list[indexPath.row]
        cell.contentLabel.numberOfLines = 0
        cell.backgroundColor = .clear
        
        return cell
    }

    //1. canEditRowAt
    //편집 가능한 상태로 쓰겠다. 편집상태 -> true
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //2. commit editingStyle
    // 삭제, 편집, alert창
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        list.remove(at: indexPath.row)
        tableView.reloadData()
        
    }
    
    //상세정보 페이지
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        // let vc = DetailViewController()
        
        //Pass Data 2. vc가 가지고 있는 프로퍼티에 데이터 추가
        //vc.contents = "Diary 뷰컨트롤러에서 데이터 전달하면서 화면 전환하기!"
        vc.contents = list[indexPath.row]
        
        
        //인터페이스 빌더에 네비게이션 컨트롤러가 임베드 되어 있어야함 push가 동작한다.
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
//    
//    //leading swipe
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        UISwipeActionsConfiguration(actions: <#T##[UIContextualAction]#>)
//        //스와이프 했을 때 나오는 액션이 여러개가 될 수 있기 때문에 배열! 해당 액션들이 uicontextualAction 타입이다.
//    }
//    
//    //trailing swipe
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
//  

}
