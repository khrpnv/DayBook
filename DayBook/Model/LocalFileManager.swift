//
//  FileManager.swift
//  DayBook
//
//  Created by Илья on 6/12/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

class LocalFileManager{
    public static let instance = LocalFileManager()
    private init(){}
    
    func writeFile(fileName: String, text: String){
        let DocumentDirUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirUrl.appendingPathComponent(fileName).appendingPathExtension("txt")
        do{
            try text.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError{
            print("Failed writing!\n")
            print(error)
        }
    }
    
    func readFile(fileName: String) -> String{
        var result = ""
        let DocumentDirUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirUrl.appendingPathComponent(fileName).appendingPathExtension("txt")
        do{
            result = try String(contentsOf: fileURL)
        } catch let error as NSError{
            print("Failed reading!\n")
            print(error)
        }
        return result
    }
}
