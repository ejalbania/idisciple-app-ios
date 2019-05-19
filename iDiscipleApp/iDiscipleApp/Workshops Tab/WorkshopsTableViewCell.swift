//
//  WorkshopsTableViewCell.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 29/01/2019.
//

import UIKit

class WorkshopsTableViewCell: UITableViewCell {
    
    let screenSize = UIScreen.main.bounds
    var shouldSetupConstraints = true
    
    lazy var cellBackgroundView : UIView = {
        
        //var vFrame = self.frame.insetBy(dx: 3.0, dy: 3.0)
        //let view = UIView(frame: vFrame)
        let view = UIView.newAutoLayout()
        view.autoSetDimensions(to: CGSize(width: screenSize.width - 20, height: 115))
        
        view.backgroundColor = .clear

        //view.layer.cornerRadius = 5.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        //view.center = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
        //view.backgroundColor = cellColorDefault
        
        return view
    }()
    
    lazy var workshopTitleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "Loooooooooooong Titled Workshop"
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        //label.layer.borderWidth = 1
        label.autoSetDimension(.height, toSize: 45)
        label.font = UIFont(name: "Montserrat-Bold", size: 20)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var facilitatorsNameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "Facilitator's Name"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var dateTimeLocationLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "Date Time/ Location"
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var selectedWorkshopLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "YOUR WORKSHOP"
        label.textColor = .orange
        label.textAlignment = .left
        label.font = UIFont(name: "Montserrat-Bold", size: 14)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var moreOptionButton: UIButton = {
        
        let button = UIButton.newAutoLayout()
        button.setImage((UIImage (named: "more_options")), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.autoSetDimensions(to: CGSize(width: 35, height: 35))
        //button.layer.borderWidth = 1;

        return button
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        //self.layer.borderColor = UIColor(red: 0/255, green: 84/255, blue: 151/255, alpha: 1).cgColor
        //self.layer.borderWidth = 0.5
        
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(workshopTitleLabel)
        cellBackgroundView.addSubview(facilitatorsNameLabel)
        cellBackgroundView.addSubview(dateTimeLocationLabel)
        
        cellBackgroundView.addSubview(selectedWorkshopLabel)
        cellBackgroundView.addSubview(moreOptionButton)
        moreOptionButton.isHidden = true
        
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
            
            //workshopTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            workshopTitleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            workshopTitleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
            workshopTitleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 5)
            //workshopTitleLabel.autoSetDimensions(to: CGSize(width: screenSize.width - 60, height: 50))
            
            //selectedWorkshopLabel.autoPinEdge(.top, to: .bottom, of: dateTimeLocationLabel, withOffset: 0)
            
            selectedWorkshopLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 5)
            selectedWorkshopLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            
//            if(selectedWorkshopLabel.isHidden){
//                dateTimeLocationLabel.autoPinEdge(.top, to: .bottom, of: workshopTitleLabel, withOffset: 30)
//                dateTimeLocationLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
//            }else{
//                dateTimeLocationLabel.autoPinEdge(.bottom, to: .top, of: selectedWorkshopLabel, withOffset: 0)
//                dateTimeLocationLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
//            }
            dateTimeLocationLabel.autoPinEdge(.bottom, to: .top, of: selectedWorkshopLabel, withOffset: 0)
            dateTimeLocationLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            
//            dateTimeLocationLabel.autoPinEdge(.bottom, to: .top, of: selectedWorkshopLabel, withOffset: 0)
//            dateTimeLocationLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            
            facilitatorsNameLabel.autoPinEdge(.bottom, to: .top, of: dateTimeLocationLabel, withOffset: 0)
            facilitatorsNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            
            moreOptionButton.autoPinEdge(toSuperviewEdge: .top, withInset: 5)
            moreOptionButton.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//    }

}
