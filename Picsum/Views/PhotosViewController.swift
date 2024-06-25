//
//  ViewController.swift
//  Picsum
//
//  Created by Madhu on 25/06/24.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = PhotoViewModel()
    private var refreshControl: UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(PhotoTableViewCell.nib(), forCellReuseIdentifier: PhotoTableViewCell.identifier)
        fetchIntialData()
        setUpRefershControl()
    }
    
    private func fetchIntialData() {
        Task {
            await viewModel.fetchPhotosData()
            tableView.reloadData()
        }
    }
    
    private func setUpRefershControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshData() {
        Task {
            await viewModel.fetchPhotosData()
            tableView.reloadData()
            tableView.refreshControl?.endRefreshing()
        }
    }
}

extension PhotosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.photos.count)
        return viewModel.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
        let item = viewModel.photos[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = viewModel.photos[indexPath.row]
        let aspectRatio = CGFloat(item.height) / CGFloat(item.width)
        let cellWidth = tableView.frame.width
        return cellWidth * aspectRatio + 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.photos[indexPath.row]
        if item.isChecked {
            let alert = UIAlertController(title: "Descrpition", message: item.url, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Descrpition", message: "Check box is not enable", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}

