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
    private var rootItem: FileItem? = FileItem(url: NSURL(fileURLWithPath:"/"), parent: nil)

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
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        if let it = item as? FileItem {
            return it.childAtIndex(index)!
        }
        return rootItem!
    }
    
    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        let view = outline.makeViewWithIdentifier("TextCell", owner: self) as? NSTableCellView
        if let it = item as? FileItem {
            if let textField = view?.textField {
                textField.stringValue = it.displayName
            }
        } else {
            if let textField = view?.textField {
                textField.stringValue = self.rootItem!.displayName
            }
        }
        return view
    }
}

//MARK: - NSOutlineViewDataSource
extension MainWindowController: NSOutlineViewDataSource {
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        if let it = item as? FileItem {
            return it.count
        }
        return 1
    }
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        if let it = item as? FileItem {
            if it.count > 0 {
                return true
            }
        }
        return false
    }
}