//
//  MainWindowController.swift
//  OutlineView
//
//  Created by Dis3buted on 23/05/16.
//  Copyright © 2016 Seven Years Later. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    @IBOutlet weak var outline: NSOutlineView!
    fileprivate var rootItem: FileItem? = FileItem(url: URL(fileURLWithPath:"/"), parent: nil)

    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
}

//MARK: - NSOutlineViewDelegate
extension MainWindowController: NSOutlineViewDelegate {
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if let it = item as? FileItem {
            return it.childAtIndex(index)!
        }
        return rootItem!
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        let view = outline.make(withIdentifier: "TextCell", owner: self) as? NSTableCellView
        if let it = item as? FileItem {
            if let textField = view?.textField {
                textField.stringValue = it.displayName
            }
        } 
        return view
    }
}

//MARK: - NSOutlineViewDataSource
extension MainWindowController: NSOutlineViewDataSource {
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if let it = item as? FileItem {
            return it.count
        }
        return 1
    }
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let it = item as? FileItem {
            if it.count > 0 {
                return true
            }
        }
        return false
    }
}
