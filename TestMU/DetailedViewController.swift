//
//  DateilViewController.swift
//  TestMU
//
//  Created by Андрей Цуркан on 26.04.2023.
//

import UIKit
import Nuke

class DetailedViewController: UIViewController {
    
    var imageView = UIImageView()
    var collectionView: UICollectionView!
    var detailPhotos: PhotosItems
    
    init(detailPhotos: PhotosItems) {
        self.detailPhotos = detailPhotos
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updataDate()
        reloadData()
        setupImageView()
        view.backgroundColor = .white
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
        imageView.contentMode = .scaleAspectFit

        [imageView.topAnchor.constraint(equalTo: view.topAnchor),
         imageView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
         imageView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
         imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)].forEach{ $0.isActive = true }
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }
    
    private func updataDate() {
        guard let timestamp = detailPhotos.date else { return }
        let date = Date(timeIntervalSince1970: Double(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "d MMMM yyyy"
        let strDate = dateFormatter.string(from: date)
        title = strDate
    }
    func reloadData() {
        
        let urlString = detailPhotos.sizes.first(where: { $0.type == "w"})?.url
        guard let urlString else { return }
        let url = URL(string: urlString)
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

