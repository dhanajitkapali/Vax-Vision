//
//  ConstantsForNetworkManager.swift
//  Vax Vision
//
//  Created by unthinkable-mac-0025 on 23/07/21.
//

import Foundation

extension K{
    struct ErrorMessage {
        static let API_CALL_ERROR = "Error in API Call"
        static let NO_DATA_RECIEVED = "No Data Recieved"
        static let INVALID_RESPONSE = "Invalid Response Recieved"
        static let JSON_PARSING_ERROR = "Error while parsing JSON data"
        static let DOWNLOADING_WHILE_ERROR = "Error while downloading the file"
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
}
