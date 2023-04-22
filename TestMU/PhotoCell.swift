//
//  PhotoCell.swift
//  TestMU
//
//  Created by Андрей Цуркан on 22.04.2023.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    static var reusedId = "InstallCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        self.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        self.clipsToBounds = true
        
        [imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
         imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
         imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
         imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)].forEach{ $0.isActive = true }
    }
}