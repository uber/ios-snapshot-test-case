//
//  ViewWithText.swift
//  FBSnapshotTestCaseDemoMacOS
//
//  Created by Ivan Misuno on 12-03-2018.
//  Copyright © 2018 AlbumPrinter BV. All rights reserved.
//

import Cocoa
import SnapKit

class ViewWithText: NSView {

    private let label = NSTextField()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        commonInit()
    }

    private func commonInit() {
        wantsLayer = true
        layer?.backgroundColor = NSColor.yellow.cgColor

        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        label.backgroundColor = NSColor.clear
        label.isEditable = false
        label.isSelectable = true
        label.isBordered = false
        label.textColor = NSColor.red
        label.stringValue = "Lorem ipsum dolore sit amet"
    }
}
