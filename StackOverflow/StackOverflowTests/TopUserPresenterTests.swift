//
//  TopUserPresenterTests.swift
//  StackOverflowTests
//
//  Created by Yogesh N Ramsorrrun on 28/07/2019.
//  Copyright © 2019 Yogesh N Ramsorrrun. All rights reserved.
//

import XCTest
@testable import StackOverflow

class TopUserPresenterTests: XCTestCase {

    let presenter = TopUsersPresenter(networkLayer: MockNetworkLayer())
    let view = MockTopUsersView()
    
    override func setUp() {
        presenter.view = view
        
        var dummyUsers = [User]()
        for index in 1...30 {
            let newDummyUser = User(userName: "name \(index)", profileImage: "profileImage", reputation: (index * 5))
            dummyUsers.append(newDummyUser)
        }
        presenter.users = dummyUsers
        
    }

    func test_onFollowTap_shouldUpdateDataSource() {
        presenter.onFollowTap(5)
        XCTAssertEqual(1, view.showUsersCalls)
        XCTAssertEqual(20, view.showUsersParams[0].count)
        XCTAssertEqual(true, view.showUsersParams[0][5].isFollowed)
    }

    func test_onBlockTap_shouldUpdateDataSource() {
        presenter.onBlockTap(5)
        XCTAssertEqual(1, view.showUsersCalls)
        XCTAssertEqual(20, view.showUsersParams[0].count)
        XCTAssertEqual(true, view.showUsersParams[0][5].isBlocked)
    }
    
    func test_onCellTap_shouldUpdateDataSource() {
        presenter.onCellTap(5)
        XCTAssertEqual(1, view.showUsersCalls)
        XCTAssertEqual(20, view.showUsersParams[0].count)
        XCTAssertEqual(true, view.showUsersParams[0][5].isExpanded)
    }

}
