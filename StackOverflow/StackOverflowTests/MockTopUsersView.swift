//
//  MockTopUsersView.swift
//  StackOverflowTests
//
//  Created by Yogesh N Ramsorrrun on 28/07/2019.
//  Copyright © 2019 Yogesh N Ramsorrrun. All rights reserved.
//

import Foundation
@testable import StackOverflow

class MockTopUsersView: TopUsersViewContract {
    
    var showUsersCalls = 0
    var showUsersParams = [[User]]()
    func showUsers(_ users: [User]) {
        showUsersCalls += 1
        showUsersParams.append(users)
    }
    
    
    var showLoadingFailCalls = 0
    func showLoadingFail() {
        showLoadingFailCalls += 1
    }
}
