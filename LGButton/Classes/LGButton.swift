//
//  LGButton.swift
//  LGButtonDemo
//
//  Created by Lorenzo Greco on 28/05/2017.
//  Copyright © 2017 Lorenzo Greco. All rights reserved.
//
import UIKit
import QuartzCore


@IBDesignable
open class LGButton: UIControl {
    
    enum TouchAlphaValues : CGFloat {
        case touched = 0.7
        case untouched = 1.0
    }
    
    let touchDisableRadius : CGFloat = 100.0
    
    private var availableFontIcons: [String: IconFont] = ["fa": Fonts.awesome,
                                                          "io": Fonts.ion,
                                                          "oc": Fonts.oct,
                                                          "ic": Fonts.ic,
                                                          "ma": Fonts.material,
                                                          "ti": Fonts.themify,
                                                          "mi": Fonts.map]
    
    fileprivate var gradient : CAGradientLayer?
    
    fileprivate var rootView : UIView!
    @IBOutlet fileprivate weak var titleLbl: UILabel!
    @IBOutlet fileprivate weak var mainStackView: UIStackView!
    
    @IBOutlet fileprivate weak var bgContentView: UIView!
    @IBOutlet fileprivate weak var leftIcon: UILabel!
    @IBOutlet fileprivate weak var leftImage: UIImageView!
    @IBOutlet fileprivate weak var rightIcon: UILabel!
    @IBOutlet fileprivate weak var rightImage: UIImageView!
    
    @IBOutlet fileprivate weak var trailingMainConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var leadingMainConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var bottomMainConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var topMainConstraint: NSLayoutConstraint!
    
    @IBOutlet fileprivate weak var leftImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var leftImageWidthConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var rightImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var rightImageWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet fileprivate weak var loadingStackView: UIStackView!
    @IBOutlet fileprivate weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet fileprivate weak var loadingLabel: UILabel!
    @IBOutlet fileprivate var trailingLoadingConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate var leadingLoadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bgContentWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bgContentHeightConstraint: NSLayoutConstraint!
    
    public var isLoading = false {
        didSet {
            showLoadingView()
        }
    }
    
    // MARK: - Inspectable properties
    // MARK:
    
