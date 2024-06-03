//
//  GruopTalkTableViewCell.swift
//  TravelTalk
//
//  Created by 최대성 on 6/2/24.
//

import UIKit

class GruopTalkTableViewCell: UITableViewCell {

    @IBOutlet var imageList: [UIImageView]!
    
    @IBOutlet var groupNameLabel: UILabel!
    
    @IBOutlet var groupSummaryLabel: UILabel!
    
    @IBOutlet var groupDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureLayout()
    }

    
    func configureLayout() {
        groupNameLabel.font = .boldSystemFont(ofSize: 13)
        groupNameLabel.textColor = .black
        
        groupSummaryLabel.font = .systemFont(ofSize: 12)
        groupSummaryLabel.textColor = .gray
        
        groupDateLabel.font = .systemFont(ofSize: 12)
        groupDateLabel.textColor = .gray
    }
    
    func configureCell(data: ChatRoom ) {
        groupNameLabel.text = data.chatroomName
        groupSummaryLabel.text = data.chatList[data.chatList.count-1].message
        let timeTable = data.chatList[data.chatList.count-1].date
        groupDateLabel.text = timeTable.toDate()?.formatted("MM-dd HH:mm")
        for i in 0...imageList.count-1 {
            let image = data.chatroomImage[i]
            imageList[i].image = UIImage(named: image)
        }
        
    }
    
    
    
    
}
