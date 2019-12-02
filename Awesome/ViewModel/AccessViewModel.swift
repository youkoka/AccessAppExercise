//
//  AccessViewModel.swift
//  Awesome
//
//  Created by colt on 2019/12/2.
//  Copyright © 2019 colt. All rights reserved.
//

import UIKit

class AccessViewModel: NSObject {

    func fectchUIList(since:Int, _ complete: @escaping ([UIListModel])->Void ) {
        
        AccessApiModel.getUIList(since: since) { (statusCode, data, errorMsg) in
            
            switch statusCode {
                
            case 200:
                if let responseData = data {
                    
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    guard let uiList:[UIListModel] =  try? decoder.decode([UIListModel].self, from: responseData) else {
                    
                        complete([])
                        return
                    }
                    complete(uiList)
                }
                
            default:
                complete([])
            }
        }
    }
}