    @IBInspectable public var bgColor: UIColor = UIColor.gray {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var showTouchFeedback: Bool = true
    
    @IBInspectable public var gradientStartColor: UIColor? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var gradientEndColor: UIColor? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var gradientHorizontal: Bool = false {
        didSet{
            if gradient != nil {
                gradient?.removeFromSuperlayer()
                gradient = nil
                setupView()
            }
        }
    }
    
    @IBInspectable public var gradientRotation: CGFloat = 0 {
        didSet{
            if gradient != nil {
                gradient?.removeFromSuperlayer()
                gradient = nil
                setupView()
            }
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var fullyRoundedCorners: Bool = false {
        didSet{
            setupBorderAndCorners()
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var titleColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var titleString: String = "" {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var titleFontName: String? {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var titleFontSize: CGFloat = 14.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var titleNumOfLines: Int = 1 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var verticalOrientation: Bool = false {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable public var leftIconString: String = "" {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var leftIconFontName: String = " " {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var leftIconFontSize: CGFloat = 14.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var leftIconColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var leftImageSrc: UIImage? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var leftImageWidth: CGFloat = 20 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var leftImageHeight: CGFloat = 20 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var leftImageColor: UIColor? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var rightIconString: String = "" {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var rightIconFontName: String = " " {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var rightIconFontSize: CGFloat = 14.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var rightIconColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var rightImageSrc: UIImage? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var rightImageWidth: CGFloat = 20 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var rightImageHeight: CGFloat = 20 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var rightImageColor: UIColor? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var spacingTitleIcon: CGFloat = 16.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var spacingTop: CGFloat = 8.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var spacingBottom: CGFloat = 8.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var spacingLeading: CGFloat = 16.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var spacingTrailing: CGFloat = 16.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize = CGSize.init(width:0, height:0) {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var shadowOpacity: CGFloat = 1 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var shadowColor: UIColor = UIColor.black {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var loadingSpinnerColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var loadingColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var loadingString: String = "" {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var loadingFontName: String? {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var loadingFontSize: CGFloat = 14.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var leftAligned: Bool = false {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var rightAligned: Bool = false {
        didSet{
            setupView()
        }
    }
    
    // MARK: - Standard Properties
    // MARK:
    public var attributedString: NSAttributedString? {
        didSet {
            titleLbl.attributedText = attributedString
        }
    }
    
    // MARK: - Overrides
    // MARK:
    override init(frame: CGRect) {
        super.init(frame: frame)
        registIconFont()
        xibSetup()
        setupView()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        registIconFont()
        xibSetup()
        setupView()
    }
    
    override open func layoutSubviews() {
        if gradient != nil {
            gradient?.removeFromSuperlayer()
            gradient = nil
            setupGradientBackground()
        }
        setupBorderAndCorners()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
        setupView()
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        setupView()
    }
    
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: 10, height: 10)
    }
    
    // MARK: - Internal functions
    // MARK:
    
    // Setup the view appearance
    fileprivate func setupView(){
        bgContentView.clipsToBounds = true
        layer.masksToBounds = false
        setIconOrientation()
        setupTitle()
        setupBackgroundColor()
        setupGradientBackground()
        setupBorderAndCorners()
        setupLeftIcon()
        setupRightIcon()
        setupLeftImage()
        setupRightImage()
        setupSpacings()
        setupShadow()
        setupLoadingView()
        setupAlignment()
    }
    
    fileprivate func registIconFont() {
        for (key, value) in self.availableFontIcons {
            SwiftIconFont.registFont(from: value, name: key)
        }
    }
    
    fileprivate func setIconOrientation() {
        if verticalOrientation {
            mainStackView.axis = .vertical
        }else{
            mainStackView.axis = .horizontal
        }
    }
    
    fileprivate func setupBackgroundColor() {
        bgContentWidthConstraint.constant = min(0, -borderWidth)
        bgContentHeightConstraint.constant = min(0, -borderWidth)
        bgContentView.backgroundColor = bgColor
    }
    
    fileprivate func setupGradientBackground() {
        if gradientStartColor != nil && gradientEndColor != nil && gradient == nil{
            gradient = CAGradientLayer()
            gradient!.frame.size = frame.size
            gradient!.colors = [gradientStartColor!.cgColor, gradientEndColor!.cgColor]
            
            var rotation:CGFloat!
            if gradientRotation >= 0 {
                rotation = min(gradientRotation, CGFloat(360.0))
            } else {
                rotation = max(gradientRotation, CGFloat(-360.0))
            }
            var xAngle:Float = Float(rotation/360)
            if (gradientHorizontal) {
                xAngle = 0.25
            }
            let a = pow(sinf((2*Float(Double.pi)*((xAngle+0.75)/2))),2)
            let b = pow(sinf((2*Float(Double.pi)*((xAngle+0.0)/2))),2)
            let c = pow(sinf((2*Float(Double.pi)*((xAngle+0.25)/2))),2)
            let d = pow(sinf((2*Float(Double.pi)*((xAngle+0.5)/2))),2)
            gradient!.startPoint = CGPoint(x: CGFloat(a), y: CGFloat(b))
            gradient!.endPoint = CGPoint(x: CGFloat(c), y: CGFloat(d))
            
            bgContentView.layer.addSublayer(gradient!)
        }
    }
    
    fileprivate func setupBorderAndCorners() {
        if fullyRoundedCorners {
            bgContentView.layer.cornerRadius = frame.size.height/2
            layer.cornerRadius = frame.size.height/2
        }else{
            bgContentView.layer.cornerRadius = cornerRadius
            layer.cornerRadius = cornerRadius
        }
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    fileprivate func setupTitle() {
        titleLbl.isHidden = titleString.isEmpty
        titleLbl.numberOfLines = titleNumOfLines
        titleLbl.text = titleString
        titleLbl.textColor = titleColor
        if titleFontName != nil {
            titleLbl.font = UIFont.init(name:titleFontName! , size:titleFontSize)
        }else{
            titleLbl.font = UIFont.systemFont(ofSize: titleFontSize)
        }
    }
    
    fileprivate func setupLeftIcon(){
        setupIcon(icon: leftIcon,
                  fontName: leftIconFontName,
                  iconName: leftIconString,
                  fontSize: leftIconFontSize,
                  color: leftIconColor)
    }
    
    fileprivate func setupRightIcon(){
        setupIcon(icon: rightIcon,
                  fontName: rightIconFontName,
                  iconName: rightIconString,
                  fontSize: rightIconFontSize,
                  color: rightIconColor)
    }
    
    fileprivate func setupLeftImage(){
        setupImage(imageView: leftImage,
                   image: leftImageSrc,
                   color: leftImageColor,
                   widthConstraint: leftImageWidthConstraint,
                   heightConstraint: leftImageHeightConstraint,
                   widthValue: leftImageWidth,
                   heightValue: leftImageHeight)
        leftIcon.isHidden =  (leftImageSrc != nil || !(SwiftIconFont.fonts[leftIconFontName] != nil))
    }
    
    fileprivate func setupRightImage(){
        rightIcon.isHidden =  rightImageSrc != nil
        setupImage(imageView: rightImage,
                   image: rightImageSrc,
                   color: rightImageColor,
                   widthConstraint: rightImageWidthConstraint,
                   heightConstraint: rightImageHeightConstraint,
                   widthValue: rightImageWidth,
                   heightValue: rightImageHeight)
        rightIcon.isHidden =  (rightImageSrc != nil || !(SwiftIconFont.fonts[rightIconFontName] != nil))
    }
    
    fileprivate func setupSpacings(){
        mainStackView.spacing = spacingTitleIcon
        topMainConstraint.constant = spacingTop
        bottomMainConstraint.constant = spacingBottom
        leadingMainConstraint.constant = spacingLeading
        trailingMainConstraint.constant = spacingTrailing
        setupBorderAndCorners()
    }
    
    fileprivate func setupShadow(){
        if shadowRadius > 0 {
            layer.shadowOffset = shadowOffset
            layer.shadowRadius = shadowRadius
            layer.shadowOpacity = Float(shadowOpacity)
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    fileprivate func setupLoadingView(){
        loadingLabel.isHidden = loadingString.isEmpty
        loadingLabel.text = loadingString
        loadingLabel.textColor = loadingColor
        if loadingFontName != nil {
            loadingLabel.font = UIFont.init(name:loadingFontName! , size:titleFontSize)
        }else{
            loadingLabel.font = UIFont.systemFont(ofSize: loadingFontSize)
        }
        loadingSpinner.color = loadingSpinnerColor
        setupBorderAndCorners()
    }
    
    fileprivate func setupAlignment() {
        if leftAligned {
            titleLbl.textAlignment = .left
        } else if rightAligned {
            titleLbl.textAlignment = .right
        } else {
            titleLbl.textAlignment = .center
        }
    }
    
    fileprivate func setupIcon(icon:UILabel, fontName:String, iconName:String, fontSize:CGFloat, color:UIColor){
        defer {
            setupBorderAndCorners()
        }
        if let iconFont = SwiftIconFont.fonts[fontName] {
            icon.isHidden = false
            icon.textColor = color
            icon.font = UIFont.icon(from: iconFont, ofSize: fontSize)
            if let iconStr = String.getIcon(from: iconFont, code: iconName) {
                icon.text = iconStr
            }else{
                let joind = ["-", ".", "_"]
                for left in joind {
                    for right in joind {
                        if left == right { continue }
                        let code = iconName.replacingOccurrences(of: left, with: right)
                        if let iconStr = String.getIcon(from: iconFont, code: code) {
                            icon.text = iconStr
                            return
                        }
                    }
                }
            }
        }else{
            icon.isHidden = true
        }
    }
    
    fileprivate func setupImage(imageView:UIImageView, image:UIImage?, color:UIColor?, widthConstraint:NSLayoutConstraint, heightConstraint:NSLayoutConstraint, widthValue:CGFloat, heightValue:CGFloat){
        imageView.isHidden = image == nil
        if image != nil {
            if color != nil {
                imageView.image = image?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = color
            }else{
                image?.withRenderingMode(.alwaysOriginal)
                imageView.image = image
            }
            widthConstraint.constant = widthValue
            heightConstraint.constant = heightValue
        }
        setupBorderAndCorners()
    }
    
    fileprivate func showLoadingView() {
        leadingLoadingConstraint.isActive = isLoading
        trailingLoadingConstraint.isActive = isLoading
        mainStackView.isHidden = isLoading
        loadingStackView.isHidden = !isLoading
        isUserInteractionEnabled = !isLoading
    }
    
    // MARK: - Xib file
    // MARK:
    fileprivate func xibSetup() {
        guard rootView == nil else { return }
        rootView = loadViewFromNib()
        rootView.frame = bounds
        rootView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(rootView)
        leadingLoadingConstraint.isActive = false
        trailingLoadingConstraint.isActive = false
    }
    
    fileprivate func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LGButton", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    // MARK: - Touches
    // MARK:
    var touchAlpha : TouchAlphaValues = .untouched {
        didSet {
            updateTouchAlpha()
        }
    }
    
    var pressed : Bool = false {
        didSet {
            if !showTouchFeedback {
                return
            }
            touchAlpha = (pressed) ? .touched : .untouched
        }
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        pressed = true
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        if pressed {
            sendActions(for: .touchUpInside)
        }
        pressed = false
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        if let touchLoc = touches.first?.location(in: self){
            if (touchLoc.x < -touchDisableRadius ||
                touchLoc.y < -touchDisableRadius ||
                touchLoc.x > self.bounds.size.width + touchDisableRadius ||
                touchLoc.y > self.bounds.size.height + touchDisableRadius){
                pressed = false
            }
            else if self.touchAlpha == .untouched {
                pressed = true
            }
        }
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        pressed = false
    }
    
    func updateTouchAlpha() {
        if self.alpha != self.touchAlpha.rawValue {
            UIView.animate(withDuration: 0.3) {
                self.alpha = self.touchAlpha.rawValue
            }
        }
    }
    
    @IBAction func tapAction(_ sender: Any) {
        sendActions(for: .touchUpInside)
        if !isLoading {
            pressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.pressed = false
            }
        }
    }
}
