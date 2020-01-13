//
//  SubSistemasVC.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 11/01/20.
//  Copyright © 2020 Roberto Edgar Geiss. All rights reserved.
//

import UIKit

class SubSistemasVC: UIViewController
{

    @IBOutlet weak var lblSubSistema: UILabel!
    var albuns: [Album] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        albuns = 
        lblSubSistema.text = ""
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

