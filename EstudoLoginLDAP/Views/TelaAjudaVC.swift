//
//  TelaAjudaVC.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 19/12/19.
//  Copyright © 2019 Roberto Edgar Geiss. All rights reserved.
//

import UIKit

class AjudaVC: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        showIndicator(withTitle: "Hud", and: "Teste")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        hideIndicator()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
