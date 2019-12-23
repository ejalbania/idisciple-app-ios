//
//  DelegatesViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 27/04/2019.
//

import UIKit
import XLPagerTabStrip
import SwiftyJSON
import Kingfisher

class DelegatesViewController: DownloaderViewController, UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider {

    var delegatesView: DelegatesView!
    var itemInfo: IndicatorInfo = "View"
    
    var familyGroupArray : [FamilyGroup] = []
    var profileArray : [Profile] = []
    
    var searchProfileArray: [Profile] = []
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegatesView = DelegatesView(frame: CGRect.zero)
        self.view.addSubview(delegatesView)
        
        // AutoLayout
        delegatesView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
    
        delegatesView.delegatesSearchBar.delegate = self
        
        delegatesView.delegatesTableView.delegate = self
        delegatesView.delegatesTableView.dataSource = self
        delegatesView.delegatesTableView.register(DelegateTableViewCell.self, forCellReuseIdentifier: "DelegateTableViewCell")
        
        delegatesView.refreshControl.addTarget(self, action: #selector(reloadData(_:)), for: .valueChanged)
        
        loadDelegatesData()
    
    }
    
    func loadDelegatesData (){
        delegatesView.delegatesTableView.reloadData()
    }
    
    @objc private func reloadData(_ sender: Any) {
        // Reload data
        debugPrint("call reload here")
        
        self.reloadJsonData(onSuccess: { string in
            DispatchQueue.main.async {
                self.doneReloading()
            }
            
        }, onFailure: { error in
            debugPrint(error)
            self.doneReloading()
        })
    }
    
    func doneReloading() {
        
        self.delegatesView.refreshControl.endRefreshing()
        delegatesView.delegatesTableView.reloadData()
    }
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
     // MARK: - ScrollView
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegatesView.delegatesSearchBar.endEditing(true)
        //filterTableWithSearch(searchedText: "")
    }
    
    // MARK: - SearchBar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegatesView.delegatesSearchBar.endEditing(true)
        
        //do search here
        filterTableWithSearch(searchedText: delegatesView.delegatesSearchBar.text!)

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegatesView.delegatesSearchBar.text = ""
        delegatesView.delegatesSearchBar.endEditing(true)
        delegatesView.delegatesSearchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //debugPrint("Search Active")
        delegatesView.delegatesSearchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //debugPrint("Search Not Active")
        delegatesView.delegatesSearchBar.showsCancelButton = false
        delegatesView.delegatesTableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return delegatesView.delegatesSearchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool{
        return !searchBarIsEmpty()
    }
    
    func filterTableWithSearch(searchedText: String){
    
        searchProfileArray = profileArray.filter({ (search : Profile) -> Bool in
            return search.nickName.lowercased().contains(searchedText.lowercased()) || search.profileName.lowercased().contains(searchedText.lowercased())
        })
        delegatesView.delegatesTableView.reloadData()
    }
    
    // MARK: Tableview Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isFiltering()){
            return searchProfileArray.count
        }
        
        return profileArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DelegateTableViewCell", for: indexPath) as! DelegateTableViewCell
        
        cell.selectionStyle = .none
        
        if (!profileArray.isEmpty){
            
            let cellProfile : Profile
            if(isFiltering()){
                cellProfile = searchProfileArray[indexPath.row]
            }else {
                cellProfile = profileArray[indexPath.row]
            }
            
            cell.nicknameLabel.text = cellProfile.nickName
            
            let data  = UserDefaults.standard.object(forKey: "userProfile") as! Data
            let loadedUser = NSKeyedUnarchiver.unarchiveObject(with: data) as! User
            
            if(cellProfile.profileID == loadedUser.userID){
                cell.completeNameLabel.textColor = .orange
                cell.completeNameLabel.text = "That's You!"
            }else{
                cell.completeNameLabel.textColor = .gray
                cell.completeNameLabel.text = cellProfile.profileName
            }
            
            //check image
            if(cellProfile.imagePath.isEmpty && cellProfile.imageName.isEmpty){
                cell.delegateImageView.image = UIImage(named: "country_" + cellProfile.country)
            }else{
                let imageUrl = cellProfile.imagePath //+ cellProfile.imageName
                cell.delegateImageView.kf.indicatorType = .activity
                cell.delegateImageView.kf.setImage(with: ImageResource(downloadURL:URL(string: imageUrl)!, cacheKey: imageUrl), placeholder: UIImage(named: "country_" + cellProfile.country))
            }
            
            //check if fg
            let familyGroup = familyGroupArray.first(where: ({ (familyGroupSearch: FamilyGroup) -> Bool in
                return familyGroupSearch.familyGroupID == cellProfile.familyGroupID
            }))
            
            cell.leaderLabel.isHidden = true
            if(cellProfile.profileID == familyGroup?.familyGroupLeadID){
                cell.leaderLabel.isHidden = false
            }
        }
        
        return cell
    }
    
    
    // MARK: Tableview Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            let newViewController = DelegatesProfileViewController()
            
            if(self.isFiltering()){
                newViewController.delegateProfile = self.searchProfileArray[indexPath.row]
            }else{
                newViewController.delegateProfile = self.profileArray[indexPath.row]
            }
            //self.navigationController?.modal(newViewController, animated: false)
            newViewController.modalPresentationStyle = .overFullScreen
            self.present(newViewController, animated: false, completion: nil)
        }
    }
    
    
}
