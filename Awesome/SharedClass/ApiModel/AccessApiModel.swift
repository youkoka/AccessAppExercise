//
//  AccessApiModel.swift
//  Awesome
//
//  Created by colt on 2019/12/2.
//  Copyright © 2019 colt. All rights reserved.
//

import UIKit

class AccessApiModel: BaseApiModel {

    class func getUIList(since:Int, _ complete: @escaping (Int, Data?, String?)->Void) {
        
        let parmeter = ["since":since]
        
        NetworkUtils.requestGet("\(domain)/users", nil, parmeter) { (success, statusCode, data, errorMsg) in
            switch success {
            case true:
                complete(statusCode, data ?? nil, nil);
            case false:
                complete(statusCode, data ?? nil,errorMsg);
            }
        }
    }
}
