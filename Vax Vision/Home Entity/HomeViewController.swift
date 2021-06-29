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
    
    private var documentController : UIDocumentInteractionController!
  
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
        presenter.getImage()
    }
}

//MARK: - UIDocumentInteractionControllerDelegate functions
extension HomeViewController : UIDocumentInteractionControllerDelegate{
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}

//MARK: - Delegate Functions
extension HomeViewController : HomePresenterDelegate{
    func previewAndShareFile(atLocation: URL) {
        DispatchQueue.main.async { [self] in
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
