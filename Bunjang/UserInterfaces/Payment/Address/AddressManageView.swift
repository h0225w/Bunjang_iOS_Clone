//
//  AddressManageView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/23.
//

import UIKit

class AddressManageView: UIViewController {
    static let identifier = "AddressManageView"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var addressList: [AddressListResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }
    
    // MARK: 뒤로 가기 버튼 눌렀을 때
    @IBAction func didTapBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // MARK: - 주소 추가 버튼 눌렀을 때
    @IBAction func didTapAddressFormButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: AddressFormView.identifier) as! AddressFormView
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
}

// MARK: - Extension
private extension AddressManageView {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: AddressManageCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: AddressManageCollectionViewCell.identifier)
    }
    
    func setupData() {
        AddressService.getAddressList { [weak self] data in
            guard let self = self else { return }
            
            self.addressList = data.result
            
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension AddressManageView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addressList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddressManageCollectionViewCell.identifier, for: indexPath) as! AddressManageCollectionViewCell
        cell.delegate = self
        cell.updateUI(addressList[indexPath.row])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AddressManageView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

// MARK: - Extension
extension AddressManageView: AddressManageCollectionViewCellDelegate {
    func moveToEditForm(addressId: Int) {
        let vc = storyboard?.instantiateViewController(withIdentifier: AddressFormView.identifier) as! AddressFormView
        
        vc.addressId = addressId
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    func delete(addressId: Int) {
        AddressService.delete(addressId: addressId) { [weak self] data in
            guard let self = self else { return }
            
            if data.isSuccess {
                self.setupData()
            } else {
                let alert = Helper().alert(title: "주소 삭제 실패", msg: data.message)
                self.present(alert, animated: true)
            }
        }
    }
}
