//
//  TestTableViewController.swift
//  FoldingCell
//
//  Created by dong po luo on 2018/3/19.
//

import UIKit

class TestTableViewController: UITableViewController {

    let openCellHeight: CGFloat = 505
    let closeCellHeight: CGFloat = 180
    var cellHeights: [CGFloat] = []
    let rowCount = 10
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    
    func setup() {
        tableView.estimatedRowHeight = closeCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor(patternImage:#imageLiteral(resourceName: "background"))
        cellHeights = Array(repeating: closeCellHeight, count: rowCount)
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as TestTableViewCell = cell else{
            return
        }
        cell.backgroundColor = .clear
        if cellHeights[indexPath.row] == openCellHeight {
            cell.constrainView.alpha = 1
            cell.forgroundView.alpha = 0
        }else {
            cell.constrainView.alpha  = 0
            cell.forgroundView.alpha = 1
        }
        cell.number = indexPath.row
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rowCount
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TestTableViewCell


        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let cell = tableView.cellForRow(at: indexPath) as! TestTableViewCell
        var druation = 0.0
        
        let cellIsCollapsed = cellHeights[indexPath.row] == closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = openCellHeight
            druation = Double(cell.itemCount) * 0.12
            cell.startAnimation()
        } else {
            cellHeights[indexPath.row] = closeCellHeight
            druation = Double(cell.itemCount) * 0.22
            cell.endAnimation()
        }

        UIView.animate(withDuration: druation, delay: 0, options: .curveEaseIn, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)

        cell.selectionStyle = UITableViewCellSelectionStyle.none

    }



}
