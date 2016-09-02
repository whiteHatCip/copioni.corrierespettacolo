//
//  CopioneVC.swift
//  Copioni.CorriereSpettacolo
//
//  Created by Fabio Cipriani on 02/09/16.
//  Copyright © 2016 Fabio Cipriani. All rights reserved.
//

import UIKit

class CopioneVC: UIViewController {

    @IBOutlet weak var BackBtn: UIButton!
    
    @IBOutlet weak var webView: UIWebView!
    var copURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let encodedString = copURL.addingPercentEncoding(withAllowedCharacters:
            CharacterSet.urlFragmentAllowed),
            let url2 = URL(string: encodedString) {
            webView.loadRequest(URLRequest(url: url2))
        }
        
    }
    
    @IBAction func BackBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true , completion: nil)
    }
}
