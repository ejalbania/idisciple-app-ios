//
//  DelegateTableViewCell.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 27/04/2019.
//

import UIKit

class DelegateTableViewCell: UITableViewCell {

    let screenSize = UIScreen.main.bounds
    var shouldSetupConstraints = true
    let imageDimension = CGFloat(70)
    
    lazy var cellBackgroundView : UIView = {
        
        //var vFrame = self.frame.insetBy(dx: 3.0, dy: 3.0)
        //let view = UIView(frame: vFrame)
        let view = UIView.newAutoLayout()
        view.autoSetDimensions(to: CGSize(width: screenSize.width - 20, height: 90))
        
        view.backgroundColor = .clear
        
        //view.layer.cornerRadius = 5.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        //view.layer.borderWidth = 1.0
        //view.center = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
        //view.backgroundColor = cellColorDefault
        
        return view
    }()
    
    lazy var delegateImageView : UIImageView = {
        
        var image = UIImageView(image: UIImage(named:""))
        image.autoSetDimensions(to: CGSize(width: imageDimension, height: imageDimension))
        image.backgroundColor = .darkGray
        
        image.contentMode = UIImageView.ContentMode.scaleToFill
        
        image.layer.masksToBounds = false
        image.layer.cornerRadius = imageDimension/2
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var nicknameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "Nickname"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Montserrat-Bold", size: 20)
        label.numberOfLines = 1
        return label
    }()
    
//    lazy var scheduleTimeLabel: UILabel = {
//        let label = UILabel.newAutoLayout()
//        //label.backgroundColor = .yellow
//        label.text = "0:00xx - 0:00xx"
//        label.textColor = .gray
//        label.textAlignment = .left
//        label.font = UIFont(name: "Montserrat-Bold", size: 16)
//        label.numberOfLines = 1
//        return label
//    }()
    
    lazy var completeNameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "Complete Name Here"
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 1
        return label
    }()
    
//    lazy var selectedWorkshopLabel: UILabel = {
//        let label = UILabel.newAutoLayout()
//        //label.backgroundColor = .yellow
//        label.text = "YOUR WORKSHOP"
//        label.textColor = .orange
//        label.textAlignment = .left
//        label.font = UIFont(name: "Montserrat-Bold", size: 16)
//        label.numberOfLines = 1
//        return label
//    }()
    
    lazy var leaderLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "Leader"
        label.textColor = .orange
        label.textAlignment = .left
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var starredButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.autoSetDimension(.height, toSize: 50)
        button.autoSetDimension(.width, toSize: 50)
        button.setImage(UIImage(named: "star_unselected"), for: .normal)
        //button.setImage(UIImage(named: "star_selected"), for: .highlighted)
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        //self.layer.borderColor = UIColor(red: 0/255, green: 84/255, blue: 151/255, alpha: 1).cgColor
        //self.layer.borderWidth = 0.5
        
        contentView.addSubview(cellBackgroundView)
        
        cellBackgroundView.addSubview(delegateImageView)
        
        cellBackgroundView.addSubview(nicknameLabel)
        cellBackgroundView.addSubview(leaderLabel)
        cellBackgroundView.addSubview(completeNameLabel)
        
        cellBackgroundView.addSubview(starredButton)
        starredButton.isHidden = true
        
        self.setNeedsUpdateConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //cellBackgroundView.appHelper.dropShadow1()
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            
            //debugPrint("GG")
            //cellBackgroundView.autoCenterInSuperview()
            cellBackgroundView.autoAlignAxis(toSuperviewAxis: .vertical)
            cellBackgroundView.autoAlignAxis(toSuperviewAxis: .horizontal)
            
            delegateImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
            delegateImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
            
            nicknameLabel.autoPinEdge(.bottom, to: .top, of: delegateImageView, withOffset: 35)
            nicknameLabel.autoPinEdge(.left, to: .right, of: delegateImageView, withOffset: 20)
            
            completeNameLabel.autoPinEdge(.top, to: .bottom, of: nicknameLabel, withOffset: 0)
            completeNameLabel.autoPinEdge(.left, to: .right, of: delegateImageView, withOffset: 20)
            completeNameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
            
            leaderLabel.autoPinEdge(.bottom, to: .top, of: delegateImageView, withOffset: 33)
            leaderLabel.autoPinEdge(.left, to: .right, of: nicknameLabel, withOffset: 10)
 
            starredButton.autoAlignAxis(toSuperviewAxis: .horizontal)
            starredButton.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
