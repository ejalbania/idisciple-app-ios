//
//  DashboardButton.swift
//  iDiscipleApp
//
//  Created by PCCWS User2 on 15/10/2018.
//

import UIKit

class DashboardButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    lazy var dashButtonImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        
        return view
    }()
    
    lazy var dashButtonLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 14)
        label.numberOfLines = 1
        label.textColor = .white
        
        return label
    }()
    
    
    var shouldSetupConstraints = true
    let screenSize = UIScreen.main.bounds
    
    let imageViewHeight = 40
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    
        self.addSubview(dashButtonImageView)
        self.addSubview(dashButtonLabel)
        
        dashButtonImageView.contentMode = .scaleAspectFill
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {

            dashButtonImageView.autoSetDimensions(to: CGSize(width: imageViewHeight, height: imageViewHeight))
            dashButtonImageView.autoAlignAxis(toSuperviewAxis: .vertical)
            dashButtonImageView.autoPinEdge(.bottom, to: .top, of: self, withOffset: CGFloat(imageViewHeight + 15))
            
            dashButtonLabel.autoPinEdge(.top, to: .bottom, of: dashButtonImageView, withOffset: 10)
            dashButtonLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }


}
