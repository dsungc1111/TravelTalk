//
//  TheOhterTableViewCell.swift
//  TravelTalk
//
//  Created by 최대성 on 6/3/24.
//

import UIKit

class TheOhterTableViewCell: UITableViewCell {

    @IBOutlet var otherImageView: UIImageView!
    
    @IBOutlet var otherNameLabel: UILabel!
    
    @IBOutlet var otherTextLabel: UILabel!
    
    
    @IBOutlet var otherTimeLabel: UILabel!
    
    @IBOutlet var backView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureLayout()
    }

   
    
    
    func configureLayout() {
        otherImageView.contentMode = .scaleAspectFill
        otherImageView.layer.cornerRadius = otherImageView.frame.width / 2
        
        otherNameLabel.font = .systemFont(ofSize: 13)
        otherTextLabel.font = .boldSystemFont(ofSize: 12)
        otherTextLabel.numberOfLines = 0
        
        otherTimeLabel.font = .systemFont(ofSize: 10)
        otherTimeLabel.textColor = .gray
        
        backView.clipsToBounds = true
        backView.layer.borderWidth = 0.5
        backView.layer.cornerRadius = 5
        
        
    }
    
    
    func configureCell(data: Chat) {
        let image = data.user.profileImage
     
        otherImageView.image = UIImage(named: image)
        
//      
        otherNameLabel.text = "\(data.user)"
        
        otherTextLabel.text = data.message
       
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = dateFormatter.date(from: data.date) else { return }
       
        let newaDateFormatter = DateFormatter()
        newaDateFormatter.dateFormat = "dd일 HH:mm"
        newaDateFormatter.locale = Locale(identifier: "ko_KR")
        let convetStrDate = newaDateFormatter.string(from: date)
        
        otherTimeLabel.text = convetStrDate
    }
    
    
    
}
