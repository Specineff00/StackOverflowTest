//
//  TopUserTableViewCell.swift
//  StackOverflow
//
//  Created by Yogesh N Ramsorrrun on 28/07/2019.
//  Copyright © 2019 Yogesh N Ramsorrrun. All rights reserved.
//

import UIKit

protocol TopUserTableViewCellDelegate: class {
    func didTapFollow(indexRow: Int)
    func didTapBlock(indexRow: Int)
}

class TopUserTableViewCell: UITableViewCell {

    static let reuseIdentifier = "TopUserTableViewCell"
    weak var delegate: TopUserTableViewCellDelegate?
    var isExpanded = false
    var isFollowed = false
    var isBlocked = false
    var indexRow = 0
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var reputationLabel: UILabel!
   
    var stackView: UIStackView?
    var followButton: UIButton?
    var blockButton: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        clipsToBounds = true
    }
    
    func configureCell(user: User, delegate: TopUserTableViewCellDelegate?, indexRow: Int) {
        userNameLabel.text = user.userName
        profileImageView.downloaded(from: user.profileImage)
        reputationLabel.text = "Reputation: \(user.reputation)"
        isExpanded = user.isExpanded
        isFollowed = user.isFollowed
        isBlocked = user.isBlocked
        self.delegate = delegate
        self.indexRow = indexRow
        
        follow(user.isFollowed)
        block(user.isBlocked)
        if user.isBlocked {
            collapseView()
            return
        }
        isExpanded ? expandView() : collapseView()
    }
    
    private func setupButtons() {
        followButton = UIButton(type: .custom)
        followButton?.layer.borderWidth = 1.0
        followButton?.layer.borderColor = UIColor.darkGray.cgColor
        followButton?.backgroundColor = .green
        followButton?.tintColor = .white
        followButton?.addTarget(self, action: #selector(didTapFollow), for: .touchUpInside)
        
        
        blockButton = UIButton(type: .custom)
        blockButton?.layer.borderWidth = 1.0
        blockButton?.layer.borderColor = UIColor.darkGray.cgColor
        blockButton?.backgroundColor = .red
        blockButton?.tintColor = .white
        blockButton?.addTarget(self, action: #selector(didTapBlock), for: .touchUpInside)
        
        follow(isFollowed)
        block(isBlocked)
    }
    
    private func expandView() {
        setupButtons()
        guard let followButton = followButton,
            let blockButton = blockButton else { return }
        
        let stackView = UIStackView(arrangedSubviews: [followButton, blockButton])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 45).isActive = true
        
        self.stackView = stackView
    }
    
    private func collapseView() {
        stackView?.removeFromSuperview()
        stackView = nil
        followButton = nil
        blockButton = nil
    }
    
    
    @objc private func didTapFollow() {
        delegate?.didTapFollow(indexRow: indexRow)
    }
    
    @objc private func didTapBlock() {
        delegate?.didTapBlock(indexRow: indexRow)
    }
    
    private func follow(_ isFollowing: Bool) {
        let buttonTitle = isFollowing ? "Unfollow" : "Follow"
        let buttonColor = isFollowing ? UIColor.gray : UIColor.green
        followButton?.setTitle(buttonTitle, for: .normal)
        followButton?.backgroundColor = buttonColor
    }
    
    private func block(_ isBlocked: Bool) {
        isUserInteractionEnabled = !isBlocked
        backgroundColor = isBlocked ? .darkGray : .white
        userNameLabel.textColor = isBlocked ? .gray : .black
        reputationLabel.textColor = isBlocked ? .gray : .black
        isExpanded = !isBlocked
        profileImageView.image = isBlocked ?  nil : profileImageView.image
        profileImageView.backgroundColor = isBlocked ? .gray : .white
        
        blockButton?.backgroundColor = isBlocked ? .gray : .red
        let buttonTitle = isBlocked ? "Blocked" : "Block"
        let buttonColor = isBlocked ? UIColor.gray : UIColor.red
        blockButton?.setTitle(buttonTitle, for: .normal)
        blockButton?.backgroundColor = buttonColor
    }
    
}
