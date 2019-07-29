//
//  TopUsersContract.swift
//  StackOverflow
//
//  Created by Yogesh N Ramsorrrun on 28/07/2019.
//  Copyright © 2019 Yogesh N Ramsorrrun. All rights reserved.
//

import Foundation

protocol TopUsersViewContract: class {
    func showUsers(_ users: [User])
    func showLoadingFail()
}

protocol TopUsersPresenterContract: class {
    func retrieveTopUsers()
    func onFollowTap(_ indexRow: Int)
    func onBlockTap(_ indexRow: Int)
    func onCellTap(_ indexRow: Int)
}
