//
//  ViewController.swift
//  TravelTalk
//
//  Created by 최대성 on 6/2/24.
//

import UIKit
import SnapKit
import Kingfisher


class TravelTalkViewController: UIViewController {

    enum Section: CaseIterable {
        case main
    }
    
    
    var friend = mockChatList
    var basketLsit = mockChatList
    
    @IBOutlet var roomSearchBar: UISearchBar!
    
    @IBOutlet var talkTableView: UITableView!
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
   
    var dataSource: UICollectionViewDiffableDataSource<Section, ChatRoom>!
    
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = true
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    private func configureDataSource() {
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, ChatRoom>!
        
        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            // collectionviewCell's system cell
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.chatroomName
            //            content.textProperties.font = .boldSystemFont(ofSize: 20)
            content.secondaryText = itemIdentifier.chatList.first?.date
            if indexPath.row != 0 {
                let imageView = UIImageView(image: UIImage(named: itemIdentifier.chatroomImage.first ?? "star"))
                imageView.contentMode = .scaleAspectFill
                content.image = imageView.image
            }
            content.imageProperties.reservedLayoutSize = CGSize(width: 30, height: 30)
            content.imageProperties.cornerRadius = 10
            
            content.secondaryTextProperties.font = .systemFont(ofSize: 12)
            
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 4
            
            cell.backgroundConfiguration = backgroundConfig
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier )
            
            return cell
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        roomSearchBar.delegate = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        configureDataSource()
        updateSnapShot()
    }
    func updateSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, ChatRoom>()
        // section identifier has to be unique
        snapShot.appendSections(Section.allCases)
        snapShot.appendItems(friend, toSection: .main)
//        snapShot.appendItems([Fruit(name: "테스트", count: 5, price: 5)], toSection: .sub)
        dataSource.apply(snapShot) // reloadData
    }

   
}

extension TravelTalkViewController:  UICollectionViewDelegateFlowLayout {
   
   
}






extension String {
  // MARK: - String -> Date
    func toDate(_ dateFormat: String = "yyyy-MM-dd HH:mm") -> Date? {

    let dateFormatter = DateFormatter()
       
    dateFormatter.locale = Locale(identifier: "ko_KR")
//    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    dateFormatter.dateFormat = dateFormat
        
    if let date = dateFormatter.date(from: self) {
      return date
    }
    return nil
  }
}

extension Date {

    func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)!

        return formatter.string(from: self)
    }
}




extension TravelTalkViewController: UISearchBarDelegate {
   
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
          // 취소 버튼을 누를 때 검색어를 초기화하고 테이블 뷰를 갱신합니다.
        searchBar.text = nil
        searchBar.resignFirstResponder() // 키보드 내림
        friend = mockChatList
        talkTableView.reloadData()
      }
      
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var count = 0
        friend = mockChatList
        basketLsit.removeAll()
               
        for item in friend {
            if item.chatroomName == roomSearchBar.text! {
                basketLsit.append(item)
               
                count += 1
            }
        }
        if count == 0 {basketLsit = mockChatList}
        friend = basketLsit
        talkTableView.reloadData()
        
    }
    
    
   
    
//    func dismissKeyboard() {
//        roomSearchBar.resignFirstResponder()
//    }
}
