//
//  HomeView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/16.
//

import UIKit

class HomeView: UIViewController {
    @IBOutlet weak var homeScrollView: UIScrollView!
    @IBOutlet weak var imageBannerCollectionView: UICollectionView!
    @IBOutlet weak var imageBannerLabel: UILabel!
    
    // MARK: 이미지 배너 관련 변수
    var timer: DispatchSourceTimer?
    var currentCellIndex = 0
    
    var images = [
        "banner06",
        "banner01",
        "banner03",
        "banner02",
        "banner04",
        "banner05"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        setupImageBanner()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startImageBannerTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopImageBannerTimer()
    }
}

// MARK: - Extension
private extension HomeView {
    // MARK: 네비게이션 바 설정
    func setupNavigationBar() {
        navigationItem.backButtonTitle = ""
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = .white
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()

        navigationController?.navigationBar.standardAppearance = standardAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
    }
    
    // MARK: 뷰 설정
    func setupViews() {
        homeScrollView.delegate = self
    }
    
    // MARK: - 이미지 배너
    
    // MARK: 이미지 배너 설정
    func setupImageBanner() {
        imageBannerCollectionView.delegate = self
        imageBannerCollectionView.dataSource = self
        
        imageBannerCollectionView.register(UINib(nibName: ImageBannerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageBannerCollectionViewCell.identifier)
    }
    
    // MARK: 이미지 배너 타이머 동작
    func startImageBannerTimer() {
        self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
        self.timer?.schedule(deadline: .now(), repeating: .seconds(5))
        
        self.timer?.setEventHandler { [weak self] in
            guard let self = self else { return }
            if self.currentCellIndex < self.images.count - 1 {
                self.currentCellIndex += 1
            } else {
                self.currentCellIndex = 0
            }
            
            self.imageBannerLabel.text = "\(self.currentCellIndex + 1) / \(self.images.count)"
            
            self.imageBannerCollectionView.scrollToItem(at: IndexPath(item: self.currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
        
        self.timer?.resume()
    }
    
    // MARK: 이미지 배너 타이머 중지
    func stopImageBannerTimer() {
        self.timer?.cancel()
        self.timer = nil
    }
}

// MARK: - UIScrollViewDelegate
extension HomeView: UIScrollViewDelegate {
    // TODO: 스크롤 했을 때 NavigationBar tint color 바꾸는 방법
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            navigationController?.navigationBar.tintColor = .black
        } else {
            navigationController?.navigationBar.tintColor = .white
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        switch scrollView {
        case homeScrollView:
            break
        default:
            let currentPage = Int(ceil(scrollView.contentOffset.x / scrollView.frame.size.width))
            currentCellIndex = currentPage
            self.imageBannerLabel.text = "\(self.currentCellIndex + 1) / \(self.images.count)"
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageBannerCollectionViewCell.identifier, for: indexPath) as! ImageBannerCollectionViewCell
        cell.updateUI(images[indexPath.row], isUrl: false)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: EventView.identifier) as! EventView
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
