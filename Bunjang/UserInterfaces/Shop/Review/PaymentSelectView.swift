//
//  PaymentSelectView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/25.
//

import UIKit

class PaymentSelectView: UIViewController {
    static let identifier = "PaymentSelectView"
    
    @IBOutlet weak var tableView: UITableView!
    
    var paymentList: [PaymentListResult] = []
    
    var completion: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Actions
    
    // MARK: 뒤로가기 눌렀을 때
    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extension
private extension PaymentSelectView {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: PaymentSelectTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PaymentSelectTableViewCell.identifier)
    }
    
    func setupData() {
        PaymentService.getPayments("dealComplete") { [weak self] data in
            if data.isSuccess {
                self?.paymentList = data.result
                
                self?.tableView.reloadData()
            } else {
                let alert = Helper().alert(title: "상점 후기", msg: data.message)
                self?.present(alert, animated: true)
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PaymentSelectView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentSelectTableViewCell.identifier, for: indexPath) as! PaymentSelectTableViewCell
        cell.updateUI(paymentList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: ReviewFormView.identifier) as! ReviewFormView
        
        vc.paymentId = paymentList[indexPath.row].paymentID
        vc.completion = completion
        navigationController?.pushViewController(vc, animated: true)
    }
}
