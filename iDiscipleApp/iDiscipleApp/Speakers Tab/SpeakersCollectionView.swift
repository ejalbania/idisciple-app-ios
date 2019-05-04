//
//  SpeakersCollectionView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 16/01/2019.
//

import UIKit
import PureLayout
import Kingfisher

let cellReuseIdentifier = "SpeakerCollectionViewCell"

@objc protocol SpeakersCollectionViewDelegate {
    @objc optional func speakersCollectionDidSelect(_ speakersCollectionView: SpeakersCollectionView, indexPathRow: Int) -> Void
    //func customAlertDidPressDismiss(_ customAlert: CustomAlertController) -> Void
    //@objc optional func customAlertDidPressOk(_ customAlert: CustomAlertController) -> Void
}

class SpeakersCollectionView: UIView , UICollectionViewDataSource, UICollectionViewDelegate {
    
    var delegate : SpeakersCollectionViewDelegate?
    var speakerArray : [Speaker] = []
    
    lazy var speakersCV = UICollectionView()
    let screenSize = UIScreen.main.bounds
    var shouldSetupConstraints = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = .blue
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.itemSize = CGSize(width: (screenSize.width/2 - 15), height: 250)
        
        speakersCV = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        speakersCV.dataSource = self
        speakersCV.delegate = self
        speakersCV.register(SpeakersCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        speakersCV.backgroundColor = .clear
        self.addSubview(speakersCV)
        
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
    
    func reloadCollectionView(loadedArray: [Speaker]){
        
        speakerArray.removeAll()
        speakerArray = loadedArray
        
        speakersCV.reloadData()
        
        //speakerView.isHidden = false
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if speakerArray.isEmpty{
            return 0
        }
        else{
            return speakerArray.count

        }
        //return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let speakerCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! SpeakersCollectionViewCell
        //speakerCell.backgroundColor = .blue
        if (!speakerArray.isEmpty){
            let cellSpeaker = speakerArray[indexPath.row]
            
            let imageUrl = cellSpeaker.imagePath + cellSpeaker.imageName
            speakerCell.speakerImageView.kf.indicatorType = .activity
            speakerCell.speakerImageView.kf.setImage(with: ImageResource(downloadURL:URL(string: imageUrl)!, cacheKey: imageUrl))
            speakerCell.speakerNameLabel.text = cellSpeaker.name
            speakerCell.plenaryTopicLabel.text = cellSpeaker.plenaryTitle
            speakerCell.dateAndTimeLabel.text = cellSpeaker.plenaryDate + " " + cellSpeaker.plenaryTime
        }
        
        return speakerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        //SpeakersCollectionViewDelegate
        delegate?.speakersCollectionDidSelect!(self, indexPathRow: indexPath.row)
    }


}
