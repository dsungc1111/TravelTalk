//
//  TravelTalkTableViewCell.swift
//  TravelTalk
//
//  Created by 최대성 on 6/2/24.
//

import UIKit

class TravelTalkTableViewCell: UITableViewCell {
    
    
    @IBOutlet var profileImageView: UIImageView!
    
    
    @IBOutlet var nameLabel: UILabel!
    
    
    @IBOutlet var summaryLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureLayout()
    }

    
    func configureLayout() {
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        
        nameLabel.font = .boldSystemFont(ofSize: 13)
        nameLabel.textColor = .black
        
        summaryLabel.font = .systemFont(ofSize: 12)
        summaryLabel.textColor = .gray
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .gray
    }
    
    
    
    
    func configureCell(data: ChatRoom ) {
        nameLabel.text = data.chatroomName
        summaryLabel.text = data.chatList[data.chatList.count-1].message
        let timeTable = data.chatList[data.chatList.count-1].date
        dateLabel.text = timeTable.toDate()?.formatted("MM-dd HH:mm")
        
        let image = data.chatroomImage[0]
        profileImageView.image = UIImage(named: image)
    }
    
}
