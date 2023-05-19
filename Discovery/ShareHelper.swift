//
//  ShareHelper.swift
//  Discovery
//
//  Created by Discovery on 4/5/2023.
//

import Foundation
import FBSDKShareKit



    extension UIViewController {
        static var topViewController: UIViewController? {
            var topVC = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController
            while let presentedVC = topVC?.presentedViewController {
                topVC = presentedVC
            }
            return topVC
        }
    }

    class ShareHelper {
        static var documentInteractionController: UIDocumentInteractionController?
        
        static func shareImageViaWhatsapp(image: UIImage, onView: UIView) {
            let urlWhats = "whatsapp://app"
            if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed) {
                if let whatsappURL = URL(string: urlString) {
                    if UIApplication.shared.canOpenURL(whatsappURL) {
                        guard let imageData = image.pngData() else { debugPrint("Cannot convert image to data!"); return }
                        let tempFile = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/whatsAppTmp.wai")
                        do {
                            try imageData.write(to: tempFile, options: .atomic)
                            self.documentInteractionController = UIDocumentInteractionController(url: tempFile)
                            self.documentInteractionController?.uti = "net.whatsapp.image"
                            self.documentInteractionController?.presentOpenInMenu(from: .zero, in: onView, animated: true)
                        } catch {
                            if let topVC = UIViewController.topViewController {
                                self.callAlertView(title: NSLocalizedString("information", comment: ""),
                                                   message: "There was an error while processing, please contact our support team.",
                                                   buttonText: "Close", fromViewController: topVC)
                            }
                        }
                    } else {
                        if let topVC = UIViewController.topViewController {
                            self.callAlertView(title: NSLocalizedString("warning", comment: ""),
                                               message: "Cannot open Whatsapp, be sure Whatsapp is installed on your device.",
                                               buttonText: "Close", fromViewController: topVC)
                        }
                    }
                }
            }
        }
        
        static func callAlertView(title: String, message: String, buttonText: String, fromViewController: UIViewController) {
            let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: buttonText, style: .cancel, handler: nil))
            fromViewController.present(alertView, animated: true, completion: nil)
        }
        
        static func shareImageViaFacebook(image: UIImage, fromViewController: UIViewController) {
                
            let sharePhoto = SharePhoto()
                sharePhoto.image = image
                sharePhoto.isUserGenerated = true
                
            let content = SharePhotoContent()
                content.photos = [sharePhoto]
                
            let dialog = ShareDialog()
            dialog.delegate = (fromViewController as! SharingDelegate)
                dialog.fromViewController = fromViewController
                dialog.shareContent = content
                dialog.mode = .shareSheet
                dialog.show()
            }
            
       
    }
   
