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
    var statesInfo = [State]()
    var districtsInfo = [District]()
    //var stateSelectStatus : isStateSelected
    var currentDropDown = dropDownSelected.none
    var stateID : Int?
    var districtID : Int?
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
        currentDropDown = .sate
        //get all the States to populate the DropDownList
        presenter.getStateList()
    }
    
    @IBAction func selectDistrictMenuButtonPressed(_ sender: UIButton) {
        selectedDropDownMenuButton = selectDistrictMenuButton
        currentDropDown = .district
        if let id = stateID{
            //get all the Districts to populate the dropDownList
            presenter.getDistrictList(forStateID: id)
        }else{
            presentAlert(title: "Alert", message: "Select a Sate then, select district")
        }
    }
    
    @IBAction func checkSlotsButtonPressed(_ sender: UIButton) {
        if let id = districtID{
            print(id)
        }
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
            districtsInfo = districtsData.districts
            addDropDownMenu(withFrame: selectStateMenuButton.frame)
        }
    }
    
    func presentStatesInDropDownList(statesData: States) {
        DispatchQueue.main.async { [self] in
            dataSource = []
            for i in 0...statesData.states.count-1{
                dataSource.append(statesData.states[i].stateName)
            }
            statesInfo = statesData.states
            addDropDownMenu(withFrame: selectStateMenuButton.frame)
        }
    }
    
    func presentAlert(title: String, message: String) {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true)
//            print("Error -> presentAlert From VaccineSlots")
            if stateID == nil{
                removeDropDownMenu()
            }
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
        if currentDropDown == .sate{
            stateID = statesInfo[indexPath.row].stateID
                //indexPath.row
        }
        if currentDropDown == .district{
            districtID = districtsInfo[indexPath.row].districtID
        }
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

enum dropDownSelected{
    case sate
    case district
    case none
}
