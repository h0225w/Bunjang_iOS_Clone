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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
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
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PaymentSelectView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentSelectTableViewCell.identifier, for: indexPath) as! PaymentSelectTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
