//
//  PhotoTableViewCell.swift
//  Picsum
//
//  Created by Singh, Manoj (Cognizant) on 25/06/24.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    static let identifier = "PhotoTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    private var item: TableViewItem?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with item: TableViewItem) {
        self.item = item
        self.titleLabel.text = item.author
        self.descriptionLabel.text = item.url
        self.checkBoxButton.isSelected = item.isChecked
        self.photoImageView.image = nil
        loadImage()
    }
    
    private func loadImage() {
        guard let urlString = item?.downloadUrl, let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.photoImageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        item?.isChecked = sender.isSelected
    }
}
