//
//  NewsTableViewCell.swift
//  newsApp
//
//  Created by Cassu on 13/01/21.
//  Copyright © 2021 Cassu. All rights reserved.
//

import SDWebImage
import SafariServices
import UIKit

class NewsTableViewCell: UITableViewCell {
    
    private let ivBanner: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.clipsToBounds = true
        iv.backgroundColor = .darkGray
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    private let lbTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 22)
        lb.textColor = .label
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.numberOfLines = 0
        return lb
    }()
    
    private let lbSubTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        lb.numberOfLines = 0
        lb.textColor = .darkGray
        return lb
    }()
    
    private let btSeeMore: UIButton = {
        
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        bt.setTitleColor(.systemBlue, for: .normal)
        bt.setTitle("See More", for: .normal)
        return bt
        
    }()
 
    private let lbDate: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        lb.numberOfLines = 1
        lb.textAlignment = .right
        lb.textColor = .lightGray
        return lb
    }()
    
    private var context = UIViewController()
    private var urlToSI: URL?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [ivBanner, lbTitle, lbSubTitle, lbDate, btSeeMore])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.distribution = .fill
            stack.axis = .vertical
            stack.spacing = 8
            return stack
        }()
        
        contentView.addSubview(stackView)
        
        ivBanner.heightAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(newVM: NewViewModel, ctx: UIViewController) {
        context = ctx
        lbTitle.text = newVM.title
        lbSubTitle.text = newVM.description
        lbDate.text = newVM.date
        guard let urlToDownImage = newVM.urlToImage else {
            ivBanner.isHidden = true
            return
        }
        
        ivBanner.sd_imageIndicator = SDWebImageActivityIndicator.white
        ivBanner.sd_setImage(with: urlToDownImage)
        
        guard let urlToShowNews = newVM.urlNews else {
            btSeeMore.isHidden = true
            return
        }
        urlToSI = urlToShowNews
        btSeeMore.addTarget(self, action: #selector(seeMoreAction(_:)), for: .touchUpInside)
    }
    
    @objc func seeMoreAction(_ sender: UIButton){
        let safariVC = SFSafariViewController(url: urlToSI!)
        context.present(safariVC, animated: true, completion: nil)
    }
}
