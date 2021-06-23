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
        static let PROFILE_HOME_NOTIFICATION = "ProfileHomeNotification"
        static let MAIN = "Main"
    }
    struct SceneID {
        static let SIGNUP_SCENE = "signupScene"
        static let LOGIN_SCENE = "loginScene"
        static let PROFILE_HOME_NOTIFICATION_TAB_BAR = "profileHomeNotificationTabBarScene"
        static let HOME_SCENE = "homeScene"
        static let PROFILE_SCENE = "profileScene"
        static let NOTIFICATION_SCENE = "notificationsScene"
    }
    
    struct XibWithName {
        static let SIDE_MENU = "SideMenu"
        static let MENU_BUTTON_CELL = "MenuButtonCell"
    }
    
    struct TableViewCellID {
        static let MENU_BUTTON_CELL_ID = "menuButtonCellID"
        static let CENTER_DETAILS_CELL_ID = "centerDetailsCell"
    }
    
    struct Image {
        struct AssetImage{
            static let MALE_USER =  UIImage(named: "male-user")
            static let CLOSED_EYE_IMAGE = UIImage(named: "closedEye")
            static let OPEN_EYE_IMAGE = UIImage(named: "openEye")
            static let PROFILE_ICON = UIImage(named: "profile-icon")
            static let HOME_ICON = UIImage(named: "home-icon")
            static let NOTIFICATION_ICON = UIImage(named: "notification-icon")
        }
       
        struct SystemImage {
            static let LIST_DASH = UIImage(systemName:"list.dash")
        }
    }
    
    struct Title {
        struct ButtonTitle {
            static let BUTTON_ONE = "Button One"
            static let HOME = "Home"
            static let BUTTON_THREE = "Button Three"
            static let BUTTON_FOUR = "Button Four"
            static let LOGOUT_BUTTON = "Logout"
        }
        struct TabBarItem {
            static let PRFOFILE_TITLE = "Profile"
            static let HOME_TITLE = "Home"
            static let NOTIFICATION_TITLE = "Notifications"
        }
        
      
    }
    
    struct TextMessage {
        static let EMPTY_EMAIL_MESSAGE = "Email can't be empty"
        static let EMPTY_PASSWORD_MESSAGE = "Password can't be empty"
        static let EMPTY_MOBILE_NO_MESSAGE = "Mobile No. can't be empty"
        static let EMPTY_NAME_MESSAGE = "Name can't be empty"
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
        static let menuButtonTitleArr : [String] = [K.Title.ButtonTitle.BUTTON_ONE , K.Title.ButtonTitle.HOME, K.Title.ButtonTitle.BUTTON_THREE , K.Title.ButtonTitle.BUTTON_FOUR , K.Title.ButtonTitle.LOGOUT_BUTTON]
    }
    
   
}
