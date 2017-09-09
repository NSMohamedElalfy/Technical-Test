//
//  GenericTableViewController.swift
//  TO-DO list app
//
//  Created by NSMohamedElalfy on 9/8/17.
//  Copyright © 2017 NSMohamedElalfy. All rights reserved.
//

import UIKit


class GenericTableViewController<Item,Cell: UITableViewCell>:UITableViewController {
 
  // MARK: - Properties
 
  let configureCell : (Cell , Item) -> ()
  let estimatedRowHeight: CGFloat
  var items : [Item] = [] {
    didSet{
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  var didSelect : (Item , IndexPath) -> () = { _ in}
  var didTapAccessory : (Item , IndexPath) -> () = { _ in}
  var didDeleteItem : (Item , IndexPath) -> () = { _ in}
  var loadData : ()->() = { _ in}
  
  /*var whenViewDidLoad : ()->() = { _ in}
  var whenViewWillAppear : ()->() = { _ in}
  var whenViewDidAppear : ()->() = { _ in}
  var whenViewWillDisappear : ()->() = { _ in}
  var whenViewDidDisappear : ()->() = { _ in}*/
  
  // MARK: - Initializers
  init(items:[Item] , estimatedRowHeight: CGFloat = 44, configureCell : @escaping (Cell , Item) -> ()){
    self.configureCell = configureCell
    self.estimatedRowHeight = estimatedRowHeight
    super.init(style: .plain)
    self.items = items
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(Cell.self, forCellReuseIdentifier: String(describing: Cell.self))
    // Use self-sizing cells
    tableView.estimatedRowHeight = estimatedRowHeight
    tableView.rowHeight = UITableViewAutomaticDimension
  }
 
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadData()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
  }
 
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return items.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Cell.self) , for: indexPath) as! Cell
    let item = self.items[indexPath.row]
    // Configure the cell...
    configureCell(cell , item)
    return cell
  }
  
  // MARK: - Table view delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = self.items[indexPath.row]
    didSelect(item , indexPath)
  }
  
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    let item = self.items[indexPath.row]
    didTapAccessory(item , indexPath)
  }
  
  
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
    let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
      // delete item at indexPath
      
      let item = self.items[indexPath.row]
      self.didDeleteItem(item, indexPath)
      tableView.deleteRows(at: [indexPath], with: .fade)
      
    }
    
    
    
    return [delete]
    
  }
  
}
