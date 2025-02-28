//
//  BannerViewController.swift
//  SDKTest
//
//  Created by Hafiz Muhammad Junaid on 27/02/2025.
//

import UIKit

protocol BannerViewControllerDelegate: AnyObject {
    func didCloseTap()
}

class BannerViewController: UIViewController {

    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var bannerLabel: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    
    weak var delegate: BannerViewControllerDelegate?
    
    var bannerText: String = ""
    var bannerColor: UIColor = .clear
    var imageName = ""
    var showClose = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = self.bannerColor
        self.bannerLabel.text = bannerText
        if !imageName.isEmpty {
            self.bannerImage.image = UIImage(named: imageName)
        } else {
            self.bannerImage.isHidden = true
        }
        self.btnClose.isHidden = !self.showClose
    }
    
    @IBAction func closeTap(_ sender: Any) {
        print("Close Tap")
        self.delegate?.didCloseTap()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
