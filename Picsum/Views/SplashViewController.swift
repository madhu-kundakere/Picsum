//
//  SplashViewController.swift
//  Picsum
//
//  Created by Madhu on 25/06/24.
//

import UIKit

class SplashViewController: UIViewController {
    let splashScreenDuration = 0.5
    override func viewDidLoad() {
        super.viewDidLoad()
        let splashImage = UIImageView(frame: self.view.frame)
        splashImage.image = UIImage(named: "splashImage")
        splashImage.contentMode = .scaleAspectFill
        view.addSubview(splashImage)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + splashScreenDuration) {
            self.navigateToPhotosView()
        }
    }

    private func navigateToPhotosView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let photosVc = storyboard.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
        photosVc.title = "Photos"
        navigationController?.pushViewController(photosVc, animated: true)
    }
}
