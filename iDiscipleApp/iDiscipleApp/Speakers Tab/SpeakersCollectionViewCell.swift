//
//  SpeakersCollectionViewCell.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 16/01/2019.
//

import UIKit
import PureLayout

class SpeakersCollectionViewCell: UICollectionViewCell {
    
    let screenSize = UIScreen.main.bounds
    var shouldSetupConstraints = true
    let imageDimension = CGFloat(100)

    lazy var cellBackgroundView : UIView = {
        
        var vFrame = self.frame.insetBy(dx: 3.0, dy: 3.0)
        let view = UIView(frame: vFrame)
        //let view = UIView.newAutoLayout()
        
        view.backgroundColor = .clear
        
        view.layer.cornerRadius = 5.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        view.center = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
        
        //view.backgroundColor = cellColorDefault
        
        return view
    }()
    
    lazy var speakerImageView : UIImageView = {
        
        //var image = UIImageView(frame: CGRect(x: cellBackgroundView.frame.width/2 - (imageDimension/2), y: 20, width: imageDimension, height: imageDimension))
        
        var image = UIImageView(image: UIImage(named: "courier"))
        image.autoSetDimensions(to: CGSize(width: imageDimension, height: imageDimension))
        image.backgroundColor = .darkGray

        image.layer.masksToBounds = false
        image.layer.cornerRadius = imageDimension/2
        image.clipsToBounds = true
        
        return image
    }()
    
     lazy var speakerNameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "Speaker's Name Here"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 24)
        label.numberOfLines = 2
        return label
    }()
    
     lazy var plenaryTopicLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .blue
        label.text = "Plenary Topic"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        label.numberOfLines = 2
        return label
    }()
    
     lazy var dateAndTimeLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .red
        label.text = "Date and Time"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.addSubview(self.cellBackgroundView)
        
        cellBackgroundView.addSubview(speakerImageView)
        cellBackgroundView.addSubview(speakerNameLabel)
        cellBackgroundView.addSubview(plenaryTopicLabel)
        cellBackgroundView.addSubview(dateAndTimeLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            
            //speakerImageView.autoSetDimensions(to: CGSize(width: 100.0, height: 100.0))
            speakerImageView.autoAlignAxis(toSuperviewAxis: .vertical)
            speakerImageView.autoPinEdge(.bottom, to: .top, of: cellBackgroundView, withOffset: CGFloat(imageDimension + 10))
            
            speakerNameLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            speakerNameLabel.autoPinEdge(.top, to: .bottom, of: speakerImageView, withOffset: 0)
            speakerNameLabel.autoSetDimensions(to: CGSize(width: cellBackgroundView.frame.width - 40, height: 70))
            
            plenaryTopicLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            plenaryTopicLabel.autoPinEdge(.top, to: .bottom, of: speakerNameLabel, withOffset: 0)
            plenaryTopicLabel.autoSetDimensions(to: CGSize(width: cellBackgroundView.frame.width - 40, height: 20))
            
            dateAndTimeLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            dateAndTimeLabel.autoPinEdge(.top, to: .bottom, of: plenaryTopicLabel, withOffset: 5)
            dateAndTimeLabel.autoSetDimensions(to: CGSize(width: cellBackgroundView.frame.width - 40, height: 20))

        }
        super.updateConstraints()
    }
    
}
