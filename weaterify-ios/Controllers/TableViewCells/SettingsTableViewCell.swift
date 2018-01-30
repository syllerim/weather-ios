//
//  SettingsTableViewCell.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 30/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

public class SettingsTableViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    var item: SettingsViewModel?
    
    let containerView = UIView()
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        containerView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        
        containerView.addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        valueLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
    }
    
    func configure(with viewModel: SettingsViewModel) {
        item = viewModel

        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        titleLabel.attributedText = viewModel.titleLabelStyled
        
        valueLabel.numberOfLines = 1
        valueLabel.textAlignment = .right
        valueLabel.attributedText = viewModel.valueLabelStyled
    }
}
