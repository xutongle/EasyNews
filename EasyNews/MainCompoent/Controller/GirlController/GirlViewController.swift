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

    fileprivate var itemScrollView: ItemScrollView!                   // 顶部滚动的view
    fileprivate var newGirlscollectionView: GirlsCollectionView!      // 只看最新的妹子
    
    fileprivate var isAnimationed = false
    
    // 容器
    fileprivate var containerView: UIView!
    // 当前容器上的view
    fileprivate var currentContainerVC: ChildGirlViewController!
    
    // 正常的图片分类分类
    fileprivate var oldID: Int = 1
    fileprivate var page: Int = 1
    
    // 只看最新的页码
    fileprivate var newPage: Int = 1
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "妹子图"
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        let barHeight = Tools.getBarHeight(nav: self.navigationController)
        
        // 只看最新的妹子
        newGirlscollectionView = GirlsCollectionView(frame: CGRect(x: 0, y: barHeight.sumHeight,
                                                                   width: self.view.frame.size.width,
                                                                   height: self.view.frame.size.height - TAB_HEIGHT))
        self.view.insertSubview(newGirlscollectionView, at: 0)
        
        // 分类看妹子
        itemScrollView = ItemScrollView(x: 0, y: barHeight.sumHeight, width: self.view.frame.size.width)
        self.view.addSubview(itemScrollView)
        itemScrollView.item_delegate = self
        
        let containerViewY = barHeight.sumHeight + self.itemScrollView.getHeight()
        // 容器
        containerView = UIView(frame: CGRect(x: 0, y: containerViewY,
                                             width: self.view.frame.size.width,
                                             height: self.view.frame.size.height - containerViewY - TAB_HEIGHT))
        containerView.backgroundColor = UIColor.groupTableViewBackground
        self.view.insertSubview(containerView, at: 2)
        
        
        // 获得妹子的类型 有缓存
        getGirlType { (models) in
            self.itemScrollView.itemModels = models
            
            // 加入
            for m in self.itemScrollView.itemModels {
                let childVC = ChildGirlViewController()
                
                self.addChildViewController(childVC)
                //
                childVC.setFrame(mframe: CGRect(x: 0, y: 0,
                                                width: self.containerView.frame.width,
                                                height: self.containerView.frame.height), mid: m.id)
            }
            
            // 显示第一个
            self.containerView.addSubview(self.childViewControllers.first!.view)
            self.currentContainerVC = self.childViewControllers.first as! ChildGirlViewController
        }
    }
    
    // 获得图片的类型
    func getGirlType(complete: @escaping (_ models: [GirlTypeModel]) -> Void) -> Void {
        // 先判断缓存中是否有数据 没有就从网络获取
        if let models = NSKeyedUnarchiver.unarchiveObject(withFile: Tools.getCacheDirectory(name: "TG_DATA.models")) as? [GirlTypeModel] {
            complete(models)
        } else {
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
                NSKeyedArchiver.archiveRootObject(models, toFile: Tools.getCacheDirectory(name: "TG_DATA.models"))
                complete(models)
            }
        }
    }
}

// MARK: - ItemScrollViewDelegate协议
extension GirlViewController: ItemScrollViewDelegate {
    // 协议
    func ItemCilck(girlType: GirlTypeModel) {
        guard childViewControllers.count >= girlType.id else {
            return
        }
        let vc = childViewControllers[girlType.id - 1] as! ChildGirlViewController
        // 如果当前就是这个
        if currentContainerVC.isEqual(vc) {
            return
        }
        
        self.transition(from: currentContainerVC, to: vc, duration: 0.5, options: .transitionCurlDown, animations: nil) { (over) in
            vc.didMove(toParentViewController: self)
            self.currentContainerVC = vc
            
            // 老得移除 貌似不用
            // self.currentContainerVC.willMove(toParentViewController: nil)
            // self.currentContainerVC.removeFromParentViewController()
        }
    }
}

// MARK: - 右侧导航栏按钮事件
extension GirlViewController {
    
}
