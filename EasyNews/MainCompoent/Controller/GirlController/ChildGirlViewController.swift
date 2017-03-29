//
//  ChildGirlViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2017/1/7.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit
import Alamofire

/// 每一个collectionView的Controller
class ChildGirlViewController: UIViewController {

    fileprivate var collectionView: GirlsCollectionView!  // 主体CollectionView
    
    fileprivate let topBottomSwapGestrue = TopBottomSwapGestrue()
    fileprivate var girlTransationDelegate: GirlTransationDelegate!
    
    // page
    var page: Int = 1 {
        didSet{
            getGirlPic()
        }
    }
    
    // id 每一会从缓存或者网络给值过来
    private var id: Int = 1 {
        didSet{
            getGirlPic()
        }
    }
    
    // 是否正在请求数据
    fileprivate var isRequest: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setFrame(mframe: CGRect, mid: Int) -> Void {
        
        self.view.frame = mframe
        collectionView = GirlsCollectionView(frame: CGRect(x: 0, y: 0, width: mframe.width, height: mframe.height))
        collectionView.girl_delegate = self
        self.view.addSubview(collectionView)
        
        self.id = mid
    }
    
    // 获得图片list 包含图片的网址
    private func getGirlPic() -> Void {
        isRequest = true
        Toast.toast.show(message: "加载中...", duration: .short, removed: nil)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ChildGirlViewController: GirlCollectionProtocol {
    
    // 协议 滚动
    internal func needAdd() {
        if isRequest {
            Toast.toast.show(message: "正在加载中，稍等哦", duration: .short, removed: nil)
            return
        }
        page += 1
    }
    
    // 点按了cell
    internal func cellSelector(girlModel: GirlModel, mframe: CGRect) {
        
        let bigPicVC = BigPicViewController()
        bigPicVC.url = NetTool.tiangou_image_base_url + girlModel.img
        
        girlTransationDelegate = GirlTransationDelegate(topBottomSwapGestrue: topBottomSwapGestrue, mFrame: mframe)
        bigPicVC.transitioningDelegate = girlTransationDelegate
        
        topBottomSwapGestrue.wire(to: bigPicVC)
        self.present(bigPicVC, animated: true, completion: nil)
    }
    
    internal func registerCellFor3DTouch(cell: GirlCollectionViewCell) {
        self.registerForPreviewing(with: self, sourceView: cell)
    }
}

// MARK: - 3d touch
extension ChildGirlViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
}
