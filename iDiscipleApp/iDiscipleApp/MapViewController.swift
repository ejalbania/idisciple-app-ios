//
//  MapViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 08/05/2019.
//

import UIKit
import Kingfisher

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mapView: MapView!
    
    var profileArray : [Profile] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.navigationController?.navigationBar.barTintColor = .black
        
        mapView = MapView(frame: CGRect.zero)
        self.view.addSubview(mapView)
        
        mapView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        self.navigationController?.navigationBar.barTintColor = .black
        mapView.backButton.addTarget(self, action: #selector(dismissMapView), for: .touchUpInside)
        mapView.legendButton.addTarget(self, action: #selector(showMapLegendTable), for: .touchUpInside)
        
        mapView.mapLegendTableView.delegate = self
        mapView.mapLegendTableView.dataSource = self
        mapView.mapLegendTableView.register(MapLegendTableViewCell.self, forCellReuseIdentifier: "MapLegendTableViewCell")
        
        mapView.mapLegendTableView.isHidden = true
        
        customizeNavigationBar()
    }
    
    func customizeNavigationBar(){
        
        let logoButton = UIBarButtonItem(image: UIImage(named: "logoIcon_white")?.withRenderingMode(.alwaysOriginal), style: .plain, target: navigationController, action: nil)
        logoButton.isEnabled = false
        navigationItem.leftBarButtonItem = logoButton
        
        let infoButton = UIBarButtonItem(image: UIImage(named: "infoIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        infoButton.isEnabled = false
        
        let data  = UserDefaults.standard.object(forKey: "userProfile") as! Data
        let loadedUser = NSKeyedUnarchiver.unarchiveObject(with: data) as! User
        
        //let tempImageView = UIImageView()
        let profile = profileArray.first(where: ({(profileSearch: Profile) -> Bool in
            return profileSearch.profileID == loadedUser.userID
        }))
        
        let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        
        profileImageView.backgroundColor = .darkGray
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = 35/2
        profileImageView.clipsToBounds = true
        
        if(profile != nil){
            let imageUrl = profile!.imagePath //+ profile!.imageName
            
            profileImageView.kf.indicatorType = .activity
            profileImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: imageUrl)!, cacheKey: imageUrl), placeholder: UIImage(named:"country_\(loadedUser.country)"))
        }else{
            profileImageView.image = UIImage(named:"country_\(loadedUser.country)")
        }
        
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openProfileView(sender:))))
        //let customProfileBarButton = createCustomButton(offset: 0, image: ((image?.withRenderingMode(.alwaysOriginal))!))
        //customProfileBarButton.addTarget(self, action: #selector(openProfileView(sender:)), for: .touchUpInside)
        
        let profileButton = UIBarButtonItem()
        profileButton.customView = profileImageView
        
        let currWidth = profileButton.customView?.widthAnchor.constraint(equalToConstant: 35)
        currWidth?.isActive = true
        let currHeight = profileButton.customView?.heightAnchor.constraint(equalToConstant: 35)
        currHeight?.isActive = true
        
        navigationItem.rightBarButtonItems = [profileButton, infoButton]
        
    }
    
    @objc func openProfileView(sender: UIBarButtonItem){
        
        DispatchQueue.main.async {
            let newViewController = YourProfileViewController()
            //self.navigationController?.modal(newViewController, animated: false)
            newViewController.modalPresentationStyle = .overFullScreen
            self.present(newViewController, animated: false, completion: nil)
        }
    }
    
    
    
    @IBAction func dismissMapView(sender: UIButton!){
        
        if(mapView.mapLegendTableView.isHidden){
            dismiss(animated: false, completion: nil)
        }else{
            mapView.mapLegendTableView.isHidden = true
        }
    }
    
    @IBAction func showMapLegendTable(sender: UIButton!){
        if(mapView.mapLegendTableView.isHidden){
            mapView.mapLegendTableView.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return GlobalConstant.mapDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MapLegendTableViewCell", for: indexPath) as! MapLegendTableViewCell
        
        //cell.moreOptionButton.addTarget(self, action: #selector(openPopover), for: .touchUpInside)
        cell.selectionStyle = .none
   
        if (!GlobalConstant.mapDataArray.isEmpty){
            let cellMapData = GlobalConstant.mapDataArray[indexPath.row]
            
            cell.areaCodeMarker.setTitle(cellMapData.areaCode, for: .normal)
            cell.areaNameLabel.text = cellMapData.areaName
            cell.areaDescriptionLabel.text = cellMapData.areaDescription
        }
        
        return cell
    }

}
