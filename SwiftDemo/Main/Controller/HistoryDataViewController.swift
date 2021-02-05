//
//  HistoryDataViewController.swift
//  SwiftDemo
//
//  Created by apple on 2021/2/5.
//

import UIKit

class HistoryDataViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var historylistData = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        initData()
    }
    // MARK: - prvite method
    func setUpUI() {
        tableView.tableFooterView = UIView.init()
        tableView.delegate = self
        tableView.dataSource = self
    }
    func initData() {
        let cacheData = AppStorageTool.getDataFromDocument(fileName: "historylistData")
        let cacheArray = try? (JSONSerialization.jsonObject(with: cacheData as Data, options: .mutableContainers) as! NSArray)
        if cacheArray != nil {
            historylistData = cacheArray as! [NSDictionary]
        }
    }
    // MARK: - actions
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historylistData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel!.text = historylistData[indexPath.row]["title"] as? String
        return cell
    }
}
