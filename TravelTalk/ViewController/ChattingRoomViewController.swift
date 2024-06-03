//
//  ChattingRoomViewController.swift
//  TravelTalk
//
//  Created by 최대성 on 6/3/24.
//

import UIKit

class ChattingRoomViewController: UIViewController {

    var list = mockChatList
    var basket: [Chat] = []
    var placeholder = "입력하세요!"
    
    
    @IBOutlet var chattingRoomTableView: UITableView!
    
   // @IBOutlet var searchTextField: UITextField!
    
    @IBOutlet var searchTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        chattingRoomTableView.delegate = self
        chattingRoomTableView.dataSource = self
        searchTextView.delegate = self
        
        setNavigationBar()
        setSearchTextView()
        setCell()
        keyboardAppear()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    

    @IBAction func keboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    
    func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func setSearchTextView() {
        searchTextView.backgroundColor = .systemGray6
        searchTextView.layer.cornerRadius = 5
        searchTextView.textContainer.maximumNumberOfLines = 3
        searchTextView.text = placeholder
        searchTextView.textColor = .lightGray
    }
    
    func setCell() {
        let xib = UINib(nibName: MyTableViewCell.identifier, bundle: nil)
        chattingRoomTableView.register(xib, forCellReuseIdentifier: MyTableViewCell.identifier)
        let xib2 = UINib(nibName: TheOhterTableViewCell.identifier, bundle: nil)
        chattingRoomTableView.register(xib2, forCellReuseIdentifier: TheOhterTableViewCell.identifier)
        chattingRoomTableView.rowHeight = UITableView.automaticDimension
        
        
        chattingRoomTableView.separatorStyle = .none

    }
    
    func keyboardAppear() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
}


extension ChattingRoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let data = list[indexPath.row]
        
        let data = basket[indexPath.row]
        
        if data.user != .user {
            guard let otherCell = tableView.dequeueReusableCell(withIdentifier: TheOhterTableViewCell.identifier, for: indexPath) as? TheOhterTableViewCell else {return TheOhterTableViewCell()}
            
            
            otherCell.configureCell(data: data)
            
            
            return otherCell
        } else {
            guard let myCell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as? MyTableViewCell else {return MyTableViewCell()}
            
            myCell.configureCell(data: data)
           
            return myCell
        }
    }
}



extension ChattingRoomViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
      
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
       
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = .lightGray
        } else {
            
            UserDefaults.standard.string(forKey: "user")
            
            textView.text = nil
        }
        
        
        
        
    }
    
    
}
