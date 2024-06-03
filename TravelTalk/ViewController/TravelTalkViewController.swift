//
//  ViewController.swift
//  TravelTalk
//
//  Created by 최대성 on 6/2/24.
//

import UIKit
import Kingfisher


class TravelTalkViewController: UIViewController {

    var friend = mockChatList
    var basketLsit = mockChatList
    
    @IBOutlet var roomSearchBar: UISearchBar!
    
    @IBOutlet var talkTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        talkTableView.delegate = self
        talkTableView.dataSource = self
        roomSearchBar.delegate = self
        
        let xib = UINib(nibName: TravelTalkTableViewCell.identifier, bundle: nil)
        talkTableView.register(xib, forCellReuseIdentifier: TravelTalkTableViewCell.identifier)
        
        let xib2 = UINib(nibName: GruopTalkTableViewCell.identifier, bundle: nil)
        talkTableView.register(xib2, forCellReuseIdentifier: GruopTalkTableViewCell.identifier)
    }

   
    
}

extension TravelTalkViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friend.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let data = friend[indexPath.row]
        
        if data.chatroomImage.count == 1 {
            guard let cell1 = talkTableView.dequeueReusableCell(withIdentifier: TravelTalkTableViewCell.identifier, for: indexPath) as? TravelTalkTableViewCell else { return TravelTalkTableViewCell() }
            
            cell1.configureCell(data: data)
            
            return cell1
        } else {
            guard let cell2 = talkTableView.dequeueReusableCell(withIdentifier: GruopTalkTableViewCell.identifier, for: indexPath) as? GruopTalkTableViewCell else { return GruopTalkTableViewCell() }
           
            cell2.configureCell(data: data)
            
            return cell2
        }
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: ChattingRoomViewController.identifier) as? ChattingRoomViewController else { return }
       
        
        vc.navigationItem.title = vc.list[indexPath.row].chatroomName
        
        vc.basket = vc.list[indexPath.row].chatList
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
  
    
   
    
    
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
