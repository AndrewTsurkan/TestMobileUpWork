//
//  CalleryViewController.swift
//  TestMU
//
//  Created by Андрей Цуркан on 22.04.2023.
//

import UIKit

class GalleryViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var photosLoadingService = PhotosLoadingService()
    private var photos: [PhotosResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupFlowLayout()
        loadData()

        title = "MobileUp Gallery"
        view.backgroundColor = .white
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let saveArea = view.safeAreaLayoutGuide
        
        [collectionView.topAnchor.constraint(equalTo: saveArea.topAnchor),
         collectionView.leftAnchor.constraint(equalTo: saveArea.leftAnchor),
         collectionView.rightAnchor.constraint(equalTo: saveArea.rightAnchor),
         collectionView.bottomAnchor.constraint(equalTo: saveArea.bottomAnchor)].forEach{ $0.isActive = true }
        
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reusedId)
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(100, 100)
        
        return layout
    }
    
    private func loadData() {
        let url = PhotosLoadingService().getUrl(path: API.photos)
        photosLoadingService.fetchJson { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(items):
                self.photos = items
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure:
                break
            }
        }
    }
}

extension GalleryViewController: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reusedId, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        let photos = photos[indexPath.item]
        return cell
    }
}
