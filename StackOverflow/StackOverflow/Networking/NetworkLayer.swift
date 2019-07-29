//
//  NetworkContract.swift
//  StackOverflow
//
//  Created by Yogesh N Ramsorrrun on 28/07/2019.
//  Copyright © 2019 Yogesh N Ramsorrrun. All rights reserved.
//

import Foundation

protocol NetworkContract {
    func getTopUsers(onCompletion: @escaping (Result<(URLResponse, Data), Error>) -> ())
}


class NetworkLayer: NetworkContract {
    
    let url = "http://api.stackexchange.com/2.2/users?%20pagesize=20&order=desc&sort=reputation&site=stackoverflow"
    func getTopUsers(onCompletion: @escaping (Result<(URLResponse, Data), Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url, result: onCompletion).resume()
    }
}
