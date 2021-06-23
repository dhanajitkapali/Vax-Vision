//
//  VaccineSlotBookViewController.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 23/06/21.
//

import UIKit

class VaccineSlotBookViewController: UIViewController {

    @IBOutlet var selectStateMenuButton: UIButton!
    @IBOutlet var selectDistrictMenuButton: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var checkSlotsButton: UIButton!
    
    let transparentView = UIView()
    let dropDownMenuTableView = UITableView()
    var selectedDropDownMenuButton = UIButton()
    
    var dataSource = [String]()
    //var stateSelectStatus : isStateSelected
    var stateID : Int?
    private var presenter : VaccineSlotBookPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting self delegate of presenter
        presenter = VaccineSlotBookPresenter(withDelegate : self)
        
        //initializing the enum variables
        //stateSelectStatus = .notSelected

        //setting delegate and dataSorce of tableViews
        dropDownMenuTableView.delegate = self
        dropDownMenuTableView.dataSource = self
        dropDownMenuTableView.register(UITableViewCell.self, forCellReuseIdentifier: "dropDownMenuCell")
    }
    
    @IBAction func selectStateMenuButtonPressed(_ sender: UIButton) {
        selectedDropDownMenuButton = selectStateMenuButton
        
        //get all the States to populate the DropDownList
        presenter.getStateList()
    }
    
    @IBAction func selectDistrictMenuButtonPressed(_ sender: UIButton) {
        selectedDropDownMenuButton = selectDistrictMenuButton
        
        if let id = stateID{
            print(id)
            presenter.getDistrictList(forStateID: id)
        }
        //get all the Districts to populate the dropDownList
    
        addDropDownMenu(withFrame: selectDistrictMenuButton.frame)
    }
    
    @IBAction func checkSlotsButtonPressed(_ sender: UIButton) {
        
    }
    
}

//MARK: - Presenter functions
extension VaccineSlotBookViewController : VaccineSlotBookPresenterDelegate{
    func presentDistrictsInDropDownList(districtsData: Districts) {
        DispatchQueue.main.async { [self] in
            dataSource = []
            for i in 0...districtsData.districts.count-1{
                dataSource.append(districtsData.districts[i].districtName)
            }
            addDropDownMenu(withFrame: selectStateMenuButton.frame)
        }
    }
    
    func presentStatesInDropDownList(statesData: States) {
        DispatchQueue.main.async { [self] in
            dataSource = []
            for i in 0...statesData.states.count-1{
                dataSource.append(statesData.states[i].stateName)
            }
            addDropDownMenu(withFrame: selectStateMenuButton.frame)
        }
    }
    
    func presentAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            //present(alert, animated: true)
            print("Error -> presentAlert From VaccineSlots")
        }
    }
}

extension VaccineSlotBookViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dropDownMenuTableView.dequeueReusableCell(withIdentifier: "dropDownMenuCell" , for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDropDownMenuButton.setTitle(dataSource[indexPath.row], for: .normal)
        stateID = indexPath.row 
        removeDropDownMenu()
    }
}

//MARK: - DropDownMenu
extension VaccineSlotBookViewController {
    func addDropDownMenu(withFrame : CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        //setting the frames of tableView used for DropDownMenu, setting height = 0 initially
        dropDownMenuTableView.frame = CGRect(x: withFrame.origin.x, y: withFrame.origin.y + withFrame.height, width: withFrame.width, height: 0)
        self.view.addSubview(dropDownMenuTableView)
        dropDownMenuTableView.layer.cornerRadius = 5.0
        dropDownMenuTableView.reloadData()
        
        //remove the Menu on tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeDropDownMenu))
        transparentView.addGestureRecognizer(tapGesture)
        
        //adding animation for appearance of DropDownMenu
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.transparentView.alpha = 0.9
            self.dropDownMenuTableView.frame = CGRect(x: withFrame.origin.x + 5, y: withFrame.origin.y + withFrame.height, width: withFrame.width, height: CGFloat(self.dataSource.count * 45))
        } completion: { (done) in
            if(done){
                
            }
        }

    }
    
    @objc func removeDropDownMenu(){
        let withFrame = selectedDropDownMenuButton.frame
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.transparentView.alpha = 0
            self.dropDownMenuTableView.frame = CGRect(x: withFrame.origin.x, y: withFrame.origin.y + withFrame.height, width: withFrame.width, height: 0)
        } completion: { (done) in
            if(done){
                
            }
        }
    }
}

//MARK: - Enums
enum isStateSelected {
    case selected
    case notSelected
}
