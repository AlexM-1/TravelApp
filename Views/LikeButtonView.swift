//
//  LikeButtonView.swift
//  TravelAppWB
//
//  Created by Alex M on 08.08.2023.
//

import UIKit

final class LikeButtonView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentMode = .scaleAspectFit
        tintColor = .systemGray
        image = UIImage(systemName: "heart")
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setIsLiked(newLikeStatus: Bool?) {

        guard let newLikeStatus else { return }

        if newLikeStatus {
            tintColor = #colorLiteral(red: 0.9579073787, green: 0.2599314153, blue: 0.2141381502, alpha: 1)
            image = UIImage(systemName: "heart.fill")

        } else {
            tintColor = .systemGray
            image = UIImage(systemName: "heart")
        }
    }

}
