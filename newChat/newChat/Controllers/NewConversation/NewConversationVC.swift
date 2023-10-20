//
//  NewConversationVC.swift
//  newChat
//
//  Created by Марина on 19.10.2023.
//

import UIKit
import JGProgressHUD

class NewConversationVC: UIViewController {
    
    private let spinner = JGProgressHUD()
    
    private let searchBar: UISearchBar =  {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search user"
        return searchBar
    }()
    
    private let mainTable: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let noResultsLabel: UILabel = {
        let label = UILabel()
        label.text = "No results"
        label.textAlignment = .center
        label.textColor = .gray
        label.isHidden = true
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        view.backgroundColor = .white
        
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(cancelTapped))
        searchBar.becomeFirstResponder()
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
}

extension NewConversationVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
