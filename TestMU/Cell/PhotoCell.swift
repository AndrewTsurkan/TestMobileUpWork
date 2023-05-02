//
//  PhotoCell.swift
//  TestMU
//
//  Created by Андрей Цуркан on 22.04.2023.
//

import UIKit
import Nuke

class PhotoCell: UICollectionViewCell {
    
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
        imageView.contentMode = .scaleAspectFill
        imageView.addText("скоро буду")
        imageView.removeAll()

        
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
            case .failure(_):
                let fail = UIAlertController(title: "Не удалось загрузить фото", message: nil, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default)
                fail.addAction(okButton)
                self?.window?.rootViewController?.navigationController?.pushViewController(fail, animated: true)
            }
        }
    }
}
extension UIImageView {
    func addText(_ text: String) {
        let lblText = UILabel(frame: self.bounds)
        lblText.text = text
        lblText.textAlignment = .center
        self.addSubview(lblText)
    }

    func removeAll() {
        for v in self.subviews {
            v.removeFromSuperview()
        }
    }
}
