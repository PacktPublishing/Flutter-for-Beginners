import Flutter
import UIKit

public class HandsOnTextView: NSObject, FlutterPlatformView {
    let frame: CGRect
    let viewId: Int64
    let text: String
    
    init(_ frame: CGRect, viewId: Int64, args: Any?) {
        self.frame = frame
        self.viewId = viewId    
        let arguments = args as? [String: Any]

        self.text = arguments?["text"] as? String ?? ""
    }
    
    public func view() -> UIView {
        let textView = UITextView(frame: frame)
        textView.text = self.text
        return textView
    }
}

public class HandsOnTextViewFactory: NSObject, FlutterPlatformViewFactory {

    public func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
        ) -> FlutterPlatformView {
        return HandsOnTextView(frame, viewId: viewId, args: args)
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
