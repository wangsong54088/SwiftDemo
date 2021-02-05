//
//  ViewController.swift
//  SwiftDemo
//
//  Created by apple on 2021/2/4.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var timer : Timer!
    let mainService = MainService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTimer()
        updateUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //timer.fireDate = NSDate.distantPast
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //timer.fireDate = NSDate.distantFuture
    }
    // MARK: - prvite method
    func addTimer() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(requestData), userInfo: nil, repeats: true)
    }
    func updateUI() {
        // 获取缓存数据优先显示
        let cacheData = AppStorageTool.getDataFromDocument(fileName: "historylistData")
        let cacheArray = try? (JSONSerialization.jsonObject(with: cacheData as Data, options: .mutableContainers) as! NSArray)
        if (cacheArray != nil) {
            let dict = cacheArray?[0] as! NSDictionary
            let jsonStr = dict["data"]
            textView.text = jsonStr as? String
        }
    }
    // MARK: - request data
    @objc func requestData() {
        mainService.getGithubApiData(successBlock: {[self] (jsonStr) in
            textView.text = jsonStr as? String
        }, errorBlock: { (errorMessage) in
        })
    }
    // MARK: - actions
    @IBAction func historyAction(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "HistoryDataViewController") else { return }
        self.present(vc, animated: true, completion: nil);
    }
}

