//
//  MyTableViewCell.swift
//  TravelTalk
//
//  Created by 최대성 on 6/3/24.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    
    @IBOutlet var myTurnLable: UILabel!
    
    @IBOutlet var myTimeLabel: UILabel!
    
    @IBOutlet var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureLayout()
    }

  
    func configureLayout() {
        
        myTurnLable.font = .systemFont(ofSize: 12)
        myTurnLable.numberOfLines = 0
        
        myTimeLabel.font = .systemFont(ofSize: 10)
        myTimeLabel.textColor = .gray
        
        backView.backgroundColor = .lightGray
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 10
        backView.layer.borderWidth = 1
        
    }
    
    
    func configureCell(data: Chat) {
        myTurnLable.text = data.message
        myTurnLable.numberOfLines = 0
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = dateFormatter.date(from: data.date) else { return }
       
        let newaDateFormatter = DateFormatter()
        newaDateFormatter.dateFormat = "dd일 HH:mm"
        newaDateFormatter.locale = Locale(identifier: "ko_KR")
        let convetStrDate = newaDateFormatter.string(from: date)
        
        myTimeLabel.text = convetStrDate
    }
    
    
}
