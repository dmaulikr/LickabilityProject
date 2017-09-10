//
//  PhotosTableViewCell.swift
//  Lickability
//
//  Created by Komran Ghahremani on 8/9/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class PhotosTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    static let Identifier = "photoCell"
    var photo: Photo?
    var color: UIColor?
    var disposeBag = DisposeBag()
    
    func configure(with photo: Photo) {
        self.photo = photo
        guard let url = URL(string: photo.thumbnailUrl) else { return }
        
        thumbnailView.layer.cornerRadius = 5.0
        thumbnailView.kf.setImage(with: url) { [unowned self] _, _, _, _ in
            self.color = self.thumbnailView.getPixelColor(at: CGPoint(x: 50, y: 50))
        }
        
        titleLabel.text = photo.title
        subtitleLabel.text = photo.url
    }
    
    override func prepareForReuse() {
        self.disposeBag = DisposeBag()
    }
}
