
import UIKit
import CoreMotion



public class Sensors {


  var motionMngr: CMMotionManager
 
  public init() {
    motionMngr = CMMotionManager()
  }
  
  
  // ------------ START READING ------------
  public func startAll(interval: Double){
    if motionMngr.isAccelerometerAvailable {
       motionMngr.accelerometerUpdateInterval = interval
       motionMngr.startAccelerometerUpdates()
     }
     
     if motionMngr.isGyroAvailable {
       motionMngr.gyroUpdateInterval = interval
       motionMngr.startGyroUpdates()
     }
     
     if motionMngr.isMagnetometerAvailable{
       motionMngr.magnetometerUpdateInterval = interval
       motionMngr.startMagnetometerUpdates()
     }
     
     if motionMngr.isDeviceMotionAvailable{
       motionMngr.deviceMotionUpdateInterval = interval
       motionMngr.startDeviceMotionUpdates()
     }
  }
  
  
  // ------------ STOP READING ------------
  public func stopAll(){
    if motionMngr.isAccelerometerActive {
       motionMngr.stopAccelerometerUpdates()
     }
     
     if motionMngr.isGyroActive {
       motionMngr.stopGyroUpdates()
     }
     
     if motionMngr.isMagnetometerActive{
       motionMngr.stopMagnetometerUpdates()
     }
     
    if motionMngr.isDeviceMotionActive{
       motionMngr.stopDeviceMotionUpdates()
     }
  }
  
  
  // ------------ GET FRESH SENSOR VALUES IN JSON FORMAT ------------
  public func getValues(enAcc: Bool, enGyro: Bool, enMag: Bool, enMot: Bool) -> Any{
    
    var params: [String: Dictionary<String, String>] = [:]
    
    
    if(enAcc){
      if let data = motionMngr.accelerometerData {
         let x = data.acceleration.x
         let y = data.acceleration.y
         let z = data.acceleration.z
        params["ACCEL"] = [
          "x" : String(x),
          "y" : String(y),
          "z" : String(z)
        ]
      }
    }
    
    if(enGyro){
      if let data = motionMngr.gyroData {
        let x = data.rotationRate.x
        let y = data.rotationRate.y
        let z = data.rotationRate.z
        params["GYRO"] = [
          "x" : String(x),
          "y" : String(y),
          "z" : String(z)
        ]
      }
    }
    
    if(enMag){
      if let data = motionMngr.magnetometerData {
        let x = data.magneticField.x
        let y = data.magneticField.y
        let z = data.magneticField.z
        params["MAG"] = [
          "x" : String(x),
          "y" : String(y),
          "z" : String(z)
        ]
      }
    }
 
    
    if(enMot){
      if let data = motionMngr.deviceMotion {
        
        var heading: String
        
        if #available(iOS 13, *){
          heading = String(data.heading)
        }
        else{
          heading = "unavailable"
        }
        
        params["MOTION"] = [
          "attitude_pitch"        : String(data.attitude.pitch),
          "attitude_roll"         : String(data.attitude.roll),
          "attitude_yaw"          : String(data.attitude.yaw),
          "gravity_x"             : String(data.gravity.x),
          "gravity_y"             : String(data.gravity.y),
          "gravity_z"             : String(data.gravity.z),
          "heading"               : heading,
          "magnetic_field_x"      : String(data.magneticField.field.x),
          "magnetic_field_y"      : String(data.magneticField.field.y),
          "magnetic_field_z"      : String(data.magneticField.field.z),
          "magnetic_field_accu"   : String(data.magneticField.accuracy.rawValue),
          "rotation_rate_x"       : String(data.rotationRate.x),
          "rotation_rate_y"       : String(data.rotationRate.y),
          "rotation_rate_z"       : String(data.rotationRate.z),
          "user_acceleration_x"   : String(data.userAcceleration.x),
          "user_acceleration_y"   : String(data.userAcceleration.y),
          "user_acceleration_z"   : String(data.userAcceleration.z),
        ]
      }
    }
    
    return params
  
  }
  
}


