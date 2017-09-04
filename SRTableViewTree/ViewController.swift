//
//  ViewController.swift
//  SRTableViewTree
//
//  Created by Sharad Paghadal on 01/09/17.
//  Copyright © 2017 Sharad Paghadal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _1 = SRTreeTableViewNode(nodeID: 1, nodeName: "1", leftImageName: "", rightImageName: "", isExpand: false)!
        let _1_1 = SRTreeTableViewNode(nodeID: 11, nodeName: "1.1", leftImageName: "", rightImageName: "", isExpand: false)!
        let _1_1_1 = SRTreeTableViewNode(nodeID: 111, nodeName: "1.1.1", leftImageName: "", rightImageName: "", isExpand: false)!
        let _1_1_1_1 = SRTreeTableViewNode(nodeID: 1111, nodeName: "1.1.1.1", leftImageName: "", rightImageName: "", isExpand: false)!
        let _1_2 = SRTreeTableViewNode(nodeID: 12, nodeName: "1.2", leftImageName: "", rightImageName: "", isExpand: false)!
        let _1_2_1 = SRTreeTableViewNode(nodeID: 121, nodeName: "1.2.1", leftImageName: "", rightImageName: "", isExpand: false)!
        let _2 = SRTreeTableViewNode(nodeID: 2, nodeName: "2", leftImageName: "", rightImageName: "", isExpand: false)!
        let _2_1 = SRTreeTableViewNode(nodeID: 21, nodeName: "2.1", leftImageName: "", rightImageName: "", isExpand: false)!
        let _2_1_1 = SRTreeTableViewNode(nodeID: 211, nodeName: "2.1.1", leftImageName: "", rightImageName: "", isExpand: false)!
        let _2_2 = SRTreeTableViewNode(nodeID: 22, nodeName: "2.2", leftImageName: "", rightImageName: "", isExpand: false)!
        
        let rootNodes = [_1,_2]
        
        _1.addChildNode(childNode: _1_1)
        _1.addChildNode(childNode: _1_2)
        _1_1.addChildNode(childNode: _1_1_1)
        _1_1_1.addChildNode(childNode: _1_1_1_1)
        _1_2.addChildNode(childNode: _1_2_1)
        _2.addChildNode(childNode: _2_1)
        _2.addChildNode(childNode: _2_2)
        _2_1.addChildNode(childNode: _2_1_1)
        
        let treeTableView = SRTreeTableView(frame: view.bounds, style: .plain)
        treeTableView.rootNodes = rootNodes
        treeTableView.isAutoShrinkEnabled = true
        view.addSubview(treeTableView)
    }
}

