//
//  ResultsViewController.swift
//  Foogle
//
//  Created by Krysia O on 2/4/17.
//  Copyright © 2017 Krysia. All rights reserved.
//

import UIKit

var userUPCValue = ""

struct Allergies {
    let peanut: Bool
    let soy: Bool
    let custom: String
}

class ResultsViewController: UIViewController {

    
    @IBOutlet weak var foodType: UILabel!
    
    
    
    @IBOutlet weak var customInputLabel: UILabel!
    var allergies: Allergies!
    
    @IBOutlet weak var barcodeNumber: UITextField!

  
    
    
    
    @IBOutlet weak var userResults: UILabel!
    
    
    var nameLabel: String? {
        didSet {
            self.foodType.text = nameLabel
        }
    }
    
    var ingredientsLabel: String? {
        didSet {
            self.customInputLabel.text = ingredientsLabel
        }
    }
    

    
    @IBAction func savingbarcodeNumber(sender: UIButton) {
        
      //   self.foodType.text = "Tortilla Chips, Cheese"
        
      // self.userResults.text = "These contain milk and MSG, do not eat"
        
        let usersUPCValue = (barcodeNumber.text ?? "")

        // coca-cola test upc =  49000036756
        // let upc = "49000036756"
        let url = NSURL(string: "https://api.nutritionix.com/v1_1/item?upc=\(usersUPCValue)&appId=f72c783d&appKey=126513f6b2fd7e5047217459ea8dbb3d")!
        
        
        
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            
            let string = String(data: data!, encoding: NSUTF8StringEncoding)
            print(string)
            
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            print("this is json/n/n/n")
            print(json)
            
            // 28400090896
            let root = json as! [String:AnyObject]
            print("this is root/n/n/n")
            print(root.keys)
            
          //      self.nameLabel = root["item_name"] as? String
                
                print("Item \(root["item_name"])")
            dispatch_async(dispatch_get_main_queue(), {
                self.nameLabel = root["item_name"] as? String

                self.foodType.text = root["item_name"] as? String
                
            })
            
            
            print("Item \(root["nf_ingredient_statement"])")
            dispatch_async(dispatch_get_main_queue(), {
                self.ingredientsLabel = root["nf_ingredient_statement"] as? String
                
                self.customInputLabel.text = root["nf_ingredient_statement"] as? String
                
            })
            
           
     
        
            
            /* if root.containsValue(custom) {
             
             
             }*/
            
            //            self.customInputLabel.text = root["error_code"] as! String
            /*  let ingredients = root["nf_ingredient_statement"] as! String
             print(ingredients) */
            //
            
          /*  let name = root["item_name"]
            
            print(name)  */
            
            
        }.resume()
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        customInputLabel.text = allergies?.custom
        // = allergies?.peanut
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
