# AccessAppExercise
## Feature
* User list of GitHub 
 	* Include
    	- avatar
    	- lgoin
    	- site_admin badge
 	* Load as page,page size is 20
 	* Limit to 100 users
* User info 
 	* Include
 		- avatar
 		- name
 		- site_admin
 	* Click blog will open url in Safari
## Requirements
  * iOS 11.0+
	* Xcode 11.2.1
	* Swift 5
  
## Architecture
  * MVVM
    * SharedClass : shared method or class
        * Extension : extension folder, include DataExtension.swift
        * ApiModel : based network model, include NetworkUtils.swift, BaseApiModel.swift and AccessApiModel
        * BaseTableViewController : inherit from ViewController, always used in custum table view
        
    * Model : data fodler
    
    * ViewModel : 
        * AccessViewModel : main operation access 
        
    * View : main page content
        * TableViewCell : table view's content
        * Controller : main page
        
## Third Party
  * Alamofire: HTTP Networking
  * SDWebImage: Load Image
