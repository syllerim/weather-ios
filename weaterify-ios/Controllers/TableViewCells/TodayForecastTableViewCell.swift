//
//  TodayForecastTableViewCell.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 29/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Kingfisher

public class TodayForecastTableViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    var item: TodayForecastViewModel?
    
    let containerView = UIView()
    let cityLabel = UILabel()
    let descriptionLabel = UILabel()
    let weatherImageView = UIImageView()
    let tempLabel = UILabel()
    let dayOfWeekLabel = UILabel()
    let dateLabel = UILabel()
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
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        containerView.addSubview(cityLabel)
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        cityLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        
        containerView.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8).isActive = true
        
        containerView.addSubview(dayOfWeekLabel)

        dayOfWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        dayOfWeekLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        dayOfWeekLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16).isActive = true

        containerView.addSubview(dateLabel)

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leftAnchor.constraint(equalTo: dayOfWeekLabel.rightAnchor, constant: 16).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16).isActive = true

        containerView.addSubview(tempMaxLabel)

        tempMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        tempMaxLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        tempMaxLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16).isActive = true

        containerView.addSubview(tempMinLabel)

        tempMinLabel.translatesAutoresizingMaskIntoConstraints = false
        tempMinLabel.rightAnchor.constraint(equalTo: tempMaxLabel.leftAnchor, constant: -16).isActive = true
        tempMinLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16).isActive = true

        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        weatherImageView.contentMode = .scaleAspectFill

        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 1).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [weatherImageView, tempLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 16.0

        containerView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
    
    func configure(with viewModel: TodayForecastViewModel) {
        item = viewModel

        containerView.backgroundColor = viewModel.backgroundColor
        cityLabel.attributedText = viewModel.cityStyled
        descriptionLabel.attributedText = viewModel.descriptionStyled
        tempLabel.attributedText = viewModel.temperatureStyled
        dayOfWeekLabel.attributedText = viewModel.dayOfWeekStyled
        dayOfWeekLabel.textAlignment = .left
        dateLabel.attributedText = viewModel.dateStyled
        dateLabel.textAlignment = .left
        tempMinLabel.attributedText = viewModel.tempMinStyled
        tempMinLabel.textAlignment = .right
        tempMaxLabel.attributedText = viewModel.tempMaxStyled
        tempMaxLabel.textAlignment = .right
        if let image = viewModel.iconURL {
            weatherImageView.kf.setImage(with: image)
        }
    }
}
