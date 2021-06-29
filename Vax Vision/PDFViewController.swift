//
//  PDFViewController.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 28/06/21.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {

    var pdfView = PDFView()
    var pdfUrl : URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //add PDF view
        self.view.addSubview(pdfView)
        if let document = PDFDocument(url: pdfUrl){
            pdfView.document = document
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            //self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
       pdfView.frame = self.view.frame
    }
    


}
