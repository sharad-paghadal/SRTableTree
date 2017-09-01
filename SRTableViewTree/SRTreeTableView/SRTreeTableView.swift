//
//  SRTreeTableView.swift
//  SRTreeTableView
//
//  Created by Sharad Paghadal on 2017/09/01.
//  Copyright © 2017 Sharad Paghadal. All rights reserved.
//

import UIKit

private let SRTreeTableViewNodeCellID:String = "SRTreeTableViewNodeCellID"
private let SRTreeTableViewContentCellID:String = "SRTreeTableViewContentCellID"

private let SRTreeTableViewNodeCellHeight:CGFloat = 50
private let SRTreeTableViewContentCellHeight:CGFloat = 80

class SRTreeTableView: UITableView {
    
    var rootNodes:[SRTreeTableViewNode] = [SRTreeTableViewNode](){
        didSet{
            getExpandNodeArray()
            reloadData()
        }
    }
    
    fileprivate var tempNodeArray:[SRTreeTableViewNode] = [SRTreeTableViewNode]()
    
    fileprivate var insertIndexPaths:[IndexPath] = [IndexPath]()
    private var insertRow = 0
    
    fileprivate var deleteIndexPaths:[IndexPath] = [IndexPath]()
    
    override init(frame:CGRect, style: UITableViewStyle){
        super.init(frame: frame, style: style)
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTableView()
    }
    
    private func setupTableView(){
        dataSource = self
        delegate = self
        register(SRTreeTableViewNodeCell.self, forCellReuseIdentifier: SRTreeTableViewNodeCellID)
        register(SRTreeTableViewContentCell.self, forCellReuseIdentifier: SRTreeTableViewContentCellID)
    }
    
    private func addExpandNodeToArray(node:SRTreeTableViewNode) -> Void{
        tempNodeArray.append(node)
        
        if node.isExpand{
            for childNode in node.subNodes{
                addExpandNodeToArray(node: childNode)
            }
        }
    }
    
    private func getExpandNodeArray() -> (){
        for rootNode in rootNodes{
            if rootNode.parentNode == nil{
                addExpandNodeToArray(node: rootNode)
            }
        }
    }
    
    fileprivate func isLeafNode(node:SRTreeTableViewNode) -> Bool{
        return node.subNodes.count == 0
    }
    
    fileprivate func insertChildNode(node:SRTreeTableViewNode){
        node.isExpand = true
        if node.subNodes.count == 0{
            return
        }
        
        insertRow = tempNodeArray.index(of: node)! + 1
        
        for childNode in node.subNodes{
            let childRow = insertRow
            let childIndexPath = IndexPath(row: childRow, section: 0)
            insertIndexPaths.append(childIndexPath)
            
            tempNodeArray.insert(childNode, at: childRow)
            
            insertRow += 1
            if childNode.isExpand{
                insertChildNode(node: childNode)
            }
        }
    }
    
    fileprivate func getDeleteIndexPaths(node:SRTreeTableViewNode){
        if node.isExpand{
            
            for childNode in node.subNodes{
                let childRow = tempNodeArray.index(of: childNode)!
                let childIndexPath = IndexPath(row: childRow, section: 0)
                deleteIndexPaths.append(childIndexPath)
                
                if childNode.isExpand{
                    getDeleteIndexPaths(node: childNode)
                }
            }
        }
    }
    
    fileprivate func deleteChildNode(node:SRTreeTableViewNode){
        getDeleteIndexPaths(node: node)
        
        node.isExpand = false
        for _ in deleteIndexPaths{
            tempNodeArray.remove(at: deleteIndexPaths.first!.row)
        }
    }
}

extension SRTreeTableView:UITableViewDataSource,UITableViewDelegate{
    // MARK: - cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempNodeArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let node = tempNodeArray[indexPath.row]
        
        if isLeafNode(node: node){
            let cell:SRTreeTableViewNodeCell = tableView.dequeueReusableCell(withIdentifier: SRTreeTableViewNodeCellID, for: indexPath) as! SRTreeTableViewNodeCell
            
            cell.node = node
            
            return cell
        } else{ // 节点cell
            let cell:SRTreeTableViewContentCell = tableView.dequeueReusableCell(withIdentifier: SRTreeTableViewContentCellID, for: indexPath) as! SRTreeTableViewContentCell
            
            cell.node = node
            
            return cell
        }
    }
    
    // MARK: - tableview cell and header height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SRTreeTableViewNodeCellHeight
    }
    
    // MARK: - tableview delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let node = tempNodeArray[indexPath.row]
        
        if isLeafNode(node: node){
            return
        } else{
            if node.isExpand{
                deleteIndexPaths = [IndexPath]()
                deleteChildNode(node: node)
                deleteRows(at: deleteIndexPaths, with: .top)
            }
            else{
                insertIndexPaths = [IndexPath]()
                insertChildNode(node: node)
                insertRows(at: insertIndexPaths, with: .top)
                
                if node.depth == 0 {
                    for rootnode in rootNodes{
                        if node.nodeName == rootnode.nodeName {
                            
                        }else {
                            if rootnode.isExpand {
                                deleteIndexPaths = [IndexPath]()
                                deleteChildNode(node: rootnode)
                                deleteRows(at: deleteIndexPaths, with: .top)
                            }
                        }
                        
                    }
                }else {
                    for siblingNode in (node.parentNode?.subNodes)!{
                        if node.nodeName == siblingNode.nodeName {
                            
                        }else {
                            if siblingNode.isExpand {
                                deleteIndexPaths = [IndexPath]()
                                deleteChildNode(node: siblingNode)
                                deleteRows(at: deleteIndexPaths, with: .top)
                            }
                        }
                        
                    }
                }
            }
        }
    }
}
