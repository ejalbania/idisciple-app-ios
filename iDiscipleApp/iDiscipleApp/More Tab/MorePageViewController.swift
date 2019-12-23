//
//  MorePageViewController.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 01/05/2019.
//

import UIKit

protocol MorePageViewControllerDelegate {
  func morePage(newIndex index: Int, new viewController: UIViewController)
}

class MorePageViewController: UIPageViewController {
  
  var morePageDelegate: MorePageViewControllerDelegate?
  var pageCount: Int { return tabs.count }
  private let story = iDisciple.Story.more
  fileprivate lazy var tabs: [UIViewController] =
    self.getViewControllers(identifiers:
      [ "More_resourcesViewController",
//        "More_socialViewController",
        "More_aboutViewController" ]
  )
  
  private var current: (index: Int, viewController: UIViewController)? {
    guard let newViewController = self.viewControllers?.first,
      let index = tabs.firstIndex(of: newViewController) else {
        return nil
    }
    return (index, newViewController)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.dataSource = self
    self.delegate = self
    
    guard let firstViewController = tabs.first else { return }
    
    self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    self.refreshTableViews()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  private func getViewControllers(identifiers: [String]) -> [UIViewController] {
    var viewControllers = [UIViewController]()
    
    identifiers.forEach {
      viewControllers.append(self.story.viewController(with: $0))
    }
    
    return viewControllers
  }
  
  func refreshTableViews() {
    guard let resourcesViewController = (self.tabs.filter{ $0 is ResourcesViewController }.first) as? ResourcesViewController else {
      return
    }
    
    resourcesViewController.reloadTable()
  }
}

extension MorePageViewController: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let index = self.tabs.firstIndex(of: viewController) else { return nil }
    
    return (index-- < 0) ? nil: self.tabs[index--]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let index = self.tabs.firstIndex(of: viewController) else { return nil }
    
    return (index++ >=  self.pageCount) ? nil: self.tabs[index++]
  }
}

extension MorePageViewController: UIPageViewControllerDelegate {
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    
    guard let delegate = self.morePageDelegate,
      let newViewController = self.current?.viewController,
      let index = self.current?.index else {
      return
    }
    delegate.morePage(newIndex: index, new: newViewController)
  }
}

// Builder functions
extension MorePageViewController {
  @discardableResult
  func flipToPage(index: Int) -> Self {
    guard let currentIndex = self.current?.index,
      index != currentIndex,
      index <= tabs.count, index >= 0 else {
      return self
    }
    
    let direction: UIPageViewController.NavigationDirection = index > currentIndex ? .forward: .reverse
    let pages = (index > currentIndex ? currentIndex...index : index...currentIndex)
      .sorted { direction == .forward ? $0 < $1: $0 > $1 }
    
    for page in pages {
      let newViewController = self.tabs[page]
      self.setViewControllers([newViewController], direction: direction, animated: true, completion: nil)
      morePageDelegate?.morePage(newIndex: page, new: newViewController)
    }
    
    return self
  }
}
