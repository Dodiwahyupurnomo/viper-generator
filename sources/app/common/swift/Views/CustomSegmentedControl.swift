//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

@IBDesignable open class CustomSegmentedControl: UIControl {
    private class IndicatorView: UIView {
        // MARK: Properties
        fileprivate let segmentMaskView = UIView()
        fileprivate var cornerRadius: CGFloat = 0 {
            didSet {
                layer.cornerRadius = cornerRadius
                segmentMaskView.layer.cornerRadius = cornerRadius
            }
        }
        
        override open var frame: CGRect {
            didSet {
                segmentMaskView.frame = frame
            }
        }
        
        // MARK: Lifecycle
        init() {
            super.init(frame: CGRect.zero)
            finishInit()
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            finishInit()
        }
        private func finishInit() {
            layer.masksToBounds = true
            segmentMaskView.backgroundColor = .black
        }
    }
    
    // MARK: Constants
    private struct Animation {
        static let withBounceDuration: TimeInterval = 0.3
        static let springDamping: CGFloat = 0.75
        static let withoutBounceDuration: TimeInterval = 0.2
    }
    
    // MARK: Properties
    /// The selected index
    public private(set) var index: UInt
    /// The segments available for selection
    public var segments: [CustomSegmentedControlSegment] {
        didSet {
            guard segments.count > 1 else {
                return
            }
            
            normalSegmentsView.subviews.forEach({ $0.removeFromSuperview() })
            selectedSegmentsView.subviews.forEach({ $0.removeFromSuperview() })
            
            for segment in segments {
                normalSegmentsView.addSubview(segment.normalView)
                selectedSegmentsView.addSubview(segment.selectedView)
            }
            
            setNeedsLayout()
        }
    }
    /// A list of options to configure the control with
    public var options: [CustomSegmentedControlOption]? {
        get { return nil }
        set {
            guard let options = newValue else {
                return
            }
            
            for option in options {
                switch option {
                case let .indicatorViewBackgroundColor(value):
                    indicatorViewBackgroundColor = value
                case let .indicatorViewInset(value):
                    indicatorViewInset = value
                case let .indicatorViewBorderWidth(value):
                    indicatorViewBorderWidth = value
                case let .indicatorViewBorderColor(value):
                    indicatorViewBorderColor = value
                case let .alwaysAnnouncesValue(value):
                    alwaysAnnouncesValue = value
                case let .announcesValueImmediately(value):
                    announcesValueImmediately = value
                case let .panningDisabled(value):
                    panningDisabled = value
                case let .backgroundColor(value):
                    backgroundColor = value
                case let .cornerRadius(value):
                    cornerRadius = value
                case let .bouncesOnChange(value):
                    bouncesOnChange = value
                }
            }
        }
    }
    /// Whether the indicator should bounce when selecting a new index. Defaults to true
    @IBInspectable public var bouncesOnChange: Bool = true
    /// Whether the the control should always send the .ValueChanged event, regardless of the index remaining unchanged after interaction. Defaults to false
    @IBInspectable public var alwaysAnnouncesValue: Bool = false
    /// Whether to send the .ValueChanged event immediately or wait for animations to complete. Defaults to true
    @IBInspectable public var announcesValueImmediately: Bool = true
    /// Whether the the control should ignore pan gestures. Defaults to false
    @IBInspectable public var panningDisabled: Bool = false
    /// The control's and indicator's corner radii
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            indicatorView.cornerRadius = newValue - indicatorViewInset
            segmentViews.forEach { $0.layer.cornerRadius = indicatorView.cornerRadius }
        }
    }
    /// The indicator view's background color
    @IBInspectable public var indicatorViewBackgroundColor: UIColor? {
        get {
            return indicatorView.backgroundColor
        }
        set {
            indicatorView.backgroundColor = newValue
        }
    }
    /// The indicator view's inset. Defaults to 2.0
    @IBInspectable public var indicatorViewInset: CGFloat = 2.0 {
        didSet { setNeedsLayout() }
    }
    /// The indicator view's border width
    @IBInspectable public var indicatorViewBorderWidth: CGFloat {
        get {
            return indicatorView.layer.borderWidth
        }
        set {
            indicatorView.layer.borderWidth = newValue
        }
    }
    /// The indicator view's border color
    @IBInspectable public var indicatorViewBorderColor: UIColor? {
        get {
            guard let color = indicatorView.layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            indicatorView.layer.borderColor = newValue?.cgColor
        }
    }
    
    /// Enable animation change index
    @IBInspectable public var enableAnimation: Bool = true
    
    /// The selected index
    @IBInspectable public var selectedIndex: UInt = 0{
        didSet{
            setIndex(selectedIndex, animated: enableAnimation)
        }
    }
    
    // MARK: Private properties
    private let normalSegmentsView = UIView()
    private let selectedSegmentsView = UIView()
    private let indicatorView = IndicatorView()
    private var initialIndicatorViewFrame: CGRect?
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    private var width: CGFloat { return bounds.width }
    private var height: CGFloat { return bounds.height }
    private var normalSegmentCount: Int { return normalSegmentsView.subviews.count }
    private var normalSegments: [UIView] { return normalSegmentsView.subviews }
    private var selectedSegments: [UIView] { return selectedSegmentsView.subviews }
    private var segmentViews: [UIView] { return normalSegments + selectedSegments}
    private var totalInsetSize: CGFloat { return indicatorViewInset * 2.0 }
    private lazy var defaultSegments: [CustomSegmentedControlSegment] = {
        return [LabelSegment(text: "First"), LabelSegment(text: "Second")]
    }()
    
    // MARK: Lifecycle
    public init(frame: CGRect,
                segments: [CustomSegmentedControlSegment],
                index: UInt = 0,
                options: [CustomSegmentedControlOption]? = nil) {
        self.index = index
        self.segments = segments
        super.init(frame: frame)
        completeInit()
        self.options = options
    }
    required public init?(coder aDecoder: NSCoder) {
        self.index = 0
        self.segments = [LabelSegment(text: "First"), LabelSegment(text: "Second")]
        super.init(coder: aDecoder)
        completeInit()
    }
    @available(*, unavailable, message: "Use init(frame:segments:index:options:) instead.")
    convenience override public init(frame: CGRect) {
        self.init(frame: frame,
                  segments: [LabelSegment(text: "First"), LabelSegment(text: "Second")])
    }
    
    @available(*, unavailable, message: "Use init(frame:segments:index:options:) instead.")
    convenience init() {
        self.init(frame: .zero,
                  segments: [LabelSegment(text: "First"), LabelSegment(text: "Second")])
    }
    private func completeInit() {
        layer.masksToBounds = true
        
        normalSegmentsView.clipsToBounds = true
        addSubview(normalSegmentsView)
        addSubview(indicatorView)
        selectedSegmentsView.clipsToBounds = true
        addSubview(selectedSegmentsView)
        selectedSegmentsView.layer.mask = indicatorView.segmentMaskView.layer
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CustomSegmentedControl.tapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(CustomSegmentedControl.panned(_:)))
        panGestureRecognizer.delegate = self
        addGestureRecognizer(panGestureRecognizer)
        
        guard segments.count > 1 else { return }
        
        for segment in segments {
            segment.normalView.clipsToBounds = true
            normalSegmentsView.addSubview(segment.normalView)
            segment.selectedView.clipsToBounds = true
            selectedSegmentsView.addSubview(segment.selectedView)
        }
        
        setNeedsLayout()
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        guard normalSegmentCount > 1 else {
            return
        }
        
        normalSegmentsView.subviews[Int(selectedIndex)].isHidden = true
        
        normalSegmentsView.frame = bounds
        selectedSegmentsView.frame = bounds
        
        indicatorView.frame = elementFrame(forIndex: index)
        
        for index in 0...normalSegmentCount-1 {
            let frame = elementFrame(forIndex: UInt(index))
            normalSegmentsView.subviews[index].frame = frame
            selectedSegmentsView.subviews[index].frame = frame
        }
    }
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setDefaultLabelTextSegmentColorsFromInterfaceBuilder()
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        setDefaultLabelTextSegmentColorsFromInterfaceBuilder()
    }
    private func setDefaultLabelTextSegmentColorsFromInterfaceBuilder() {
        guard let normalLabelSegments = normalSegments as? [UILabel],
            let selectedLabelSegments = selectedSegments as? [UILabel] else {
                return
        }
        
        normalLabelSegments.forEach {
            $0.textColor = indicatorView.backgroundColor
        }
        selectedLabelSegments.forEach {
            $0.textColor = backgroundColor
        }
    }
    
    // MARK: Index Setting
    /// Sets the control's index.
    ///
    /// - Parameters:
    ///   - index: The new index
    ///   - animated: (Optional) Whether the change should be animated or not. Defaults to true.
    private func setIndex(_ index: UInt, animated: Bool = true) {
        guard normalSegments.indices.contains(Int(index)) else {
            return
        }
        let oldIndex = self.index
        self.index = index
        moveIndicatorViewToIndex(animated, shouldSendEvent: (self.index != oldIndex || alwaysAnnouncesValue))
    }
    
    // MARK: Indicator View Customization
    /// Adds the passed view as a subview to the indicator view
    ///
    /// - Parameter view: The view to be added to the indicator view
    public func addSubviewToIndicator(_ view: UIView) {
        indicatorView.addSubview(view)
    }
    
    // MARK: Animations
    private func moveIndicatorViewToIndex(_ animated: Bool, shouldSendEvent: Bool) {
        if animated {
            if shouldSendEvent && announcesValueImmediately {
                sendActions(for: .valueChanged)
            }
            UIView.animate(withDuration: bouncesOnChange ? Animation.withBounceDuration : Animation.withoutBounceDuration,
                           delay: 0.0,
                           usingSpringWithDamping: bouncesOnChange ? Animation.springDamping : 1.0,
                           initialSpringVelocity: 0.0,
                           options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseOut],
                           animations: {
                            () -> Void in
                            self.normalSegments.forEach({$0.isHidden = false})
                            self.normalSegments[Int(self.selectedIndex)].isHidden = true
                            self.moveIndicatorView()
            }, completion: { (finished) -> Void in
                self.normalSegments[Int(self.selectedIndex)].isHidden = true
                if finished && shouldSendEvent && !self.announcesValueImmediately {
                    self.sendActions(for: .valueChanged)
                }
            })
        } else {
            self.normalSegments.forEach({$0.isHidden = false})
            moveIndicatorView()
            self.normalSegments[Int(self.selectedIndex)].isHidden = true
            if shouldSendEvent {
                sendActions(for: .valueChanged)
            }
        }
    }
    
    // MARK: Helpers
    private func elementFrame(forIndex index: UInt) -> CGRect {
        let elementWidth = (width - totalInsetSize) / CGFloat(normalSegmentCount)
        return CGRect(x: CGFloat(index) * elementWidth + indicatorViewInset,
                      y: indicatorViewInset,
                      width: elementWidth,
                      height: height - totalInsetSize)
    }
    private func nearestIndex(toPoint point: CGPoint) -> UInt {
        let distances = normalSegments.map { abs(point.x - $0.center.x) }
        return UInt(distances.firstIndex(of: distances.min()!)!)
    }
    private func moveIndicatorView() {
        let normalSegmet = normalSegments[Int(self.index)]
        indicatorView.frame = normalSegmet.frame
        //normalSegmet.isHidden = true
        layoutIfNeeded()
    }
    
    // MARK: Action handlers
    @objc private func tapped(_ gestureRecognizer: UITapGestureRecognizer!) {
        let location = gestureRecognizer.location(in: self)
        //setIndex(nearestIndex(toPoint: location))
        selectedIndex = nearestIndex(toPoint: location)
    }
    @objc private func panned(_ gestureRecognizer: UIPanGestureRecognizer!) {
        guard !panningDisabled else {
            return
        }
        
        switch gestureRecognizer.state {
        case .began:
            initialIndicatorViewFrame = indicatorView.frame
        case .changed:
            var frame = initialIndicatorViewFrame!
            frame.origin.x += gestureRecognizer.translation(in: self).x
            frame.origin.x = max(min(frame.origin.x, bounds.width - indicatorViewInset - frame.width), indicatorViewInset)
            indicatorView.frame = frame
        case .ended, .failed, .cancelled:
            //setIndex(nearestIndex(toPoint: indicatorView.center))
            selectedIndex = nearestIndex(toPoint: indicatorView.center)
        default: break
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension CustomSegmentedControl: UIGestureRecognizerDelegate {
    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGestureRecognizer {
            return indicatorView.frame.contains(gestureRecognizer.location(in: self))
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}

public protocol CustomSegmentedControlSegment {
    var normalView: UIView { get }
    var selectedView: UIView { get }
}

public enum CustomSegmentedControlOption {
    /* Selected segment */
    case indicatorViewBackgroundColor(UIColor)
    case indicatorViewInset(CGFloat)
    case indicatorViewBorderWidth(CGFloat)
    case indicatorViewBorderColor(UIColor)
    
    /* Behavior */
    case alwaysAnnouncesValue(Bool)
    case announcesValueImmediately(Bool)
    case panningDisabled(Bool)
    
    /* Other */
    case backgroundColor(UIColor)
    case cornerRadius(CGFloat)
    case bouncesOnChange(Bool)
}



open class LabelSegment: CustomSegmentedControlSegment {
    // MARK: Constants
    private struct DefaultValues {
        static let normalBackgroundColor: UIColor = .clear
        static let normalTextColor: UIColor = .white
        static let selectedBackgroundColor: UIColor = .clear
        static let selectedTextColor: UIColor = .black
        static let font: UIFont = UILabel().font
    }
    
    // MARK: Properties
    public let text: String?
    
    public let normalFont: UIFont
    public let normalTextColor: UIColor
    public let normalBackgroundColor: UIColor
    
    public let selectedFont: UIFont
    public let selectedTextColor: UIColor
    public let selectedBackgroundColor: UIColor
    
    private let accessibilityIdentifier: String?
    
    // MARK: Lifecycle
    public init(text: String? = nil,
                normalBackgroundColor: UIColor? = nil,
                normalFont: UIFont? = nil,
                normalTextColor: UIColor? = nil,
                selectedBackgroundColor: UIColor? = nil,
                selectedFont: UIFont? = nil,
                selectedTextColor: UIColor? = nil,
                accessibilityIdentifier: String? = nil) {
        self.text = text
        self.normalBackgroundColor = normalBackgroundColor ?? DefaultValues.normalBackgroundColor
        self.normalFont = normalFont ?? DefaultValues.font
        self.normalTextColor = normalTextColor ?? DefaultValues.normalTextColor
        self.selectedBackgroundColor = selectedBackgroundColor ?? DefaultValues.selectedBackgroundColor
        self.selectedFont = selectedFont ?? DefaultValues.font
        self.selectedTextColor = selectedTextColor ?? DefaultValues.selectedTextColor
        self.accessibilityIdentifier = accessibilityIdentifier
    }
    
    // MARK: CustomSegmentedControlSegment
    public lazy var normalView: UIView = {
        return label(withText: text,
                     backgroundColor: normalBackgroundColor,
                     font: normalFont,
                     textColor: normalTextColor)
    }()
    public lazy var selectedView: UIView = {
        return label(withText: text,
                     backgroundColor: selectedBackgroundColor,
                     font: selectedFont,
                     textColor: selectedTextColor)
    }()
    private func label(withText text: String?,
                       backgroundColor: UIColor,
                       font: UIFont,
                       textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.backgroundColor = backgroundColor
        label.font = font
        label.textColor = textColor
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        if let identifier = accessibilityIdentifier {
            label.accessibilityIdentifier = identifier
        }
        return label
    }
}

public extension LabelSegment {
    class func segments(withTitles titles: [String],
                        normalBackgroundColor: UIColor? = nil,
                        normalFont: UIFont? = nil,
                        normalTextColor: UIColor? = nil,
                        selectedBackgroundColor: UIColor? = nil,
                        selectedFont: UIFont? = nil,
                        selectedTextColor: UIColor? = nil) -> [CustomSegmentedControlSegment] {
        return titles.map {
            LabelSegment(text: $0,
                         normalBackgroundColor: normalBackgroundColor,
                         normalFont: normalFont,
                         normalTextColor: normalTextColor,
                         selectedBackgroundColor: selectedBackgroundColor,
                         selectedFont: selectedFont,
                         selectedTextColor: selectedTextColor)
        }
    }
    
    class func segments(withTitlesAndAccessibilityIdentifiers titlesAndAccessibilityIdentifiers: [(title: String,
        accessibilityIdentifier: String?)],
                        normalBackgroundColor: UIColor? = nil,
                        normalFont: UIFont? = nil,
                        normalTextColor: UIColor? = nil,
                        selectedBackgroundColor: UIColor? = nil,
                        selectedFont: UIFont? = nil,
                        selectedTextColor: UIColor? = nil) -> [CustomSegmentedControlSegment] {
        return titlesAndAccessibilityIdentifiers.map {
            LabelSegment(text: $0.title,
                         normalBackgroundColor: normalBackgroundColor,
                         normalFont: normalFont,
                         normalTextColor: normalTextColor,
                         selectedBackgroundColor: selectedBackgroundColor,
                         selectedFont: selectedFont,
                         selectedTextColor: selectedTextColor,
                         accessibilityIdentifier: $0.accessibilityIdentifier)
        }
    }
}
