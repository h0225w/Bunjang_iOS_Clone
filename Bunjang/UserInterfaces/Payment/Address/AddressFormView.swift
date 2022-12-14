//
//  AddressFormView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/23.
//

import UIKit

class AddressFormView: UIViewController {
    static let identifier = "AddressFormView"
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var addressDetailField: UITextField!
    @IBOutlet weak var defaultAddressButton: UIButton!
    
    var addressId: Int?
    
    var defaultAddress: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupData()
    }
    
    // MARK: 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: 뒤로 가기 버튼 눌렀을 때
    @IBAction func didTapBackButton(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    // MARK: 기본주소로 설정 버튼 눌렀을 때
    @IBAction func didTapDefaultAddressButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        defaultAddress = sender.isSelected
        
        if sender.isSelected {
            sender.tintColor = .red
        } else {
            sender.tintColor = .white
        }
    }
    
    // MARK: 완료 버튼 눌렀을 때
    @IBAction func didTapSubmitButton(_ sender: Any) {
        let name = nameField.text ?? ""
        let phone = phoneField.text ?? ""
        let address = addressField.text ?? ""
        let addressDetail = addressDetailField.text ?? ""
        
        if name != "" && phone != "" && address != "" && addressDetail != "" {
            let address = Address(name: name, phone: phone, content: address, detail: addressDetail, defaultAddress: defaultAddress)
            
            if let addressId = addressId {
                AddressService.edit(address, addressId: addressId) { [weak self] data in
                    if data.isSuccess {
                        self?.dismiss(animated: false)
                    } else {
                        let alert = Helper().alert(title: "주소 수정 실패", msg: data.message)
                        self?.present(alert, animated: true)
                    }
                }
            } else {
                AddressService.register(address) { [weak self] data in
                    if data.isSuccess {
                        self?.dismiss(animated: false)
                    } else {
                        let alert = Helper().alert(title: "주소 추가 실패", msg: data.message)
                        self?.present(alert, animated: true)
                    }
                }
            }
        }
    }
}

// MARK: - Extension
private extension AddressFormView {
    func setupViews() {
        [nameField, phoneField, addressField, addressDetailField].forEach {
            $0?.addBottomBorder()
        }
    }
    
    func setupData() {
        if let addressId = addressId {
            AddressService.getAddress(addressId: addressId) { [weak self] data in
                guard let self = self else { return }
                print(data)
                self.nameField.text = data.result.name
                self.phoneField.text = data.result.phone
                self.addressField.text = data.result.content
                self.addressDetailField.text = data.result.detail
                self.defaultAddressButton.isSelected = data.result.defaultAddress
            }
        }
    }
}
