//
//  FileItem.swift
//  OutlineView
//
//  Created by Dis3buted on 23/05/16.
//  Copyright © 2016 Seven Years Later. All rights reserved.
//

import Foundation

class FileItem {
    
    var url: NSURL!
    var parent: FileItem?
    var isLeaf:Bool = false
    
    static let fileManager = NSFileManager()//.defaultManager()
    static let requiredAttributes = [NSURLIsDirectoryKey]
    static let options: NSDirectoryEnumerationOptions = [.SkipsHiddenFiles, .SkipsPackageDescendants, .SkipsSubdirectoryDescendants]
    
    
    lazy var children: [FileItem]? = {
        if let enumerator = fileManager.enumeratorAtURL(self.url, includingPropertiesForKeys:FileItem.requiredAttributes, options: FileItem.options, errorHandler: nil) {
            
            var files = [FileItem]()
            while let localURL = enumerator.nextObject() as? NSURL {
                do {
                    let properties = try localURL.resourceValuesForKeys(FileItem.requiredAttributes)
                    files.append(FileItem(url: localURL, parent: self, isLeaf: (properties[NSURLIsDirectoryKey] as! NSNumber).boolValue))
                    
                } catch {
                    print("Error reading file attributes")
                }
            }
            return files
        }
        return nil
    }()
    
    init(url: NSURL, parent: FileItem?, isLeaf: Bool){
        self.url = url
        self.parent = parent
        self.isLeaf = isLeaf
    }
    
    var displayName: String {
        get {
            return self.url.lastPathComponent!
        }
    }
    
    var count: Int {
        return (self.children?.count)!
    }
    
    func childAtIndex(n: Int) -> FileItem? {
        return self.children![n]
    }
}
