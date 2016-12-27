//
//  GirlViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/13.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit
import Alamofire

class GirlViewController: UIViewController {

    private var userVC: UserActionViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "妹子"
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: .done, target: self, action: #selector(rightAction))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let itemScrollView = ItemScrollView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: 20))
        self.view.addSubview(itemScrollView)
        
        userVC = UserActionViewController()
        
        // 先判断缓存中是否有数据 没有就从网络获取
        if let models = NSKeyedUnarchiver.unarchiveObject(withFile: Tools.getCacheDirectory(name: "TG_DATA.models")) as? [GirlTypeModel] {
            itemScrollView.items = models
        }else {
            // 获得图片分类
            Alamofire.request(NetTool.tiangou_image_sort_url, method: .post, parameters: nil).responseJSON { (response) in
                guard let result = response.result.value as? NSDictionary else {
                    return
                }
                guard let tngou = result["tngou"] as? [NSDictionary] else {
                    return
                }
                var models: [GirlTypeModel] = []
                for tg in tngou {
                    models.append(GirlTypeModel(fromDictionary: tg))
                }
                itemScrollView.items = models
                NSKeyedArchiver.archiveRootObject(models, toFile: Tools.getCacheDirectory(name: "TG_DATA.models"))
            }
        }
    }
    
    // 获得图片list 包含图片的网址
    func getGirlPic(id: Int) -> Void {
        Alamofire.request(NetTool.tiangou_image_list_url, method: .post, parameters: ["id" : id]).responseJSON { (response) in
            guard let result = response.result.value as? NSDictionary else {
                return
            }
            guard let tngou = result["tngou"] as? [NSDictionary] else {
                return
            }
            var models: [GirlModel] = []
            for tg in tngou {
                models.append(GirlModel(fromDictionary: tg))
            }
            
        }
    }
    
    @objc
    private func rightAction() -> Void {
        let nav = GirlNavViewController(rootViewController: UserActionViewController())
        self.present(nav, animated: true, completion: nil)
    }

}
