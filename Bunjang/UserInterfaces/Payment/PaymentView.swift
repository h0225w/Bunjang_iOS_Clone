//
//  PaymentView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/21.
//

import UIKit
import Kingfisher

class PaymentView: UIViewController {
    static let identifier = "PaymentView"
    
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var paymentMethodView: UIView!
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var addressNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressPhoneLabel: UILabel!
    @IBOutlet weak var addressRequestField: UITextField!
    
    @IBOutlet weak var usingPointField: UITextField!
    
    @IBOutlet weak var paymentProductPriceLabel: UILabel!
    @IBOutlet weak var paymentExchangeChargeLabel: UILabel!
    @IBOutlet weak var paymentPriceLabel: UILabel!
    
    // MARK: 배송지 정보
    var address: AddressListResult?
    
    // MARK: 상품 정보
    var productId: Int?
    var product: ProductDetailResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: 배송지 주소 선택 버튼 눌렀을 때
    @IBAction func didTapAddressSelectButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: AddressSelectView.identifier) as! AddressSelectView
        
        vc.completion = { [weak self] data in
            guard let self = self else { return }
            
            self.addressNameLabel.text = data.name
            self.addressLabel.text = data.content + " " + data.detail
            self.addressPhoneLabel.text = data.phone
            
            self.address = data
        }
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        self.present(vc, animated: true)
    }
    
    // MARK: 결제 하기 버튼 눌렀을 때
    @IBAction func didTapPaymentButton(_ sender: Any) {
        let addressRequest = addressRequestField.text ?? ""
        let usingPoint = usingPointField.text ?? ""
        let parcel = true
        let paymentMethod = "카드"
        
        if let productId = productId, let address = address {
            let payment = Payment(productId: productId, addressId: address.addressID, parcel: parcel, request: addressRequest, paymentMethod: paymentMethod, usingPoint: Int(usingPoint) ?? 0)
            
            PaymentService.register(payment) { [weak self] data in
                if data.isSuccess {
                    let action: (() -> Void) = {
                        self?.dismiss(animated: false)
                    }
                    
                    let alert = Helper().alert(title: "결제 완료", msg: data.message, action: action)
                    self?.present(alert, animated: true)
                } else {
                    let alert = Helper().alert(title: "결제 실패", msg: data.message)
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    // MARK: 닫기 버튼 눌렀을 때
    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // MARK: 번개페이 혜택 이벤트 자세히보기 버튼 눌렀을 때
    @IBAction func didTapPaymentEventButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: PaymentEventView.identifier) as! PaymentEventView
        
        self.present(vc, animated: true)
    }
}

// MARK: - Extension
private extension PaymentView {
    func setupViews() {
        if let product = product {
            let imageUrl = URL(string: product.image[0])
            productImageView.kf.indicatorType = .activity
            productImageView.kf.setImage(with: imageUrl)
            [productPriceLabel, paymentProductPriceLabel, paymentPriceLabel].forEach {
                $0.text = "\(Helper().numberFormatter(number: product.price))원"
            }
            productNameLabel.text = "\(product.name)"
        }
        
        [addressView, paymentView, paymentMethodView].forEach {
            $0?.layer.borderColor = UIColor.systemGray5.cgColor
            $0?.layer.borderWidth = 1
            $0?.layer.cornerRadius = 5
        }
    }
}
