//
//  DetailTransition.swift
//  Lickability
//
//  Created by Komran Ghahremani on 8/10/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit

// Inspiration: http://blog.rinatkhanov.me/ios/transitions.html

class DetailTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private var selectedCellImageFrame: CGRect? = nil
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let photosVC = transitionContext.viewController(forKey: .from) as? PhotosTableViewController,
            let detailVC = transitionContext.viewController(forKey: .to) as? PhotosDetailViewController {
            move(from: photosVC, to: detailVC, with: transitionContext)
        }
        
        else if let photosVC = transitionContext.viewController(forKey: .to) as? PhotosTableViewController,
            let detailVC = transitionContext.viewController(forKey: .from) as? PhotosDetailViewController {
            move(from: detailVC, to: photosVC, with: transitionContext)
        }
    }

    /**
     * Push
     *  
     * Grab cell and convert its frame to the user's view to execute bubble animation 
     * with the color of the cell selected to the detail view controller's image view by scaling it from that point
     *
     * Save the original cell tapped frame so that on pop the detail vc's image view will animate back to that location
     *
     */
    private func move(from photosVC: PhotosTableViewController, to detailVC: PhotosDetailViewController, with context: UIViewControllerContextTransitioning) {
        if let indexPath = photosVC.tableView.indexPathForSelectedRow,
            let cell = photosVC.tableView.cellForRow(at: indexPath) as? PhotosTableViewCell {
            context.containerView.addSubview(detailVC.view)
            
            let frame = cell.convert(cell.thumbnailView.frame, to: UIApplication.shared.keyWindow)
            
            let bubble = UIView()
            bubble.frame = frame
            bubble.contentMode = .scaleAspectFill
            bubble.clipsToBounds = true
            bubble.layer.cornerRadius = bubble.frame.size.width / 2
            bubble.backgroundColor = cell.color
            bubble.alpha = 0.0
            
            detailVC.view.addSubview(bubble)
            selectedCellImageFrame = frame
            
            UIView.animate(withDuration: 0.5, animations: {
                bubble.transform = CGAffineTransform(scaleX: 20.0, y: 20.0)
                bubble.alpha = 1.0
            }, completion: { success in
                detailVC.view.sendSubview(toBack: bubble)
                
                UIView.animate(withDuration: 0.3, animations: {
                    detailVC.view.alpha = 1.0
                    detailVC.view.layoutIfNeeded()
                }, completion: { success in
                    bubble.removeFromSuperview()
                    photosVC.tableView.deselectRow(at: indexPath, animated: false)
                    context.completeTransition(!context.transitionWasCancelled)
                })
            })
        }
    }
    
    /**
     * Pop
     *
     * Animate a bubble from the detial vc image view location to the
     * saved thumbnail location from the push
     */
    private func move(from detailVC: PhotosDetailViewController, to photosVC: PhotosTableViewController, with context: UIViewControllerContextTransitioning) {
        context.containerView.addSubview(photosVC.view)
        photosVC.view.alpha = 0.0
        
        let bubble = UIView()
        bubble.frame = detailVC.imageView.frame
        bubble.layer.cornerRadius = 40.0
        bubble.contentMode = .scaleAspectFill
        bubble.clipsToBounds = true
        bubble.backgroundColor = detailVC.viewModel.color
        
        context.containerView.addSubview(bubble)

        UIView.animate(withDuration: 0.4, animations: {
            photosVC.view.alpha = 1.0
            bubble.frame = self.selectedCellImageFrame ?? bubble.frame
        }, completion: { success in
            detailVC.view.transform = CGAffineTransform.identity
            bubble.removeFromSuperview()
            context.completeTransition(!context.transitionWasCancelled)
        })
    }
}
