//
//  ProductRegisterView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/19.
//

import UIKit

class ProductRegisterView: UIViewController {
    static let identifier = "ProductRegisterView"
    
    @IBOutlet weak var imagePickerButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var optionSelectButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var optionLabel: UILabel!
    
    @IBOutlet weak var safePaymentButton: UIButton!
    
    var count: Int = 1
    var used: Bool = true // 중고상품
    var exchange: Bool = false // 교환불가
    var includeDeliveryCharge: Bool = false // 배송비별도
    var safePayment: Bool = true // 안전구매 환영
    
    let imagePicker = UIImagePickerController()
    
    let contentTextViewPlaceholder = "여러 장의 상품 사진과 구입 연도, 브랜드, 사용감, 하자 유무 등 구매자에게 필요한 정보를 꼭 포함해주세요. 문의를 줄이고 더 쉽게 판매할 수 있어요. (10자 이상)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupImagePicker()
    }
    
    // MARK: - Actions
    
    // MARK: 뒤로 가기
    @IBAction func didTapBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapImagePickerButton(_ sender: Any) {
        pickImage()
    }
    
    // MARK: 옵션 선택 버튼 눌렀을 때
    @IBAction func didTapOptionSelectButton(_ sender: Any) {
        presentModal()
    }
    
    // MARK: 안전결제 환영 눌렀을 때
    @IBAction func didTapSafePaymentButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        safePayment = sender.isSelected
        
        if sender.isSelected {
            sender.layer.borderColor = UIColor.systemRed.cgColor
        } else {
            sender.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    // MARK: 등록 눌렀을 때
    @IBAction func didTapRegisterButton(_ sender: Any) {
        let name = nameTextField.text ?? ""
        let category = categoryTextField.text ?? ""
        let content = contentTextView.text ?? ""
        let priceText = priceTextField.text ?? ""
        
        var tag: [String] = []
        if let tagText = tagTextField.text {
            tag = tagText.components(separatedBy: ",")
        }
        
        if name != "" && category != "" && content != "" && priceText != "" {
            let price = Int(priceText)!
            
            // TODO: 이미지도 전달되도록 작업 필요
            let product = Product(name: name, category: category, content: content, price: price, count: count, safePayment: safePayment, deliveryCharge: includeDeliveryCharge, used: used, exchange: exchange, tag: tag, images: ["https://cdn.pixabay.com/photo/2019/12/23/01/16/cream-4713579__480.jpg"])
            
            ProductService.register(product) { [weak self] data in
                guard let self = self else { return }
                
                let alert = Helper().alert(title: "상품 등록", msg: data.message)
                self.present(alert, animated: true)
            }
        }
    }
}

// MARK: - Extension
private extension ProductRegisterView {
    // MARK: View 설정
    func setupViews() {
        [nameTextField, categoryTextField, tagTextField, priceTextField].forEach {
            $0?.addBottomBorder()
        }
        
        optionSelectButton.layer.borderColor = UIColor.lightGray.cgColor
        optionSelectButton.layer.borderWidth = 1
        optionSelectButton.layer.cornerRadius = 5
        
        safePaymentButton.layer.borderColor = UIColor.systemRed.cgColor
        safePaymentButton.layer.borderWidth = 1
        safePaymentButton.layer.cornerRadius = 5
        
        safePaymentButton.isSelected = true
        
        contentTextView.text = contentTextViewPlaceholder
        contentTextView.textColor = .placeholderText
        contentTextView.delegate = self
    }
    
    // MARK: 이미지 선택 창 설정
    func setupImagePicker() {
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self
    }
    
    // MARK: 옵션 선택 창 열기
    func presentModal() {
        let vc = storyboard?.instantiateViewController(withIdentifier: OptionSelectView.identifier) as! OptionSelectView
        
        vc.modalPresentationStyle = .pageSheet
        vc.completion = { data in
            self.used = true
            self.exchange = false
            self.includeDeliveryCharge = false
            
            var usedText: String = "중고상품"
            var exchangeText: String = "교환불가"
            var deliveryChargeText: String = "배송비별도"
            
            if data[1] > 0 {
                self.used = false
                usedText = "새상품"
            }
            
            if data[2] > 0 {
                self.exchange = true
                exchangeText = "교환가능"
            }
            
            if data[3] > 0 {
                self.exchange = true
                deliveryChargeText = "배송비포함"
            }
            
            self.optionLabel.text = "\(data[0])개﹒\(usedText)﹒\(exchangeText)﹒\(deliveryChargeText)"
        }
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        self.present(vc, animated: true)
    }
    
    // MARK: 이미지 선택 창 열기
    @objc func pickImage() {
        self.present(self.imagePicker, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ProductRegisterView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // update 할 이미지
        var newImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            // 수정된 이미지가 있을 경우
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // 원본 이미지가 있을 경우
            newImage = possibleImage
        }
        
        productImageView.contentMode = .scaleAspectFill
        productImageView.image = newImage
        picker.dismiss(animated: true, completion: nil)
        
    }
}

// MARK: - UITextViewDelegate
extension ProductRegisterView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .placeholderText else { return }
        textView.textColor = .label
        textView.text = nil
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = contentTextViewPlaceholder
            textView.textColor = .placeholderText
        }
    }
}
