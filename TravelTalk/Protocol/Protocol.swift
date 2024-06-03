//
//  Protocol.swift
//  TravelTalk
//
//  Created by 최대성 on 6/2/24.
//

import UIKit

protocol UseIdentifier {
    static var identifier: String { get }
}


extension UITableViewCell: UseIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: UseIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}
