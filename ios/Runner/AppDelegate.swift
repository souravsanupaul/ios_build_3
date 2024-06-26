import UIKit
import Flutter
import UIKit
import CoreMedia
import GSPlayer


protocol fullScreeenDelegate: class {
    func fullScreenTap()
    func normalScreenTap()
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var myOrientation: UIInterfaceOrientationMask = .portrait
    

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    
            GeneratedPluginRegistrant.register(with: self)

      weak var registrar = self.registrar(forPlugin: "ima_sdk")

      let factory = NativeViewFactory(messenger: registrar!.messenger())
      registrar!.register(
          factory,
          withId: "NativeUI")
  
return super.application(application, didFinishLaunchingWithOptions: launchOptions)
      
  }
    override func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return myOrientation
        }
    
}


@IBDesignable
class GSPlayerControlUIView: UIView {
    
    // MARK: IBOutlet
    @IBOutlet weak var play_Button: UIButton!
    @IBOutlet weak var duration_Slider: UISlider!
    @IBOutlet weak var currentDuration_Label: UILabel!
    @IBOutlet weak var totalDuration_Label: UILabel!
    @IBOutlet weak var fullscreen_Button : UIButton!
    
    weak var delegate: fullScreeenDelegate?
    var isFullScreen = false

    
    // MARK: Variables
    private var videoPlayer: VideoPlayerView!
    
    // MARK: Listeners
    var onStateDidChanged: ((VideoPlayerView.State) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.commonInit()
    }
    
    func commonInit() {
        guard let view = Bundle(for: GSPlayerControlUIView.self).loadNibNamed("GSPlayerControlUIView", owner: self, options: nil)?.first as? UIView else { return }
        
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.isUserInteractionEnabled = false
        
        self.addSubview(view)
    }
}

// MARK: Functions
extension GSPlayerControlUIView {
    
    func populate(with videoPlayer: VideoPlayerView) {
        self.videoPlayer = videoPlayer
        self.isUserInteractionEnabled = true
        
        setPeriodicTimer()
        setOnClicked_VideoPlayer()
        setStateDidChangedListener()
        
        duration_Slider.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapSlider(_:))))
    }
    
    private func setStateDidChangedListener()  {
        videoPlayer.stateDidChanged = { [weak self] state in
            guard let self = self else { return }
            
            if case .playing = state {
                self.setOnStartPlaying()
            }
                
            switch state {
            case .playing, .paused: self.duration_Slider.isEnabled = true
            default: self.duration_Slider.isEnabled = false
            }
                
            self.play_Button.setImage(state == .playing ? UIImage(named: "pause_48px") : UIImage(named: "play_48px"), for: .normal)
                
            if let listener = self.onStateDidChanged { listener(state) }
        }
        
        videoPlayer.replay = { [weak self] in
            if self != nil
            {
                self!.currentDuration_Label.text = "00:00"
                self!.duration_Slider.setValue(0, animated: false)
            }
        }
    }
    
    private func setOnStartPlaying() {
        let totalDuration = videoPlayer.totalDuration
        
        duration_Slider.maximumValue = Float(totalDuration)
        totalDuration_Label.text = getTimeString(seconds: Int(totalDuration))
    }
    
    private func setPeriodicTimer() {
        videoPlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 60), using: { [weak self] _ in
            if self != nil
            {
                let currentDuration = self!.videoPlayer.currentDuration
                self!.currentDuration_Label.text = self!.getTimeString(seconds: Int(currentDuration))
                self!.duration_Slider.setValue(Float(currentDuration), animated: true)
            }
        })
    }
    
    private func getTimeString(seconds: Int) -> String {
        String(format: "%02d:%02d", seconds / 60, seconds % 60)
    }
}

// MARK: onClicked
extension GSPlayerControlUIView {
    
    @IBAction func onClicked_Play(_ sender: Any) {
        if (videoPlayer.state == .playing) {
            videoPlayer.pause(reason: .userInteraction)
        } else {
            videoPlayer.resume()
        }
    }
    
    @IBAction func onClicked_Backward(_ sender: Any) {
        videoPlayer.seek(to: CMTime(seconds: Double(max(videoPlayer.currentDuration - 10, 0)), preferredTimescale: 60))
    }
    
    @IBAction func onClicked_Forward(_ sender: Any) {
        videoPlayer.seek(to: CMTime(seconds: Double(min(videoPlayer.currentDuration + 10, videoPlayer.totalDuration)), preferredTimescale: 60))
    }
    
    @IBAction func onClicked_FullScreen(_ sender: Any) {
        
        if isFullScreen == false{
        delegate?.fullScreenTap()
            isFullScreen = true
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.myOrientation = .landscapeLeft
                   UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
                    UIView.setAnimationsEnabled(true)
            self.fullscreen_Button.setImage(UIImage(named: "normal_screen"), for: .normal)
        }else{
            isFullScreen = false
            delegate?.normalScreenTap()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.myOrientation = .portrait
            self.fullscreen_Button.setImage(UIImage(named: "full_screen"), for: .normal)
        }
        
        
    }
    

    
    private func setOnClicked_VideoPlayer() {
        videoPlayer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClicked_Video(_:))))
    }
    
    @IBAction func onClicked_Video(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.alpha = self.alpha == 0 ? 1 : 0
        }
    }
    
    @IBAction func tapSlider(_ gestureRecognizer: UIGestureRecognizer) {
        let pointTapped: CGPoint = gestureRecognizer.location(in: self)
        
        let positionOfSlider: CGPoint = duration_Slider.frame.origin
        let widthOfSlider: CGFloat = duration_Slider.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(duration_Slider.maximumValue) / widthOfSlider)
        
        duration_Slider.setValue(Float(newValue), animated: false)
        onValueChanged_DurationSlider(duration_Slider)
    }
    
    @IBAction func onValueChanged_DurationSlider(_ sender: UISlider) {
        videoPlayer.seek(to: CMTime(seconds: Double(sender.value), preferredTimescale: 60))
    }
}
