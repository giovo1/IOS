//
//  ViewController.swift
//  NYTimesApp
//
//  Created by Giovanny Rocha on 11/21/17.
//  Copyright © 2017 Giovanny Rocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelHeadLine: UILabel!
    @IBOutlet weak var labelSnippet: UILabel!
    @IBOutlet weak var labelSource: UILabel!
    @IBOutlet weak var labelPublicationDate: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    
    var headLine:String?
    var snippet:String?
    var source:String?
    var publicationDate:String?
    var urlImage:String?
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        labelHeadLine.text = headLine
        labelSnippet.text = snippet
        labelSource.text = source
        labelPublicationDate.text = publicationDate
        
        if urlImage != "" {
            let imageAux:NSData = try! NSData(contentsOf: urlImage!.asURL())!
            imageNews?.image = UIImage(data:imageAux as Data)
        } else {
            imageNews?.image = #imageLiteral(resourceName: "no_image1")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

