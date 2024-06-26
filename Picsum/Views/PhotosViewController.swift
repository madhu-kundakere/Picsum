//
//  ViewController.swift
//  Picsum
//
//  Created by Madhu on 25/06/24.
//

import UIKit


class PhotosViewController: UIViewController {
    private enum Constants {
        static let title = "Warning"
        static let alertTitle = "OK"
        static let checkMarkClickMessage = "You Should select the CheckBox"
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = PhotoViewModel()
    private var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        fetchData()
        setUpRefershControl()
        navigationItem.hidesBackButton = true
    }
    
    private func fetchData() {
        viewModel.fetchPhotosData { [weak self] in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    
    private func setUpRefershControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshData() {
        viewModel.fetchPhotosData(onRefresh: true) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
                strongSelf.tableView.refreshControl?.endRefreshing()
            }
        }
    }
}
extension PhotosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
        cell.delegate = self
        if  indexPath.row == viewModel.photos.count - 1 {
            self.fetchData()
        }
        let item = viewModel.photos[indexPath.row]
        cell.configure(with: item, atIndex: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.photos[indexPath.row]
        if item.isChecked {
            let alert = UIAlertController(title: item.author, message: item.url, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.alertTitle, style: .default))
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: Constants.title, message: Constants.checkMarkClickMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.alertTitle, style: .default))
            self.present(alert, animated: true)
        }
    }
}

extension PhotosViewController: PhotoTableViewCellDelegate {
    func didSelectCheckMark(for index: Int, isChecked: Bool) {
        viewModel.updateCheckBoxForItem(index, isChecked: isChecked)
    }
}

