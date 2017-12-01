//
//  PebbleTableViewCell.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/30/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit

class PebbleTableViewCell: UITableViewCell {

    var collectionView: UICollectionView!
  //  @IBOutlet var collectionView: UICollectionView!
   var collectionViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(UINib.init(nibName: "TDTempoDiscInfoCell", bundle: nil), forCellWithReuseIdentifier: TDTempoDiscInfoViewController.INFO_CELL_IDENTIFIER)
        collectionView.backgroundColor = UIColor.clear
        collectionViewHeight = NSLayoutConstraint.init(item: collectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 100)
        collectionView.addConstraint(collectionViewHeight)
        self.addSubview(collectionView)
        
        
        
//        let flow = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//     //   flow.minimumInteritemSpacing = ...
//        flow.estimatedItemSize = CGSize.init(width: 1, height: 1)
//        self.collectionView.isScrollEnabled = false
//
    }

//    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//        // With autolayout enabled on collection view's cells we need to force a collection view relayout with the shown size (width)
//        //    self.collectionView.frame = CGRect(0, 0, targetSize.width, MAXFLOAT);
//       //     [self.collectionView layoutIfNeeded];
//
//        self.collectionView.frame = CGRect.init(x: CGFloat(0), y: CGFloat(0), width: targetSize.width, height: CGFloat(MAXFLOAT))
//        self.collectionView.layoutIfNeeded()
//
//        //    // If the cell's size has to be exactly the content
//        //    // Size of the collection View, just return the
//        //    // collectionViewLayout's collectionViewContentSize.
//        //
//        //    return [self.collectionView.collectionViewLayout collectionViewContentSize];
//
//        return self.collectionView.collectionViewLayout.collectionViewContentSize
//    }
    
//    - (void)awakeFromNib {
//    [super awakeFromNib];
//    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
//
//
//
//    // Configure the collectionView
//    flow.minimumInteritemSpacing = ...;
//
//    // This enables the magic of auto layout.
//    // Setting estimatedItemSize different to CGSizeZero
//    // on flow Layout enables auto layout for collectionView cells.
//    // https://developer.apple.com/videos/play/wwdc2014-226/
//    flow.estimatedItemSize = CGSizeMake(1, 1);
//
//    // Disable the scroll on your collection view
//    // to avoid running into multiple scroll issues.
//    [self.collectionView setScrollEnabled:NO];
//    }
//
//    - (void)bindWithModel:(id)model {
//    // Do your stuff here to configure the tableViewCell
//    // Tell the cell to redraw its contentView
//    [self.contentView layoutIfNeeded];
//    }
//
//    // THIS IS THE MOST IMPORTANT METHOD
//    //
//    // This method tells the auto layout
//    // You cannot calculate the collectionView content size in any other place,
//    // because you run into race condition issues.
//    // NOTE: Works for iOS 8 or later
//    - (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority {
//
//    // With autolayout enabled on collection view's cells we need to force a collection view relayout with the shown size (width)
//    self.collectionView.frame = CGRectMake(0, 0, targetSize.width, MAXFLOAT);
//    [self.collectionView layoutIfNeeded];
//
//    // If the cell's size has to be exactly the content
//    // Size of the collection View, just return the
//    // collectionViewLayout's collectionViewContentSize.
//
//    return [self.collectionView.collectionViewLayout collectionViewContentSize];
//    }
    
    // Other stuff here...
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
        
       // self.contentView.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
