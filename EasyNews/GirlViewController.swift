//
//  GirlViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/13.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit
import Alamofire

class GirlViewController: UIViewController, ItemScrollViewDelegate, GirlCollectionProtocol{

    private var collectionView: GirlsCollectionView!  // 主体CollectionView
    private var itemScrollView: ItemScrollView!       // 顶部仿网易的滚动的view
    private var newGirlscollectionView: GirlsCollectionView!      // 只看最新的妹子
    
    private var isAnimationed = false
    
    // 正常的图片分类分类
    private var oldID: Int = 1
    private var page: Int = 1
    
    // 只看最新的页码
    private var newPage: Int = 1
    private var isRequest: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "妹子图"
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "只看最新", style: .done, target: self, action: #selector(rightAction))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        // 只看最新的妹子
        newGirlscollectionView = GirlsCollectionView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height - 39))
        self.view.addSubview(newGirlscollectionView)
        
        // 分类看妹子
        itemScrollView = ItemScrollView(x: 0, y: 64, width: self.view.frame.size.width)
        self.view.addSubview(itemScrollView)
        itemScrollView.item_delegate = self
        
        collectionView = GirlsCollectionView(frame: CGRect(x: 0, y: 104, width: self.view.frame.size.width, height: self.view.frame.size.height - 94 - 39 - 13))
        collectionView.girl_delegate = self
        self.view.addSubview(collectionView)
        
        // 获得妹子的类型 有缓存
        getGirlType()
        
        // 获得分类为1的妹子
        getGirlPic(id: oldID)
    }
    
    // 获得图片的类型
    func getGirlType() -> Void {
        // 先判断缓存中是否有数据 没有就从网络获取
        if let models = NSKeyedUnarchiver.unarchiveObject(withFile: Tools.getCacheDirectory(name: "TG_DATA.models")) as? [GirlTypeModel] {
            self.itemScrollView.items = models
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
                self.itemScrollView.items = models
                NSKeyedArchiver.archiveRootObject(models, toFile: Tools.getCacheDirectory(name: "TG_DATA.models"))
            }
        }
    }
    
    // 获得图片list 包含图片的网址
    func getGirlPic(id: Int) -> Void {
        isRequest = true
        Alamofire.request(NetTool.tiangou_image_list_url, method: .post, parameters: ["page" : page, "id" : id, "rows" : 18]).responseJSON { (response) in
            self.isRequest = false
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
            
            if self.page > 1 {
                self.collectionView.models += models
            } else {
                self.collectionView.models = models
            }
        }
    }
    
    // 获得最新图片
    func getNewPic() -> Void {
        
        newPage += 1
    }
    
    // 协议
    func ItemCilck(girlType: GirlTypeModel) {
        if oldID == girlType.id {
            return
        }
        page = 1
        oldID = girlType.id
        getGirlPic(id: girlType.id)
    }
    
    func needAdd() -> Void {
        // 正在请求就不要再请求一次了
        if self.isRequest {
            return
        }
        page += 1
        getGirlPic(id: oldID)
    }
    
    @objc
    private func rightAction() -> Void {
        if !isAnimationed {
            onlySeeNew()
            isAnimationed = true
        }else {
            backNomal()
            isAnimationed = false
        }
    }
    
    // 只看最新
    private func onlySeeNew() {
        
        UIView.beginAnimations("change", context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationCurve(.easeInOut)
        
        UIView.setAnimationTransition(.flipFromLeft, for: self.view, cache: true)
        self.view.exchangeSubview(at: 0, withSubviewAt: 2)
        
        UIView.commitAnimations()
        
        self.navigationItem.rightBarButtonItem?.title = "按类型查看"
        self.navigationItem.title = "最新妹子图"
    }
    
    // 恢复正常
    private func backNomal() {
        UIView.beginAnimations("change", context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationCurve(.easeInOut)
        
        UIView.setAnimationTransition(.flipFromLeft, for: self.view, cache: true)
        self.view.exchangeSubview(at: 2, withSubviewAt: 0)
        
        UIView.commitAnimations()
        
        self.navigationItem.rightBarButtonItem?.title = "只看最新"
        self.navigationItem.title = "妹子图"
    }

}
