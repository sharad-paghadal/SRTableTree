//
//  SRTreeTableViewNode.swift
//  SRTreeTableView
//
//  Created by Sharad Paghadal on 2017/09/01.
//  Copyright © 2017 Sharad Paghadal. All rights reserved.
//

import UIKit

class SRTreeTableViewNode: NSObject {
    
    var parentNode:SRTreeTableViewNode?{
        didSet{
            if let parentN = parentNode, !parentN.subNodes.contains(self) {
                parentN.subNodes.append(self)
            }
        }
    }
    
    var subNodes:[SRTreeTableViewNode] = [SRTreeTableViewNode](){
        didSet{
            for childNode in subNodes{
                childNode.parentNode = self
            }
        }
    }
    
    var nodeID:UInt = 0
    var nodeName:String = ""
    var leftImageName:String = ""
    var rightImageName:String = ""
    var isExpand:Bool = false
    var depth:Int{
        if let parentN = parentNode{
            return parentN.depth + 1
        }
        return 0
    }
    private override init(){
        super.init()
    }
    
    convenience init?(nodeID:UInt,nodeName:String,leftImageName:String,rightImageName:String,isExpand:Bool){
        self.init()
        if nodeName == ""{
            return nil
        }
        else{
            self.nodeID = nodeID
            self.nodeName = nodeName
            self.leftImageName = leftImageName
            self.rightImageName = rightImageName
            self.isExpand = isExpand
        }
    }
    
    func addChildNode(childNode:SRTreeTableViewNode){
        childNode.parentNode = self
    }
}
