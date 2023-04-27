//
//  DateilViewController.swift
//  TestMU
//
//  Created by Андрей Цуркан on 26.04.2023.
//

import UIKit
import Nuke

class DetailedViewController: UIViewController {
    
    private var imageView = UIImageView()
    private var collectionView: UICollectionView!
    var detailPhotos: PhotosItems
    private var photosLoadingService = PhotosLoadingService()
    private var photos: PhotosResponse?
    let pinchGesture = UIPanGestureRecognizer(target: DetailedViewController.self, action: #selector(DetailedViewController.pinchGesture(sender:)))
    
    
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
        reloadImage()
        reloadData()
        setupCollectionView()
        setupImageView()
        setupButtonShare()
        setupButtonBack()
        view.backgroundColor = .white
        
    }
    @objc func pinchGesture(sender: UIPinchGestureRecognizer) {
        sender.view!.transform = CGAffineTransformScale(sender.view!.transform, sender.scale, sender.scale)
        sender.scale = 1
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let saveArea = view.safeAreaLayoutGuide
        imageView.addGestureRecognizer(pinchGesture)
        
        collectionView.dataSource = self
        collectionView.register(DeteiledCell.self, forCellWithReuseIdentifier: DeteiledCell.reusedId)
        
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
        imageView.isUserInteractionEnabled = true
        
        [imageView.topAnchor.constraint(equalTo: view.topAnchor),
         imageView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
         imageView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
         imageView.bottomAnchor.constraint(equalTo: collectionView.topAnchor)].forEach{ $0.isActive = true }
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 54, height: 54)
        layout.minimumLineSpacing = 2
        layout.scrollDirection = .horizontal
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
    
    func reloadImage() {
        let urlString = detailPhotos.sizes.first(where: { $0.type == "z"})?.url
        guard let urlString else { return }
        let url = URL(string: urlString)
        ImagePipeline.shared.loadImage(with: url) { [weak self] result in
            switch result {
            case let .success(success):
                DispatchQueue.main.async {
                    self?.imageView.image = success.image
                }
            case .failure(_):
                break
            }
        }
    }
    
    private func setupButtonShare() {
        let buttonShare = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(onShareTap))
        navigationItem.rightBarButtonItem = buttonShare
        buttonShare.tintColor = .black
    }
    
    private func setupButtonBack() {
        let buttonBack = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(onBackTap))
        navigationItem.leftBarButtonItem = buttonBack
        buttonBack.tintColor = .black
    }
    
    @objc private func onBackTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func onShareTap() {
        guard let image = imageView.image?.pngData() else { return }
        let text:[Any] = [UIImage(data: image) as Any]
        let share = UIActivityViewController(activityItems: text, applicationActivities: nil)
        navigationController?.present(share, animated: true)
    }
}

extension DetailedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = photos?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeteiledCell.reusedId, for: indexPath) as? DeteiledCell else { return UICollectionViewCell()
        }
        let infoImage = photos?.items[indexPath.item].sizes.first(where: {$0.type == "m"})?.url
        cell.urlString = infoImage
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    
}
