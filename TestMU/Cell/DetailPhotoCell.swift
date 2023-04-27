//
//  DetailPhotoCell.swift
//  TestMU
//
//  Created by Андрей Цуркан on 28.04.2023.
//

import UIKit
import Nuke


class DetailPhotoCell : UICollectionViewCell {

        let imageView = UIImageView()
        static var reusedId = "InstallCell"
        var urlString: String? {
            didSet{
                reloadData()
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupImageView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupImageView() {
            contentView.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleToFill
            
            self.clipsToBounds = true
            
            [imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
             imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
             imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
             imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)].forEach{ $0.isActive = true }
        }
        
        func reloadData() {
            guard let urlString, let url = URL(string: urlString) else { return }
            
            ImagePipeline.shared.loadImage(with: url) { [weak self] result in
                switch result {
                case let .success(success):
                    DispatchQueue.main.async {
                        self?.imageView.image = success.image
                    }
                case .failure(let failure):
                    break
                }
            }
        }
    }

