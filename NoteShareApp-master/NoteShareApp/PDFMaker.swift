//
//  PDFMaker.swift
//  NoteShareApp
//
//  Created by 鄭煒宗 on 2017/11/25.
//  Copyright © 2017年 鄭煒宗. All rights reserved.
//

import Foundation
import UIKit

// MARK: PDF Format

class CustomPrintPageRenderer: UIPrintPageRenderer {
    
    let A4PageWidth: CGFloat = 595.2
    let A4PageHeight: CGFloat = 841.8
    
    override init() {
        super.init()
        
        let pageFrame = CGRect(x: 0.0, y: 0.0, width: A4PageWidth, height: A4PageHeight)
        self.setValue(NSValue(cgRect: pageFrame), forKey: "paperRect")
        self.setValue(NSValue(cgRect: pageFrame), forKey: "printableRect")
    }
    
}

//  MARK: Produce PrintPageRenderer

func producePrintPageRenderer(content: String) -> CustomPrintPageRenderer {
    
    let printPageRenderer = CustomPrintPageRenderer()
    let printFormatter = UIMarkupTextPrintFormatter(markupText: content)
    printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
    
    return printPageRenderer
}



//  MARK: Produce PDF NSdata

func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -> NSData!{
    let data = NSMutableData()
    
    UIGraphicsBeginPDFContextToData(data, CGRect.zero, nil)
    printPageRenderer.prepare(forDrawingPages: NSMakeRange(0, printPageRenderer.numberOfPages))
    
    for i in 0...(printPageRenderer.numberOfPages - 1) {
        
        UIGraphicsBeginPDFPage()
        printPageRenderer.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
    }
    
    UIGraphicsEndPDFContext()
    
    return data
}

// MARK: Save PDF file to document

func getFileURL(name: String) -> URL? {
    
    do {
        let fileManager = FileManager.default
        
        let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        return documentDirectory.appendingPathComponent(name)
        
    } catch let error {
        
        print(error)
        
        return nil
    }
}



