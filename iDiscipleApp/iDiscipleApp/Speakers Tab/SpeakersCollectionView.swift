//
//  SpeakersCollectionView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 16/01/2019.
//

import UIKit
import PureLayout

let cellReuseIdentifier = "SpeakerCollectionViewCell"

@objc protocol SpeakersCollectionViewDelegate {
    @objc optional func speakersCollectionDidSelect(_ speakersCollectionView: SpeakersCollectionView, indexPathRow: Int) -> Void
    //func customAlertDidPressDismiss(_ customAlert: CustomAlertController) -> Void
    //@objc optional func customAlertDidPressOk(_ customAlert: CustomAlertController) -> Void
}

class SpeakersCollectionView: UIView , UICollectionViewDataSource, UICollectionViewDelegate {
    
    var delegate : SpeakersCollectionViewDelegate?
    
    //modify
    lazy var speakerView : UICollectionView = {
        
        let cv = UICollectionView.newAutoLayout()
        cv.dataSource = self
        cv.delegate = self
        //cv.isPagingEnabled = true
        cv.backgroundColor = .red//UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        
        //cv.backgroundColor = UIColor.init(patternImage: UIImage(named: "grid_resize")!)
        
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.allowsMultipleSelection = false //true
        
        return cv
        
    }()
    
    let screenSize = UIScreen.main.bounds
    var shouldSetupConstraints = true
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = .blue
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.itemSize = CGSize(width: (screenSize.width/2 - 15), height: 250)
        
        let myCollectionView:UICollectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(SpeakersCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        myCollectionView.backgroundColor = .clear
        self.addSubview(myCollectionView)
        
        //self.createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            //NSLog("Constraints")
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let speakerCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! SpeakersCollectionViewCell
        //speakerCell.backgroundColor = .blue
        speakerCell.speakerNameLabel.text = "Donkey Courier"
        
        return speakerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        //SpeakersCollectionViewDelegate
        delegate?.speakersCollectionDidSelect!(self, indexPathRow: indexPath.row)
    }


}
