//
//  TopUsersPresenter.swift
//  StackOverflow
//
//  Created by Yogesh N Ramsorrrun on 28/07/2019.
//  Copyright © 2019 Yogesh N Ramsorrrun. All rights reserved.
//

import Foundation

class TopUsersPresenter: TopUsersPresenterContract {
    
    weak var view: TopUsersViewContract?
    private let networkLayer: NetworkContract
    var users: [User]?
    
    init(networkLayer: NetworkContract ) {
        self.networkLayer = networkLayer
    }
    
    func retrieveTopUsers() {
        
        networkLayer.getTopUsers { [weak self] result in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(_, let data):
                    do {
                        let topUsers = try JSONDecoder().decode(TopUsers.self, from: data)
                        strongSelf.users = topUsers.items
                    } catch {
                        strongSelf.view?.showLoadingFail()
                    }
                    guard let users = strongSelf.users else  {
                        strongSelf.view?.showLoadingFail()
                        return
                    }
                    strongSelf.view?.showUsers(strongSelf.takeTopUsers(users))
                case .failure(_):
                    strongSelf.view?.showLoadingFail()
                }
            }
        }
    }
    
    func onFollowTap(_ indexRow: Int) {
        guard let users = users else { return }
        users[indexRow].isFollowed.toggle()
        view?.showUsers(takeTopUsers(users))
    }
    
    func onBlockTap(_ indexRow: Int) {
        guard let users = users else { return }
        users[indexRow].isBlocked.toggle()
        view?.showUsers(takeTopUsers(users))
    }
    
    func onCellTap(_ indexRow: Int) {
        guard let users = users else { return }
        users[indexRow].isExpanded.toggle()
        view?.showUsers(takeTopUsers(users))
    }
    
    func takeTopUsers(_ users: [User]) -> [User] {
        if users.count <= 20 { return users }
        var topTwenty = [User]()
        for index in 0..<20 {
            topTwenty.append(users[index])
        }
        return topTwenty
    }
}
