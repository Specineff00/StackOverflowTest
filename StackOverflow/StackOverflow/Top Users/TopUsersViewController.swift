//
//  TopUsersViewController.swift
//  StackOverflow
//
//  Created by Yogesh N Ramsorrrun on 28/07/2019.
//  Copyright © 2019 Yogesh N Ramsorrrun. All rights reserved.
//

import UIKit

class TopUsersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let presenter: TopUsersPresenterContract
    var users: [User]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(presenter: TopUsersPresenterContract) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Top 20 Users"
        setupTableView()
        presenter.retrieveTopUsers()
    }
    
    fileprivate func setupTableView() {
        let nib = UINib(nibName: "\(TopUserTableViewCell.self)", bundle: Bundle(for: type(of: self)))
        tableView.register(nib, forCellReuseIdentifier: TopUserTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TopUsersViewController: TopUsersViewContract {
    func showUsers(_ users: [User]) {
        self.users = users
    }
    
    func showLoadingFail() {
        let alert = UIAlertController(title: "Loading Error", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}


extension TopUsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = users else { return 0 }
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let users = users else { return 0 }
        if users[indexPath.row].isBlocked {
            return 180
        }
        return users[indexPath.row].isExpanded ? 255 : 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let users = users else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopUserTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? TopUserTableViewCell else {
                                                        fatalError("TopUserTableViewCell failed to load")
        }
        
        cell.configureCell(user: users[indexPath.row], delegate: self, indexRow: indexPath.row)
        return cell
    }
}

extension TopUsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onCellTap(indexPath.row)
    }
}

extension TopUsersViewController: TopUserTableViewCellDelegate {
    func didTapFollow(indexRow: Int) {
        presenter.onFollowTap(indexRow)
    }
    
    func didTapBlock(indexRow: Int) {
        presenter.onBlockTap(indexRow)
    }
}

