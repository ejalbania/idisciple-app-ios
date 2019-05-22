//
//  ResourcesViewController.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 27/04/2019.
//

import UIKit
import Alamofire
import WebKit

class ResourcesViewController: UIViewController {
  
  @IBOutlet private weak var resourcesTableView: UITableView!
  private var resources = ResourcesRepository()
  fileprivate var resources_onQueue: [ResourceModel] = []
  @IBOutlet weak var searchTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.resources_onQueue = self.resources.list
    self.searchTextField.delegate = self
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
  
  func openPDF(from url: URL, name: String) {
    let dirPath = FileManager.createDirectory(folder: "PDFResources/")
    let fileName = url.lastPathComponent
    
    guard let fileDestination = dirPath?.appendingPathComponent(fileName) else {
        return
    }
    
    if FileManager.default.fileExists(atPath: fileDestination.absoluteString) {
      let nav = UINavigationController()
        .setRoot(viewController:
          iDisciple.PDFViewer(pdfUrl: fileDestination).set(title: name.uppercased())
      )
      
      self.present(nav, animated: true, completion: nil)
    } else {
      self.downloadFile(from: url, filePath: fileDestination)
    }
  }
  
  func downloadFile(from url: URL, filePath destination: URL) {
    Alamofire
      .download(url, to: { _ , origin -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
        return  (destinationURL: destination, options: [.removePreviousFile, .createIntermediateDirectories])
      })
      .response { response in
        if response.error == nil {
          guard let tempFileURL = response.destinationURL else {
            return
          }
          let nav = UINavigationController()
            .setRoot(viewController: iDisciple.PDFViewer(pdfUrl: tempFileURL))
          
          self.present(nav, animated: true, completion: nil)
        } else {
          
        }
    }
  }
}

// TableView Delegates and Datasource
extension ResourcesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.resources_onQueue.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoreResourcesTableViewCell") as? MoreResourcesTableViewCell
      else {
        return UITableViewCell()
    }
    
    let resource = self.resources_onQueue[indexPath.row]
    
    cell.set(resource: resource)
    
    return cell
  }
}

extension ResourcesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    guard let cell = tableView.cellForRow(at: indexPath) as? MoreResourcesTableViewCell else {
      return
    }
    let urlString = cell.url
    guard let url = URL(string: urlString) else {
      return
    }
    
    switch cell.mediaType {
    case .pdf:
      self.openPDF(from: url, name: cell.resource_name)
    case .video:
      guard let youtubePlayer = iDisciple.Story.more.viewController(with: "iDiscipleYouTubePlayer") as? iDiscipleYouTubePlayer else {
        return
      }
      let nav = UINavigationController()
      .setRoot(viewController: youtubePlayer.setVideo(code: url.lastPathComponent))
      self.present(nav, animated: true, completion: nil)
    default: break
    }
  }
}

extension ResourcesViewController: UITextFieldDelegate {
  
  
  
}

class iDiscipleYouTubePlayer: UIViewController {
  
  fileprivate var webView = WKWebView(frame: .zero, configuration:  WKWebViewConfiguration())
  fileprivate var activityLoader = UIActivityIndicatorView()
  fileprivate var link: String = ""
  @IBOutlet weak var embededVideoKit: WKWebView!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.view.backgroundColor = iDisciple.Color.green.value
    
    guard let url = URL(string: link) else {
      return
    }
    let request = URLRequest(url: url)
    self.embededVideoKit.load(request)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(close))
  }
  
  @objc private func close() {
    self.navigationController?.dismiss(animated: true, completion: nil)
  }
  
  @discardableResult
  func setVideo(code: String) -> Self {
    let baseYouTube = "https://www.youtube.com/embed/"
    self.link = "\(baseYouTube)\(code)"
    return self
  }
}

