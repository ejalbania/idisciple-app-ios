//
//  ResourcesViewController.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 27/04/2019.
//

import UIKit

class ResourcesViewController: UIViewController {
  
  @IBOutlet private weak var resourcesTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = iDisciple.Color.blue.value
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.resourcesTableView.dataSource = self
    self.resourcesTableView.delegate = self
    
    self.setupTableView()
    
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print("viewWillDisappear")
  }
  
  func reloadTable() {
    self.resourcesTableView.reloadData()
  }
}

// Private functions
fileprivate extension ResourcesViewController {
  func setupTableView() {
    resourcesTableView.registerNib(cell: "MoreResourcesTableViewCell")
  }
}

// TableView Delegates and Datasource
extension ResourcesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoreResourcesTableViewCell") as? MoreResourcesTableViewCell else {
      return UITableViewCell()
    }
    
    if indexPath.row == 1 {
      cell
        .setResources(title: "We need morality to beat this hurricane of anger")
        .setResources(description: "There are calls for the Leader of the Opposition to likewise. A petition for a second referendum gathers millions of votes. There is talk of the United Kingdom splitting apart. The Tory succession campaign turns nasty.")
        .setResources(type: .pdf, fileSize: 5.23)
    }
    
    return cell
  }
}

extension ResourcesViewController: UITableViewDelegate {

}
