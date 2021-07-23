import AVFoundation

class Synth {
    
    // MARK: Properties
    
    public static let shared = Synth()
    public var frequency: Float = 440
    public var noteArray: [synthNote] = []
    private var time: Float = 0{
        didSet{
//            print(time)
        }
    }
    private let sampleRate: Double
    private let deltaTime: Float
    private var signal: Signal
    
    
    private var audioEngine: AVAudioEngine = AVAudioEngine()
    
    public var volume: Float {
        set {
            audioEngine.mainMixerNode.outputVolume = newValue
        }
        get {
            audioEngine.mainMixerNode.outputVolume
        }
    }
    
    private lazy var sourceNode = AVAudioSourceNode { _, _, frameCount, audioBufferList in
        let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
        var noteArray = self.noteArray
        //let localFrequency = self.frequency
        //let period = 1 / localFrequency
        let fractionValue = 1.0/Float(noteArray.count)
//        print("++++++++++++++++++++++++++++")
        for frame in 0..<Int(frameCount) {
            var sampleVal: Float = 0.0
            for index in 0..<(noteArray.count){
                let localFrequency = noteArray[index].frequency
                noteArray[index].period = 1 / localFrequency
                let percentComplete = noteArray[index].time / noteArray[index].period
                let sample = self.signal(localFrequency * percentComplete, noteArray[index].time)
                sampleVal += sampleVal + Float(sample * fractionValue)
//               self.time += self.deltaTime
               //print("time: ", self.time)
//                self.time = fmod(self.time, noteArray[index].period)
                
                noteArray[index].time += self.deltaTime
                //print("noteArray: ", noteArray[index].time)
                noteArray[index].time = fmod(noteArray[index].time, noteArray[index].period)
            }
        for buffer in ablPointer {
                let buf: UnsafeMutableBufferPointer<Float> = UnsafeMutableBufferPointer(buffer)
                buf[frame] = sampleVal
            }
        }
        for (i, n) in noteArray.enumerated(){
            if var obj: synthNote = self.noteArray.objectAt(i) {
                obj.time = n.time
//                self.noteArray[i].time = n.time
            }
        }
        //for loop and given the time of note Arra
        //self.noteArray = noteArray
        return noErr
    }
    
    // MARK: Init
    
    init(signal: @escaping Signal = Oscillator.sine) {
        //audioEngine = AVAudioEngine()
        
        let mainMixer = audioEngine.mainMixerNode
        let outputNode = audioEngine.outputNode
        let format = outputNode.inputFormat(forBus: 0)
        
        sampleRate = format.sampleRate
        deltaTime = 1 / Float(sampleRate)
        
        self.signal = signal
        
        let inputFormat = AVAudioFormat(commonFormat: format.commonFormat,
                                        sampleRate: format.sampleRate,
                                        channels: 1,
                                        interleaved: format.isInterleaved)
        
        audioEngine.attach(sourceNode)
        audioEngine.connect(sourceNode, to: mainMixer, format: inputFormat)
        audioEngine.connect(mainMixer, to: outputNode, format: nil)
        
        
        do {
            try audioEngine.start()
        } catch {
            print("Could not start engine: \(error.localizedDescription)")
        }
        mainMixer.outputVolume = 0.5
        
    }
    
    // MARK: Public Functions
    
    public func setWaveformTo(_ signal: @escaping Signal) {
        self.signal = signal
    }
    
    //MARK: Start/End A Key
    func start(){
        audioEngine.startNote()
    }
    
//    func objectAt<T>(_ index: Int) -> T? {
//        if count > 0 && (index >= 0 || index < count) {
//            return self[index] as? T
//        }
//        return nil
//    }
    func sustainStop(key: Key){
        print("new sustain stop called ", key.frequency)
        var isKeyStopped: Bool = false
        for (index, synth) in noteArray.enumerated() {
            if(synth.frequency == key.frequency){
                noteArray.remove(at: index)
                isKeyStopped = true
                break
            }
        }
        
        print("isKeyStopped: ", isKeyStopped)
        
        //for index in 0..<(noteArray.count)
//        for index in 0..<(noteArray.count){
//            print(index)
//            //guard var notification: NotificationData = notificationArr?.objectAt(row) else { return }
//            if let synth: synthNote = noteArray.objectAt(index) {
//                if(synth.frequency == key.frequency){
//                    noteArray.remove(at: index)
//                }
//            }
//            if(noteArray[index].frequency == key.frequency){
//                noteArray.remove(at: index)
//            }
//        }
        if(noteArray.count == 0){
            audioEngine.stop()
        }
    }
    func stopAll(){
    for index in 0..<(noteArray.count){
        noteArray.remove(at: index)
        }
        audioEngine.stop()
    }
}
