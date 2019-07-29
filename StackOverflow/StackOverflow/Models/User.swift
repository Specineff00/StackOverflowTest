//
//  User.swift
//  StackOverflow
//
//  Created by Yogesh N Ramsorrrun on 28/07/2019.
//  Copyright © 2019 Yogesh N Ramsorrrun. All rights reserved.
//

import UIKit

class User: Decodable {
    let userName: String
    let profileImage: String
    let reputation: Int
    
    var isExpanded: Bool
    var isFollowed: Bool
    var isBlocked: Bool
    
    init(userName: String,
         profileImage: String,
         reputation: Int,
         isExpanded: Bool = false,
         isFollowed: Bool = false,
         isBlocked: Bool = false) {
        self.userName = userName
        self.profileImage = profileImage
        self.reputation = reputation
        self.isExpanded = isExpanded
        self.isFollowed = isFollowed
        self.isBlocked = isBlocked
    }
    
    enum CodingKeys: String, CodingKey {
        case userName = "display_name"
        case profileImage = "profile_image"
        case reputation = "reputation"
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let userName: String = try container.decode(String.self, forKey: .userName)
        let profileImage: String = try container.decode(String.self, forKey: .profileImage)
        let reputation: Int = try container.decode(Int.self, forKey: .reputation)
        
        self.init(userName: userName, profileImage: profileImage, reputation: reputation)
    }
}
