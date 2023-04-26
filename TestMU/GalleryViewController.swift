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
    private var photos: PhotosResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadData()
        
        title = "MobileUp Gallery"
        view.backgroundColor = .white
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let saveArea = view.safeAreaLayoutGuide
        collectionView.delegate = self
        
        [collectionView.topAnchor.constraint(equalTo: saveArea.topAnchor),
         collectionView.leftAnchor.constraint(equalTo: saveArea.leftAnchor),
         collectionView.rightAnchor.constraint(equalTo: saveArea.rightAnchor),
         collectionView.bottomAnchor.constraint(equalTo: saveArea.bottomAnchor)].forEach{ $0.isActive = true }
        
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reusedId)
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        return layout
    }
    
    private func loadData() {
        let url = PhotosLoadingService().getUrl(path: API.photos)
        guard  let url else { return }
        photosLoadingService.fetchJson(url: url) { [weak self] result in
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

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = photos?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reusedId, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        let infoImage = photos?.items[indexPath.item].sizes.first(where: { $0.type == "z"})?.url
        cell.urlString = infoImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedView = DetailedViewController()
        let photos = photos?.items[indexPath.item]
        detailedView.detailPhotos = photos
        self.navigationController?.pushViewController(detailedView, animated: true)
    }
}
