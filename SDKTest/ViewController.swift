//
//  ViewController.swift
//  SDKTest
//
//  Created by Hafiz Muhammad Junaid on 27/02/2025.
//

import UIKit

enum AnimationOption {
    case top
    case bottom
    case left
    case right
    case none
}

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var xPosTextField: UITextField!
    @IBOutlet weak var yPosTextField: UITextField!
    @IBOutlet weak var widthTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var dismissTimeTextField: UITextField!
    
    private var selectedColor: UIColor = .clear
    private var bannerVC: BannerViewController?
    private var selectedImage = ""
    private var selectedAnimationOption = AnimationOption.none
    private var autoDismiss = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissTimeTextField.isHidden = true
    }

    @IBAction func redButton(_ sender: Any) {
        selectedColor = .red
    }
    
    @IBAction func greenButton(_ sender: Any) {
        selectedColor = .green
    }
    
    @IBAction func blueButton(_ sender: Any) {
        selectedColor = .blue
    }
    
    @IBAction func image1Tap(_ sender: Any) {
        selectedImage = "image1"
    }
    
    @IBAction func image2Tap(_ sender: Any) {
        selectedImage = "image2"
    }
    
    @IBAction func topAction(_ sender: Any) {
        selectedAnimationOption = .top
    }
    
    @IBAction func bottomAction(_ sender: Any) {
        selectedAnimationOption = .bottom
    }
    
    @IBAction func leftAction(_ sender: Any) {
        selectedAnimationOption = .left
    }
    
    
    @IBAction func rightAction(_ sender: Any) {
        selectedAnimationOption = .right
    }
    
    @IBAction func autoDismissTap(_ sender: Any) {
        autoDismiss = true
        dismissTimeTextField.isHidden = false
    }
    
    @IBAction func showDismissTap(_ sender: Any) {
        autoDismiss = false
        dismissTimeTextField.isHidden = true
    }
    
    @IBAction func showBannerTap(_ sender: Any) {
        self.bannerVC?.view.removeFromSuperview()
        self.bannerVC?.removeFromParent()
        self.bannerVC = nil
        if let bannerVC = self.storyboard?.instantiateViewController(identifier: "BannerViewController") as? BannerViewController {
            self.bannerVC = bannerVC
            self.bannerVC?.delegate = self
            bannerVC.bannerText = textField.text ?? ""
            bannerVC.bannerColor = selectedColor
            bannerVC.imageName = self.selectedImage
            bannerVC.showClose = !self.autoDismiss
            
            self.bannerVC?.view = bannerVC.view!
            let xPos = CGFloat(Double(xPosTextField.text!) ?? 20)
            let yPos = CGFloat(Double(yPosTextField.text!) ?? 20 )
            let width = CGFloat(Double(widthTextField.text!) ?? 100)
            let height = CGFloat(Double(heightTextField.text!) ?? 100)
            
            switch selectedAnimationOption {
            case .top:
                self.bannerVC?.view.frame = CGRect(x: xPos, y: 0, width: width, height: height)
            case .bottom:
                self.bannerVC?.view.frame = CGRect(x: xPos, y: self.view.frame.height, width: width, height: height)
            case .left:
                self.bannerVC?.view.frame = CGRect(x: 0, y: yPos, width: width, height: height)
            case .right:
                self.bannerVC?.view.frame = CGRect(x: self.view.frame.width, y: yPos, width: width, height: height)
            case .none:
                self.bannerVC?.view.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
            }
            
            
            self.view.addSubview(self.bannerVC!.view)
            
            if selectedAnimationOption != .none {
                UIView.animate(withDuration: 1) {
                    self.bannerVC?.view.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
                }
            }
            
            
            if autoDismiss {
                let dimissTime = Double(dismissTimeTextField.text ?? "1") ?? 1
                DispatchQueue.main.asyncAfter(deadline: .now() + dimissTime, execute: {
                    self.bannerVC?.view.removeFromSuperview()
                    self.bannerVC?.removeFromParent()
                    self.bannerVC = nil
                })
            }
        }
    }
}

extension ViewController: BannerViewControllerDelegate {
    func didCloseTap() {
        self.bannerVC?.view.removeFromSuperview()
        self.bannerVC?.removeFromParent()
        self.bannerVC = nil
    }
}
