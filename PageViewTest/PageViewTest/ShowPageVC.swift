//
//  ShowPageVC.swift
//  PageViewTest
//
//  Created by Rigin Velayudhan on 18/07/18.
//  Copyright © 2018 Rigin Velayudhan. All rights reserved.
//

import UIKit

class ShowPageVC: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
   
    var imageFileName: String!
    var pageIndex:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myImageView.image = UIImage(named:imageFileName)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
