//
//  NoteFileViewController.swift
//  NoteShareApp
//
//  Created by 鄭煒宗 on 2017/11/18.
//  Copyright © 2017年 鄭煒宗. All rights reserved.
//

import UIKit

class NoteFileViewController: UIViewController {
    
    @IBOutlet weak var notetitle: UITextField!
    @IBOutlet weak var noteContain: UITextView!
    
    @IBAction func shareNote(_ sender: Any) {
        
        guard let title = notetitle.text else {
            return
        }
        
        guard let contain = noteContain.text else {
            return
        }
        
        let text = "\(title)" + " : " + "\(contain)"
        
        print(text)
        
        let printPageRenderer = producePrintPageRenderer(content: text)
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)
        
        let url: URL = getFileURL(name: "file.pdf")!
        
        do {
            try pdfData?.write(to: url, options: .atomic)
            
        } catch {
            
            print( "save pdf file error!")
            
        }
        
        let controller = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        present(controller, animated: true, completion: nil)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
