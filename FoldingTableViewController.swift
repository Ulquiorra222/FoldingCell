//
//  FoldingTableViewController.swift
//  
//
//  Created by dong po luo on 2018/3/16.
//

import UIKit
import FoldingCell

class FoldingTableViewController: UITableViewController {

    let kCloseCellHeight: CGFloat =  179
    var kOpenCellHeight: CGFloat = 488
    let kRowCount = 10
    var cellHeights:[CGFloat] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    func setup() {
        cellHeights = Array(repeating: kCloseCellHeight, count:kRowCount)
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor(patternImage:#imageLiteral(resourceName: "background"))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as DemoCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
        
        cell.number = indexPath.row
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! FoldingCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DemoCell
        
        if cell.isAnimating(){
            return
        }
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
        if  cellIsCollapsed {
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        }else {
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
