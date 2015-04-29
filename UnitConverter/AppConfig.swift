//
//  AppConfig.swift
//  017-Beautiful-ID-Photo
//
//  Created by Audrey Li on 4/18/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants {
    
//    static let PaperWidth: CGFloat = 1198.3
//    static let PaperHeight: CGFloat = 1693.9
    static var paperSize = PaperSizeCollection.A4
    static var userUnit = Unit.inch
    static let printPaperHeaderHeight: CGFloat = 30
    // the margins of the printing paper
    static var printPaperPerPageContentInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    static var printPaperMargin = UIEdgeInsets(top: 68, left: 36, bottom: 68, right: 36)
    
    static let maskBackgroundColor = UIColor(red: 0.007, green: 0.007, blue: 0.007, alpha: 0.6)
    static var showMaskImageMeasurement = true
    static let cuttingBorderColor = UIColor.grayColor()
    static let imageEditOverlayViewOuterPaddingRatio: CGFloat = 0.25
    static let showPrintViewTitle = true 
    
    
    //for imageEditingOverlayViwe
    static let strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    static let measureStrokeColor = UIColor.redColor()
    static let measureTextBgcolor = UIColor.whiteColor()
    static let borderStrokeColor = UIColor.clearColor()
    
    // temp data -> move to class later
//    static var idPhotoWidth: CGFloat = 289.8
//    static var idPhotoHeight: CGFloat = 289.8
    static var headToTopMarginToWidthRatio: CGFloat = 0.1
    static var headToTopMargin:CGFloat = 20
    
    // for photo sharing
    static var printPhotosInnerPadding: CGFloat = 10 // space between photos
    static var printPhotosOuterPadding: CGFloat = 50 // space from the photo edge to the paper edge
    
    // general program config 
    static let imageEditorOverlayViewTag = 10 
    
    // preview printView
    static let previewImageViewOuterPadding: CGFloat = 50
    static let printTitleFont =  UIFont (name: "HelveticaNeue-Bold", size: 20)
    
    
    //For imageOverlay View
    static let WomanBodyHeightWidthRatio: CGFloat = 3.73
    static let WomanBodyOnlyShowUpperBodyWidthRatio: CGFloat = 1.23   // width at shoulder divide by body width
    static let measureFrameWidth: CGFloat = 50
    


    
}

public enum Unit: CGFloat, Printable {
    case mm = 5.7 //
    case inch = 144.9 // 144.9 point in 1 inch
    case cm = 0.57
    case point = 1
    public var description: String {
        get {
            switch self {
            case .mm: return "mm"
            case .inch: return "inch"
            case .cm:  return "cm"
            case .point: return "point"
            }
        }
    }
}

enum PhotoType: String {
    case ID = "ID"
    case Passport = "Passport"
    case DriverLicence = "Driver's Licence"
    case Visa = "Visa"
    case Other = "Other"
    init(typeString: String){
        switch typeString {
        case "ID": self = .ID
        case "Passport": self = .Passport
        case "Driver's Licence": self = .DriverLicence
        case "Visa": self = .Visa
        default: self = .Other
        }
    }
}


struct PaperSize{
    let width: CGFloat
    let height: CGFloat
    init (width: CGFloat, height: CGFloat, unit: Unit = .mm) {
        self.width = width * unit.rawValue
        self.height = height * unit.rawValue
    }
}

struct PaperSizeCollection {
    // below is the ISO paper size
    static let A0 = PaperSize(width: 841, height: 1189)
    static let A1 = PaperSize(width: 594, height: 841)
    static let A2 = PaperSize(width: 420, height: 594)
    static let A3 = PaperSize(width: 297, height: 420)
    static let A4 = PaperSize(width: 210, height: 297)
    static let A5 = PaperSize(width: 148, height: 210)
    static let A6 = PaperSize(width: 105, height: 148)
    static let A7 = PaperSize(width: 74, height: 105)
    static let A8 = PaperSize(width: 52, height: 74)
    static let A9 = PaperSize(width: 37, height: 52)
    static let A10 = PaperSize(width: 26, height: 37)
    
    static let B0 = PaperSize(width: 1000, height: 1414)
    static let B1 = PaperSize(width: 707, height: 1000)
    static let B2 = PaperSize(width: 500, height: 707)
    static let B3 = PaperSize(width: 353, height: 500)
    static let B4 = PaperSize(width: 250, height: 353)
    static let B5 = PaperSize(width: 176, height: 250)
    static let B6 = PaperSize(width: 125, height: 176)
    static let B7 = PaperSize(width: 88, height: 125)
    static let B8 = PaperSize(width: 62, height: 88)
    static let B9 = PaperSize(width: 44, height: 62)
    static let B10 = PaperSize(width: 31, height: 44)
    
    static let C0 = PaperSize(width: 917, height: 1297)
    static let C1 = PaperSize(width: 648, height: 917)
    static let C2 = PaperSize(width: 458, height: 648)
    static let C3 = PaperSize(width: 324, height: 458)
    static let C4 = PaperSize(width: 229, height: 324)
    static let C5 = PaperSize(width: 162, height: 229)
    static let C6 = PaperSize(width: 114, height: 162)
    static let C7 = PaperSize(width: 81, height: 114)
    static let C8 = PaperSize(width: 57, height: 81)
    static let C9 = PaperSize(width: 40, height: 57)
    static let C10 = PaperSize(width: 28, height: 40)
    
}
