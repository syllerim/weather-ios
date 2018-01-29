//
//  DayForecastTableViewCell.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 25/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Kingfisher

public class DailyForecastTableViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    var item: DailyForecastViewModel?
    
    let containerView = UIView()
    let dayLabel = UILabel()
    let weatherImageView = UIImageView()
    let tempMinLabel = UILabel()
    let tempMaxLabel = UILabel()
    
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
        
        containerView.addSubview(dayLabel)

        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        dayLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true

        containerView.addSubview(tempMaxLabel)

        tempMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        tempMaxLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        tempMaxLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        tempMaxLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true

        containerView.addSubview(tempMinLabel)

        tempMinLabel.translatesAutoresizingMaskIntoConstraints = false
        tempMinLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        tempMinLabel.rightAnchor.constraint(equalTo: tempMaxLabel.leftAnchor, constant: -16).isActive = true
        tempMinLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true

        containerView.addSubview(weatherImageView)
        
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        weatherImageView.rightAnchor.constraint(equalTo: tempMinLabel.leftAnchor, constant: -16).isActive = true
        weatherImageView.contentMode = .scaleAspectFill
    }
    
    func configure(with viewModel: DailyForecastViewModel) {
        item = viewModel
        
        containerView.backgroundColor = viewModel.backgroundColor
        dayLabel.numberOfLines = 1
        dayLabel.textAlignment = .left
        dayLabel.attributedText = viewModel.dayOfTheWeekStringStyled
        
        if let image = viewModel.iconURL {
            weatherImageView.kf.setImage(with: image)
        }
        
        tempMinLabel.numberOfLines = 1
        tempMinLabel.textAlignment = .left
        tempMinLabel.attributedText = viewModel.tempMinStringStyled
        
        tempMaxLabel.numberOfLines = 1
        tempMaxLabel.textAlignment = .left
        tempMaxLabel.attributedText = viewModel.tempMaxStringStyled
    }
}
