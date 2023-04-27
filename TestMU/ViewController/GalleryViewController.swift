//
//  CalleryViewController.swift
//  TestMU
//
//  Created by Андрей Цуркан on 22.04.2023.
//

import UIKit
import VK_ios_sdk

class GalleryViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var photosLoadingService = PhotosLoadingService()
    private var photos: PhotosResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadData()
        setupButton()
        setupNavigationItems()
    }
    
    private func setupNavigationItems() {
        title = "MobileUp Gallery"
        view.backgroundColor = UIColor(named: "colorSetDark")
        navigationController?.navigationBar.backgroundColor = UIColor(named: "colorSetDark")
        navigationItem.hidesBackButton = true
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let safeArea = view.safeAreaLayoutGuide
        collectionView.delegate = self
        
        [collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
         collectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
         collectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
         collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)].forEach{ $0.isActive = true }
        
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reusedId)
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 3
        let screen = UIScreen.main.bounds.width / 2 - 2
        layout.itemSize = .init(width: screen, height: screen)
        
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
    
    private func setupButton() {
        let button = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(onExitTap))
        button.tintColor = UIColor(named: "colorSetLight")
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func onExitTap() {
        VKSdk.forceLogout()
        navigationController?.popViewController(animated: true)
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
        
        let infoImage = photos?.items[indexPath.item].sizes.first(where: { $0.type == "q"})?.url
        cell.urlString = infoImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photos = photos?.items[indexPath.item] else { return }
        let detailedView = DetailedViewController(detailPhotos: photos)
        navigationController?.pushViewController(detailedView, animated: true)
    }
}


