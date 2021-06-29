//
//  ViewController.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 23/06/21.
//

import UIKit
import PDFKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var checkVaccineSlotsButton: UIButton!
    @IBOutlet private weak var downloadVaccineCertificateButton: UIButton!
    
    private var presenter : HomePresenter!
    
    var documentController : UIDocumentInteractionController!
    var pdfUrl : URL?
    var pdfView = PDFView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = HomePresenter(withDelegate : self)
        documentController = UIDocumentInteractionController()
        
        //add design to UI
        checkVaccineSlotsButton.layer.cornerRadius = 15.0
        downloadVaccineCertificateButton.layer.cornerRadius = 15.0
        
        
        
    }

    @IBAction func downloadVaccineCertificateButtonPressed(_ sender: UIButton) {
        
        presenter.getPDF()
    }
    
    
    
    @IBAction func downloadImage(_ sender: UIButton) {
//        self.view.addSubview(pdfView)
//        if let document = PDFDocument(url: pdfUrl!){
//            pdfView.document = document
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
//            //self.view.removeFromSuperview()
//        }
        
//        //load pdf in a new scene
//        let pdfView = PDFViewController()
//        pdfView.pdfUrl = self.pdfUrl
//        present(pdfView, animated: true, completion: nil)
        
        presenter.getImage()
    }
    
    func openPDF(atUrl : URL) {
        
    
        
        
//        print("going to open PDF downloaded")
//        DispatchQueue.main.async { [self] in
            
            //moving file
            //guard let url = downloadTask.originalRequest?.url else{ return }
//            let url = atUrl
//            let docsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
//            let destinationPath = docsPath.appendingPathComponent(url.lastPathComponent)
//
//            //remove the file from temp
//            try? FileManager.default.removeItem(at: destinationPath)
//
//            do{
//                try FileManager.default.copyItem(at: location, to: destinationPath)
//                self.pdfUrl = destinationPath
//                print("File Downloaded in location ->", self.pdfUrl ?? "NOT")
//
//            }catch let error {
//                print("Copy Error ->\(error.localizedDescription)")
//            }
//
//            //openeing file
//            self.view.addSubview(pdfView)
//            if let document = PDFDocument(url: pdfUrl!){
//                pdfView.document = document
//            }
//        }

    }
    
}



extension HomeViewController : UIDocumentInteractionControllerDelegate{
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}

//MARK: - Delegate Functions
extension HomeViewController : HomePresenterDelegate{
    func previewAndShareFile(atLocation: URL) {
        DispatchQueue.main.async { [self] in
            //let fileURL =  Bundle.main.path(forResource: "swift_tutorial", ofType: "pdf")
//            let fileUrl = try! String(contentsOf: atLocation)
//            documentController = UIDocumentInteractionController.init(url: URL.init(fileURLWithPath: fileUrl))
//            documentController.delegate = self
//            //documentController.uti = "pdf"
//            documentController.presentPreview(animated: true)
//            //documentController.presentOptionsMenu(from: self.downloadVaccineCertificateButton.frame, in: self.view, animated: true)
            
            
            documentController.url = atLocation
            documentController.delegate = self
            documentController.presentPreview(animated: true)
        }
        
      
    }
    
    func presentAlert(title: String, message: String) {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: K.TextMessage.DISMISS, style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    
    
}
