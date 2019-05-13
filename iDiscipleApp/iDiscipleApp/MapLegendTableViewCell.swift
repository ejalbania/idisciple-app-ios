//
//  MapLegendTableViewCell.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 09/05/2019.
//

import UIKit

class MapLegendTableViewCell: UITableViewCell {
    
    let screenSize = UIScreen.main.bounds
    var shouldSetupConstraints = true
    let imageDimension = CGFloat(50)
    
    lazy var cellBackgroundView : UIView = {
        
        //var vFrame = self.frame.insetBy(dx: 3.0, dy: 3.0)
        //let view = UIView(frame: vFrame)
        let view = UIView.newAutoLayout()
        view.autoSetDimensions(to: CGSize(width: screenSize.width - 20, height: 60))
        
        view.backgroundColor = .clear
        
        //view.layer.cornerRadius = 5.0
        //view.layer.borderColor = UIColor.lightGray.cgColor
        //view.layer.borderWidth = 1.0
        //view.center = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
        //view.backgroundColor = cellColorDefault
        
        return view
    }()
    
    lazy var areaCodeMarker : UIButton = {
        let button = UIButton(type: .custom)
        button.autoSetDimensions(to: CGSize(width: imageDimension, height: imageDimension))
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 18)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(UIImage(named: "rectangle"), for: .disabled)
        button.isEnabled = false
        
        return button
    }()
    
    lazy var areaNameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "Area Name"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 1
        return label
    }()
    
    
    lazy var areaDescriptionLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = ""
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont(name: "Montserrat-Bold", size: 12)
        label.numberOfLines = 1
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        //self.layer.borderColor = UIColor(red: 0/255, green: 84/255, blue: 151/255, alpha: 1).cgColor
        //self.layer.borderWidth = 0.5
        
        contentView.addSubview(cellBackgroundView)
        
        cellBackgroundView.addSubview(areaCodeMarker)

        cellBackgroundView.addSubview(areaNameLabel)
        cellBackgroundView.addSubview(areaDescriptionLabel)
        
        self.setNeedsUpdateConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            
            //debugPrint("GG")
            //cellBackgroundView.autoCenterInSuperview()
            cellBackgroundView.autoAlignAxis(toSuperviewAxis: .vertical)
            cellBackgroundView.autoAlignAxis(toSuperviewAxis: .horizontal)
            
            areaCodeMarker.autoAlignAxis(toSuperviewAxis: .horizontal)
            areaCodeMarker.autoPinEdge(toSuperviewEdge: .left, withInset: 20)

            areaNameLabel.autoPinEdge(.bottom, to: .top, of: areaCodeMarker, withOffset: 30)
            areaNameLabel.autoPinEdge(.left, to: .right, of: areaCodeMarker, withOffset: 20)

            areaDescriptionLabel.autoPinEdge(.top, to: .bottom, of: areaNameLabel, withOffset: 0)
            areaDescriptionLabel.autoPinEdge(.left, to: .right, of: areaCodeMarker, withOffset: 20)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
