//
//  Home Presenter.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 29/06/21.
//

import Foundation


protocol HomePresenterDelegate : AnyObject{
    func presentAlert(title: String, message: String)
    func previewAndShareFile(atLocation : URL)
}

class HomePresenter{
    weak var delegate : HomePresenterDelegate!
    
    init(withDelegate : HomePresenterDelegate) {
        self.delegate = withDelegate
    }
    
    public func getPDF() {
        //to download the PDF
//        guard let url = URL(string: "https://www.tutorialspoint.com/swift/swift_tutorial.pdf") else {return}
//        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
//        let task = urlSession.downloadTask(with: url)
//        task.resume()
        
        //using the func from Networking
        guard let url = URL(string: "https://www.tutorialspoint.com/swift/swift_tutorial.pdf") else {return}
        NetworkManager().storeAndShare(url: url, fileName: url.lastPathComponent) { (result) in
            switch result{
            case .success(let downloadedFiledUrl):
                self.delegate.previewAndShareFile(atLocation: downloadedFiledUrl)
                print(downloadedFiledUrl)
            case .failure(let error):
                self.delegate.presentAlert(title: K.TextMessage.ERROR, message: error.localizedDescription)
            }
        }
    } //:getPDF()
    
    public func getImage(){
        //using the func from Networking
        guard let url = URL(string: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png") else {return}
        NetworkManager().storeAndShare(url: url, fileName: url.lastPathComponent) { (result) in
            switch result{
            case .success(let downloadedFiledUrl):
                self.delegate.previewAndShareFile(atLocation: downloadedFiledUrl)
                print(downloadedFiledUrl)
            case .failure(let error):
                self.delegate.presentAlert(title: K.TextMessage.ERROR, message: error.localizedDescription)
            }
        }
    } //:getImage()
}

//MARK: - Methods for downloading PDF
extension HomeViewController : URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("File Downloaded in location ->", location)
    
        
        guard let url = downloadTask.originalRequest?.url else{ return }
        let docsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let destinationPath = docsPath.appendingPathComponent(url.lastPathComponent)

        //remove the file from temp
        try? FileManager.default.removeItem(at: destinationPath)

        do{
            try FileManager.default.copyItem(at: location, to: destinationPath)
            self.pdfUrl = destinationPath
            print("File Downloaded in location ->", self.pdfUrl ?? "NOT")

        }catch let error {
            print("Copy Error ->\(error.localizedDescription)")
        }
        
    }
}
