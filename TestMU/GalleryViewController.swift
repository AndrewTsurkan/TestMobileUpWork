//
//  CalleryViewController.swift
//  TestMU
//
//  Created by Андрей Цуркан on 22.04.2023.
//

import UIKit

class GalleryViewController: UIViewController {
    
//    var collectionView = UICollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MobileUp Gallery"
        view.backgroundColor = .blue
        
//        setupCollectionView()
//        setupFlowLayout()
    }
    
//    private func setupCollectionView() {
////        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
//        view.addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        
//        [collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//         collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//         collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//         collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach{ $0.isActive = true }
//        
////        collectionView.dataSource = self
//        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reusedId)
//    }
    
    func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(100, 100)
        
        return layout
    }
}

//extension GalleryViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reusedId, for: indexPath) as? PhotoCell else {
//            return UICollectionViewCell()
//        }
//        return cell
//    }
//}
