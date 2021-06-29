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

