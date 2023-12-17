//
//  BottomTab.swift
//  demolqc
//
//  Created by ByteDance on 2023/12/16.
//

import Foundation
import SnapKit
import UIKit

protocol BottomTabDelegate: AnyObject {
    func clickLeft()
    func clickRight()
}

public enum ButtonType: Int{
    case left
    case right
}

class BottomTab: UIView {
    lazy var leftButton = makeChangePageButton(buttonType: .left)
    lazy var rightButton = makeChangePageButton(buttonType: .right)
    lazy var titleLabel = makeTitleLabel()
    
    weak var delegate: BottomTabDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        self.addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.width.height.equalTo(26)
            make.bottom.equalToSuperview().inset(25)
            make.left.equalToSuperview().inset(25)
        }
        self.addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.width.height.equalTo(26)
            make.bottom.equalToSuperview().inset(25)
            make.right.equalToSuperview().inset(25)
        }
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(182)
            make.height.equalTo(42)
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
    }
    public func updateUI(name: String, isLeftAbandon: Bool = false, isRightAbandon: Bool = false) {
        titleLabel.text = name
        leftButton.isEnabled = !isLeftAbandon
        rightButton.isEnabled = !isRightAbandon
        self.layoutIfNeeded()
        
    }
}

extension BottomTab {
    func makeChangePageButton(buttonType: ButtonType) -> UIButton{
        var button = UIButton()
        if buttonType == .left {
            button.setImage(UIImage(named: "leftJiantou"), for: .normal)
            button.addTarget(self, action: #selector(changeToLeftPage), for: .touchDown)
        }
        if buttonType == .right {
            button.setImage(UIImage(named: "rightJiantou"), for: .normal)
            button.addTarget(self, action: #selector(changeToRightPage), for: .touchDown)
        }
        button.setImage(UIImage(named: "jiantouAbandon"), for: .disabled)
        return button
    }
    @objc func changeToLeftPage() {
        self.delegate?.clickLeft()
    }
    @objc func changeToRightPage() {
        self.delegate?.clickRight()
    }
    
    func makeTitleLabel() ->UILabel {
        let label: UILabel = UILabel()
        label.text = "HomePage"
        label.textAlignment = .center
        return label
    }
}
