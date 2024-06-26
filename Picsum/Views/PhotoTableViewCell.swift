//
//  PhotoTableViewCell.swift
//  Picsum
//
//  Created by Madhu on 25/06/24.
//

import UIKit
import SDWebImage

protocol PhotoTableViewCellDelegate: AnyObject {
    func didSelectCheckMark(for index: Int, isChecked: Bool)
}

class PhotoTableViewCell: UITableViewCell {
    static let identifier = "PhotoTableViewCell"

    let cellImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let checkboxButton = UIButton(type: .custom)
    var itemIndex: Int?
    var item: PhotoData?
    var delegate: PhotoTableViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0

        contentView.addSubview(cellImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(checkboxButton)
        checkboxButton.setImage(UIImage(systemName: "square"), for: .normal)
        
        
        checkboxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellImageView.widthAnchor.constraint(equalToConstant: 50),
            cellImageView.heightAnchor.constraint(equalToConstant: 50),

            titleLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: checkboxButton.leadingAnchor, constant: -16),

            descriptionLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: checkboxButton.leadingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            checkboxButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkboxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkboxButton.widthAnchor.constraint(equalToConstant: 48),
            checkboxButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: PhotoData, atIndex index: Int) {
        itemIndex = index
        self.item = item
        titleLabel.text = item.author
        descriptionLabel.text = item.url
        cellImageView.sd_setImage(with: URL(string: item.downloadURL), completed: nil)
        checkboxButton.isSelected = item.isChecked
        if item.isChecked == true {
            checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            checkboxButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }

    @objc func checkboxTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            checkboxButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
        if let index = itemIndex {
            delegate?.didSelectCheckMark(for: index, isChecked: sender.isSelected)
        }
    }
}
