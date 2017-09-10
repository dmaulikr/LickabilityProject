//
//  PhotosDetailViewController.swift
//  Lickability
//
//  Created by Komran Ghahremani on 8/10/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class PhotosDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlIconView: UIView!
    @IBOutlet weak var thumbnailIconView: UIView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var thumbnailLabel: UILabel!
    
    var disposeBag = DisposeBag()
    lazy var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.photo
            .asObservable()
            .subscribe(onNext: { [unowned self] photo in
                self.titleLabel.text = photo.title
                self.urlLabel.text = photo.url
                self.thumbnailLabel.text = photo.thumbnailUrl
                
                self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
                self.imageView.layer.borderColor = UIColor.white.cgColor
                self.imageView.layer.borderWidth = 10.0
                
                guard let url = URL(string: photo.url) else { return }
                self.imageView.kf.setImage(with: url)
            }
        ).addDisposableTo(disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        completeTransition()
    }
    
    func completeTransition() {
        delay(for: 0.4) { [unowned self] _ in
            self.viewModel.color = self.imageView.getPixelColor(at: CGPoint(x: 50, y: 50))
            self.view.backgroundColor = self.viewModel.color
            self.navigationController?.navigationBar.tintColor = self.viewModel.color
        }
        
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 1.0
            self.titleLabel.alpha = 1.0
            self.urlIconView.alpha = 1.0
            self.thumbnailIconView.alpha = 1.0
            self.urlLabel.alpha = 1.0
            self.thumbnailLabel.alpha = 1.0
        })
        
        urlIconView.layer.cornerRadius = 5.0
        thumbnailIconView.layer.cornerRadius = 5.0
    }
}
