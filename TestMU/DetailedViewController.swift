//
//  DateilViewController.swift
//  TestMU
//
//  Created by Андрей Цуркан on 26.04.2023.
//

import UIKit

class DetailedViewController: UIViewController {
    
    var imageView = UIImageView()
    var collectionView: UICollectionView!
    var detailPhotos: PhotosItems? {
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let saveArea = view.safeAreaLayoutGuide
//        collectionView.delegate = self
        
        [collectionView.heightAnchor.constraint(equalToConstant: 54),
         collectionView.leftAnchor.constraint(equalTo: saveArea.leftAnchor),
         collectionView.rightAnchor.constraint(equalTo: saveArea.rightAnchor),
         collectionView.bottomAnchor.constraint(equalTo: saveArea.bottomAnchor)].forEach{ $0.isActive = true }
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        imageView.contentMode = .scaleAspectFill

        
        [imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
         imageView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
         imageView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
         imageView.bottomAnchor.constraint(equalTo: collectionView.topAnchor)].forEach{ $0.isActive = true }
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        return layout
    }
    
//    private func updata() {
////        title = String
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
//        dateFormatter.locale = NSLocale.current
//        dateFormatter.dateFormat = "yyyy-MM-dd" //Specify your format that you want
//        let strDate = dateFormatter.string(from: detailPhotos?.date)
//    }
}

