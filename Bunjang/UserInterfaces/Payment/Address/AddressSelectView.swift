//
//  AddressSelectView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/23.
//

import UIKit

class AddressSelectView: UIViewController {
    static let identifier = "AddressSelectView"
    
    @IBOutlet weak var tableView: UITableView!
    
    var completion: ((AddressListResult) -> Void)?
    var addressList: [AddressListResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }
    
    // MARK: 주소 관리 버튼 눌렀을 때
    @IBAction func didTapAddressManageButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: AddressManageView.identifier) as! AddressManageView
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    // MARK: 닫기 버튼 눌렀을 때
    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: - Extension
private extension AddressSelectView {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: AddressSelectTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AddressSelectTableViewCell.identifier)
    }
    
    func setupData() {
        AddressService.getAddressList { [weak self] data in
            guard let self = self else { return }
                
            self.addressList = data.result
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension AddressSelectView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressSelectTableViewCell.identifier, for: indexPath) as! AddressSelectTableViewCell
        cell.updateUI(addressList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        completion?(addressList[indexPath.row])
        self.dismiss(animated: true)
    }
}
