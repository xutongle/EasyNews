//
//  ChildGirlViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2017/1/7.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit
import Alamofire

class ChildGirlViewController: UIViewController, GirlCollectionProtocol {

    private var collectionView: GirlsCollectionView!  // 主体CollectionView
    
    var page: Int = 1 {
        didSet{
            getGirlPic()
        }
    }
    
    var id: Int = 1 {
        didSet{
            getGirlPic()
        }
    }
    
    // 是否正在请求数据
    private var isRequest: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setFrame(mframe: CGRect, mid: Int) -> Void {
        self.id = mid
        
        self.view.frame = mframe
        collectionView = GirlsCollectionView(frame: CGRect(x: 0, y: 0, width: mframe.width, height: mframe.height))
        collectionView.girl_delegate = self
        self.view.addSubview(collectionView)
    }
    
    // 获得图片list 包含图片的网址
    private func getGirlPic() -> Void {
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
    
    // 协议
    internal func needAdd() {
        if isRequest {
            return
        }
        page += 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
