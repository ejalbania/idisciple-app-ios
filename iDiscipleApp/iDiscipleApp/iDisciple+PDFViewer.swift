//
//  iDisciple+PDFViewer.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 22/05/2019.
//

import PDFKit

extension iDisciple {
  class PDFViewer: UIViewController {
    
    private let pdfUrl: URL
    private let document: PDFDocument!
    private let outline: PDFOutline?
    private var pdfView = PDFView()
    
    init(pdfUrl: URL) {
      self.pdfUrl = pdfUrl
      self.document = PDFDocument(url: pdfUrl)
      self.outline = document.outlineRoot
      pdfView.document = document
      super.init(nibName: nil, bundle: nil)
      self.pdfView.frame = self.view.frame
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
      self.view.addSubview(pdfView)
      self.view.backgroundColor = iDisciple.Color.blue.value
      self.pdfView.displayDirection = .horizontal
      self.pdfView.usePageViewController(true)
      self.pdfView.pageBreakMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      self.pdfView.maxScaleFactor = 3.0
      self.pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
      self.pdfView.autoScales = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(close))
    }
    
    @objc private func close() {
      self.navigationController?.dismiss(animated: true, completion: nil)
    }
  }
}
