//
//  InformationViewController.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 29/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import UIKit
import RxSwift

final class InformationViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UILabel!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        configureScrollView(viewModel: InformationViewModel())
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9724436402, green: 0.972609818, blue: 0.9724331498, alpha: 1)
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icn-back"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(InformationViewController.showDashboardViewController))
        navigationItem.title = "Information"
    }
   
    @objc func showDashboardViewController() {
        mainStore.dispatch(App.Actions.changeRoute(.dashboard))
    }
    
    func configureScrollView(viewModel: InformationViewModel) {
        footerView.backgroundColor = viewModel.backgroundColor
        logoImageView.image = viewModel.logo
        descriptionTextView.attributedText = viewModel.descriptionStyled
        descriptionTextView.numberOfLines = 0
        descriptionTextView.textAlignment = .left
        versionLabel.attributedText = viewModel.versionStyled
        
        let width: CGFloat = view.bounds.size.width - 32
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = descriptionTextView.attributedText?.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        if let height = boundingBox?.size.height {
            if (height + 242 > view.frame.size.height) {
                viewHeightConstraint.constant = height + 242
            }
            else {
                viewHeightConstraint.constant = view.bounds.size.height - 64
            }
        }
    }
}
