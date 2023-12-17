//
//  table.swift
//  demolqc
//
//  Created by ByteDance on 2023/12/10.
//

import Foundation
import UIKit
import SnapKit

class ShowView: UIView, viewsProtocol {    
    var name = "\(ShowView.self)"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var button: UIButton = makeButton()
    lazy var collectionView: UICollectionView = makeCollec()
    lazy var scrollerView: UIScrollView = makeScroll()
    func setupUI() {
        self.backgroundColor = UIColor.white
        
        self.addSubview(scrollerView)
        scrollerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        scrollerView.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        scrollerView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(5)
            make.height.equalTo(100)
            make.width.greaterThanOrEqualToSuperview()
        }
    }
    func makeButton() -> UIButton{
        let button = UIButton()
        button.setTitle("button", for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.red, for: .selected)
        button.addTarget(self, action: #selector(buttonTouch), for: .touchDown)
        return button
    }
    func makeCollec() -> UICollectionView {
        let configurtion = UICollectionViewCompositionalLayoutConfiguration()
        configurtion.scrollDirection = .horizontal
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(40), heightDimension: .absolute(40)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(40), heightDimension: .absolute(80)), repeatingSubitem: item, count: 2)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(5)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: configurtion)
        let collecView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collecView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        
        collecView.showsVerticalScrollIndicator = false
        collecView.showsHorizontalScrollIndicator = false
        collecView.bounces = false
        collecView.backgroundColor = .clear
        collecView.delegate = self
        collecView.dataSource = self
        
        return collecView
    }
    func makeScroll() -> UIScrollView {
        let scroller = UIScrollView(frame: self.frame)
        scroller.contentSize = CGSize(width: self.frame.width, height: self.frame.height * 2)
        scroller.showsVerticalScrollIndicator =  false
        scroller.showsHorizontalScrollIndicator = false
        scroller.bounces = false
        return scroller
    }
}

extension ShowView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        let index = indexPath.item
        cell.cellConfig(index: index)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

class Cell: UICollectionViewCell {
    static let reuseIdentifier: String = "\(Cell.self)"
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        self.addSubview(label)
        self.backgroundColor = .green
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func cellConfig(index: Int) {
        label.text = String(index)
        if index % 2 == 0 {
            label.backgroundColor = .blue
        } else {
            label.backgroundColor = .green
        }
    }
}



extension ShowView {
    @objc func buttonTouch(_sender: UIButton) {
        print("kla")
    }
    
}

