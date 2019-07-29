//
//  MockNetworkLayer.swift
//  StackOverflowTests
//
//  Created by Yogesh N Ramsorrrun on 28/07/2019.
//  Copyright © 2019 Yogesh N Ramsorrrun. All rights reserved.
//

import Foundation
@testable import StackOverflow

class MockNetworkLayer: NetworkContract  {
    
   
    func getTopUsers(onCompletion: @escaping (Result<(URLResponse, Data), Error>) -> ()) {
        
    }
    
    
}


