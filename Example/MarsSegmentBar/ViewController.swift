//
//  ViewController.swift
//  MarsSegmentBar
//
//  Created by xsun0403@163.com on 10/28/2019.
//  Copyright (c) 2019 xsun0403@163.com. All rights reserved.
//

import UIKit
import MarsSegmentBar

class ViewController: UIViewController {
    
    @IBOutlet weak var pushAction: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func pushAction(_ sender: Any) {
        let vc = MarsSegmentBarViewController()
        let items = ["titleA","titleB"]
        let vcs: [UIViewController] = {
            let vc = UIViewController()
            vc.view.backgroundColor = .red
            let vc1 = UIViewController()
            vc1.view.backgroundColor = .yellow
            return [vc, vc1]
        }()
        vc.setup(items: items, childVCs: vcs)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

