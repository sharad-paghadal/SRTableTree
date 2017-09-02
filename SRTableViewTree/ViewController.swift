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
        
        let vinu = SRTreeTableViewNode(nodeID: 1, nodeName: "1", leftImageName: "", rightImageName: "", isExpand: false)!
        let ramesh = SRTreeTableViewNode(nodeID: 2, nodeName: "2", leftImageName: "", rightImageName: "", isExpand: false)!

        let bhavesh = SRTreeTableViewNode(nodeID: 11, nodeName: "1.1", leftImageName: "", rightImageName: "", isExpand: false)!
        let kalpesh = SRTreeTableViewNode(nodeID: 11, nodeName: "1.2", leftImageName: "", rightImageName: "", isExpand: false)!
        
        let sharad = SRTreeTableViewNode(nodeID: 11, nodeName: "2.1", leftImageName: "", rightImageName: "", isExpand: false)!
        let rakesh = SRTreeTableViewNode(nodeID: 11, nodeName: "2.2", leftImageName: "", rightImageName: "", isExpand: false)!


        let lax = SRTreeTableViewNode(nodeID: 11, nodeName: "1.1.1", leftImageName: "", rightImageName: "", isExpand: false)!
        let kalpesh1 = SRTreeTableViewNode(nodeID: 11, nodeName: "1.2.1", leftImageName: "", rightImageName: "", isExpand: false)!

        
        let laxChild = SRTreeTableViewNode(nodeID: 11, nodeName: "1.1.1.1", leftImageName: "", rightImageName: "", isExpand: false)!
        
        
        let sharadsChild = SRTreeTableViewNode(nodeID: 11, nodeName: "2.1.1", leftImageName: "", rightImageName: "", isExpand: false)!
        
        
        let rootNodes = [vinu,ramesh]
        
        vinu.addChildNode(childNode: bhavesh)
        vinu.addChildNode(childNode: kalpesh)
        bhavesh.addChildNode(childNode: lax)
        kalpesh.addChildNode(childNode: kalpesh1)
        
        ramesh.addChildNode(childNode: sharad)
        ramesh.addChildNode(childNode: rakesh)
        sharad.addChildNode(childNode: sharadsChild)
        
        lax.addChildNode(childNode: laxChild)
        
        let treeTableView = SRTreeTableView(frame: view.bounds, style: .plain)
        treeTableView.rootNodes = rootNodes
        view.addSubview(treeTableView)
    }
}

