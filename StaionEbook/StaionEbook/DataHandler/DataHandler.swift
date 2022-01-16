//
//  DataHandler.swift
//  StaionEbook
//
//  Created by Shekhar Deshmukh on 16/01/22.
//

import Foundation
import UIKit

protocol DataHandlerDelegate : NSObject {
    func getParseXMLdataResopnce(data:NSMutableArray)
    func onError(errorMsg:String)
}

class DataHandler : NSObject {
    weak var delegate:DataHandlerDelegate?
    
    var stationId = NSMutableString()
    var stationName = NSMutableString()
    var logo = NSMutableString()
    var elements = NSMutableDictionary()
    var element = NSString()
    var posts = NSMutableArray()
    var parser = XMLParser()
    
    func getParseXMLdata(url:String){
        posts = []
        // parse xml data using url
        parser = XMLParser(contentsOf:(NSURL(string:url))! as URL)!
        parser.delegate = self
        parser.parse()
        
        if posts.count > 0{
            self.delegate?.getParseXMLdataResopnce(data: posts)
        }else{
            self.delegate?.onError(errorMsg: "Could not read XML data")
        }
    }
}

extension DataHandler : XMLParserDelegate{
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "Item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            stationId = NSMutableString()
            stationId = ""
            stationName = NSMutableString()
            stationName = ""
            logo = NSMutableString()
            logo = ""
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if (elementName as NSString).isEqual(to: "Item") {
            
            if !stationId.isEqual(nil) {
                elements.setObject(stationId, forKey: "StationId" as NSCopying)
            }
            if !stationName.isEqual(nil) {
                elements.setObject(stationName, forKey: "StationName" as NSCopying)
            }
            if !logo.isEqual(nil) {
                elements.setObject(logo, forKey: "Logo" as NSCopying)
            }
            
            posts.add(elements)
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        let str = String(string.filter { !"\n".contains($0) })
        if element.isEqual(to: "StationId") {
            stationId.append(str)
        }
        if element.isEqual(to: "StationName") {
            stationName.append(str)
        }
        if element.isEqual(to: "Logo") {
            logo.append(str)
        }
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        
    }
}
