//
//  PhotosTableViewController.swift
//  Lickability
//
//  Created by Komran Ghahremani on 8/9/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PhotosTableViewController: UIViewController, UITableViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    lazy var viewModel = PhotosViewModel()
    let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        setupNavBar()
        
        // .bind photos stream to table view as data source
        viewModel.photos
            .asObservable()
            .bind(to: tableView
                .rx.items(cellIdentifier: PhotosTableViewCell.Identifier, cellType: PhotosTableViewCell.self)) {
                    row, photo, cell in
                    cell.configure(with: photo)
        }.addDisposableTo(disposeBag)
        
        // listen for errors from api loading incorrectly to display error + reload
        viewModel.error
            .asObservable()
            .filter({ $0 != "" })
            .subscribe(onNext: { [unowned self] message in
                let reload = UIAlertAction(title: "Reload", style: .default, handler: { _ in self.fetchPhotos() })
                let alertVC = alert(with: message, and: reload)
                
                self.present(alertVC, animated: true, completion: nil)
        }).addDisposableTo(disposeBag)
        
        // subscribe to tableview cell tap to open up detail view
        tableView.rx
            .modelSelected(Photo.self)
            .subscribe(onNext: { [unowned self] photo in
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let viewModel = DetailViewModel()
                viewModel.photo = Variable<Photo>(photo)
                
                guard let detailVC = storyboard.instantiateViewController(withIdentifier: "detail") as? PhotosDetailViewController else { return }
                detailVC.viewModel = viewModel
                
                self.navigationController?.pushViewController(detailVC, animated: true)
            }).addDisposableTo(disposeBag)
        
        fetchPhotos()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let indexPath = self.tableView.indexPathsForVisibleRows?[0]
        let cell = tableView.cellForRow(at: indexPath!) as! PhotosTableViewCell
        
        if let label = navigationItem.titleView as? UILabel {
            DispatchQueue.main.async {
                label.textColor = cell.thumbnailView.getPixelColor(at: CGPoint(x: 50, y: 50))
            }
        }
    }
    
    func setupNavBar() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        titleLabel.font = UIFont(name: "Verdana-Light", size: 18.0)
        titleLabel.textAlignment = .center
        titleLabel.text = "lickability".uppercased()
        
        navigationItem.titleView = titleLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activity)
        activity.startAnimating()
    }
    
    func fetchPhotos() {
        activity.startAnimating()
        viewModel.fetchPhotosData() { [unowned self] _ in
            DispatchQueue.main.async {
                self.activity.stopAnimating()
                self.viewModel.error.value = ""
            }
        }
    }
}
