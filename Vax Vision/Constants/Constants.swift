//
//  Contatants.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 23/06/21.
//

import Foundation
import UIKit

struct K {
    struct StoryBoardID {
        static let MAIN = "Main"
    }
    struct SceneID {

    }
    
    struct SegueID{
        static let VACCINE_BOOK_TO_DETAILS = "vaccineBookToDetails"
        static let OTP_GENERATE_TO_VERIFICATION = "otpGenerateToVerification"
        static let OTP_VERIFICATION_TO_CERTIFICATE_DOWNLOADER = "otpVerificationToCertificateDownload"
    }
    
    struct XibWithName {
        static let VACCINATION_CENTER_DETAILS = "VaccinationCenterDetails"
    }
    
    struct TableViewCellID {
        static let VACCINATION_CENTER_DETAILS_CELL_ID = "VaccinationCenterDetailsCellID"
        static let CENTER_DETAILS_CELL_ID = "centerDetailsCell"
        static let DROP_DOWN_MENU_CELL_ID = "dropDownMenuCell"
    }
    
    struct Image {
        struct AssetImage{
           
        }
       
        struct SystemImage {
            
        }
    }
    
    struct Title {
        struct ButtonTitle {
            static let FREE = "Free"
            static let PIAD = "Paid"
        }
        struct TabBarItem {
            
        }
        
      
    }
    
    struct TextMessage {
        static let ERROR = "Error"
        static let DISMISS = "Dismiss"
        static let ALERT = "Alert"
        static let EMPTY_EMAIL_MESSAGE = "Email can't be empty"
        static let EMPTY_PASSWORD_MESSAGE = "Password can't be empty"
        static let EMPTY_MOBILE_NO_MESSAGE = "Mobile No. can't be empty"
        static let EMPTY_NAME_MESSAGE = "Name can't be empty"
        static let STATE_NOT_SELECTED = "Select a Sate then, select district"
        static let DISTRICT_NOT_SELECTED = "District not selected, Please Select it"
    }
    
    struct ErrorMessage {
        static let API_CALL_ERROR = "Error in API Call"
        static let NO_DATA_RECIEVED = "No Data Recieved"
        static let INVALID_RESPONSE = "Invalid Response Recieved"
        static let JSON_PARSING_ERROR = "Error while parsing JSON data"
        
    }
    
    struct Networking{
        struct HttpMethod {
            static let POST_METHOD = "post"
            static let GET_METHOD = "get"
        }
        struct HeaderFieldValue {
            static let CONTENT_TYPE = "content-type"
            static let BODY_DATA_TYPE_IS_JSON = "application/json"
        }
    }
    
    struct Array {
       
    }
    
    struct FilterParameters{
        static let FREE = "Free"
        static let PAID = "Paid"
        static let AGE_18_PLUS = "18"
        static let AGE_45_PLUS = "45"
        static let COVISHIELD = "COVISHIELD"
        static let COVAXIN = "COVAXIN"
    }
    
   
}
