//
//  GirlsCollectionView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/27.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

protocol GirlCollectionProtocol {
    func needAdd()
    func cellSelector(girlModel: GirlModel, mframe: CGRect)
    func registerCellFor3DTouch(cell: GirlCollectionViewCell)
}

class GirlsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

    private var width: CGFloat = 0
    private var height: CGFloat = 0
    
    var girl_delegate: GirlCollectionProtocol?
    
    var models: [GirlModel] = [] {
        didSet{
            self.reloadData()
        }
    }
    
    init(frame: CGRect) {
        let mlayout = UICollectionViewFlowLayout()
        width = SCREEN_WIDTH / 3.0 - 4.5 // 4.5是 3 + 1.5
        height = width /// 2 * 3
        mlayout.itemSize = CGSize(width: width, height: height)                   // 每个Item的大小
        mlayout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3) // 设置每组的cell的边界 距离屏幕的上下左右位置
        mlayout.minimumLineSpacing = 3      // cell的最小行间距
        mlayout.minimumInteritemSpacing = 3 // cell的最小列间距
        super.init(frame: frame, collectionViewLayout: mlayout)
        
        self.backgroundColor = UIColor.groupTableViewBackground
        
        self.delegate = self
        self.dataSource = self
        
        self.register(GirlCollectionViewCell.self, forCellWithReuseIdentifier: GirlCollectionViewCell.ID)
    }
    
    //返回section个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 每个section的item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = GirlCollectionViewCell.cellWith(collectionView: collectionView, indexPath: indexPath)
        
        cell.setImageURL(url: NetTool.tiangou_image_base_url + models[indexPath.row].img + "_" + (width * 1.5).toStringValue + "x" + (height * 1.5).toStringValue)
        
        if isSupport3DTouch() {
            girl_delegate?.registerCellFor3DTouch(cell: cell)
        }
        
        return cell
    }
    
    // cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    // cell被选择时被调用
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            Toast.toast.show(message: "内部错误", duration: .nomal, removed: nil)
            return
        }
        
        // 这么多superview指向的是和屏幕大小一样的view
        let mframe = cell.convert(CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height), to: self.superview?.superview?.superview)
        
        //
        girl_delegate?.cellSelector(girlModel: models[indexPath.row], mframe: mframe)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentSize.height < frame.size.height {
            if scrollView.contentOffset.y > 20 {
                //print("cool")
            }
        }else {
            if (scrollView.contentSize.height - frame.size.height - frame.size.height / 3 < scrollView.contentOffset.y) {
                girl_delegate?.needAdd()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GirlsCollectionView {
    // 是否支持3d touch
    func isSupport3DTouch() -> Bool {
        return self.traitCollection.forceTouchCapability == .available
    }
}
