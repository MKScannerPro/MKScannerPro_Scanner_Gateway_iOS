#
# Be sure to run `pod lib lint MKScannerPro.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKScannerPro'
  s.version          = '1.0.0'
  s.summary          = 'A short description of MKScannerPro.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/MKScannerPro/MKScannerPro_iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aadyx2007@163.com' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/MKScannerPro/MKScannerPro_iOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'MKScannerPro/Classes/**/*'
  
  s.resource_bundles = {
    'MKScannerPro' => ['MKScannerPro/Assets/*.png']
  }

  s.subspec 'ApplicationModule' do |ss|
    ss.source_files = 'MKScannerPro/Classes/ApplicationModule/**'
    
    ss.dependency 'MKBaseModuleLibrary'
  end
  
  s.subspec 'CTMediator' do |ss|
    ss.source_files = 'MKScannerPro/Classes/CTMediator/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'CTMediator'
  end
  
  s.subspec 'Target' do |ss|
    ss.source_files = 'MKScannerPro/Classes/Target/**'
  end
  
  s.subspec 'DatabaseManager' do |ss|
    
    ss.source_files = 'MKScannerPro/Classes/DatabaseManager/**'
    
    ss.dependency 'FMDB'
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKScannerPro/DeviceModel'
    
  end
  
  s.subspec 'DeviceModel' do |ss|
    ss.source_files = 'MKScannerPro/Classes/DeviceModel/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKScannerPro/ServerManager'
  end
  
  s.subspec 'SDK' do |ss|
  
    ss.subspec 'BLE' do |sss|
      sss.source_files = 'MKScannerPro/Classes/SDK/BLE/**'
      
      sss.dependency 'MKBaseBleModule'
    end
    
    ss.subspec 'MQTT' do |sss|
      sss.source_files = 'MKScannerPro/Classes/SDK/MQTT/**'
      
      ss.dependency 'MKBaseModuleLibrary'
      ss.dependency 'MKBaseMQTTModule'
    end
  
  end
  
  s.subspec 'ServerManager' do |ss|
    ss.source_files = 'MKScannerPro/Classes/ServerManager/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKScannerPro/SDK/MQTT'
  end
  
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'ConnectionSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/ConnectionSettingPage/Controller/**'
      end
    end
    
    ss.subspec 'ConnectSuccessPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/ConnectSuccessPage/Controller/**'
      end
    end
    
    ss.subspec 'DataReportingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/DataReportingPage/Controller/**'
      end
    end
    
    ss.subspec 'DeviceDataPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/DeviceDataPage/Controller/**'
      
        ssss.dependency 'MKScannerPro/Functions/DeviceDataPage/View'
        
        ssss.dependency 'MKScannerPro/Functions/SettingPage/Controller'
        ssss.dependency 'MKScannerPro/Functions/UploadOptionPage/Controller'
      end
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/DeviceDataPage/View/**'
      end
    end
    
    ss.subspec 'DeviceInfoPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/DeviceInfoPage/Controller/**'
      end
    end
    
    ss.subspec 'DeviceListPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/DeviceListPage/Controller/**'
      
        ssss.dependency 'MKScannerPro/Functions/DeviceListPage/View'
        
        ssss.dependency 'MKScannerPro/Functions/ServerForAPP/Controller'
        ssss.dependency 'MKScannerPro/Functions/ScanPage/Controller'
        ssss.dependency 'MKScannerPro/Functions/DeviceDataPage/Controller'
      end
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/DeviceListPage/View/**'
      end
    end
    
    ss.subspec 'DuplicateDataFilterPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/DuplicateDataFilterPage/Controller/**'
      
        ssss.dependency 'MKScannerPro/Functions/DuplicateDataFilterPage/Model'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/DuplicateDataFilterPage/Model/**'
      end
    end
    
    ss.subspec 'FilterConditionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/FilterConditionPage/Controller/**'
      
        ssss.dependency 'MKScannerPro/Functions/FilterConditionPage/Model'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/FilterConditionPage/Model/**'
      end
    end
    
    ss.subspec 'LEDSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/LEDSettingPage/Controller/**'
      end
    end
    
    ss.subspec 'MQTTSettingForDevicePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/MQTTSettingForDevicePage/Controller/**'
      
        ssss.dependency 'MKScannerPro/Functions/MQTTSettingForDevicePage/View'
      end
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/MQTTSettingForDevicePage/View/**'
      end
    end
    
    ss.subspec 'NetworkStatusPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/NetworkStatusPage/Controller/**'
      end
    end
    
    ss.subspec 'OTAPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/OTAPage/Controller/**'
      end
    end
    
    ss.subspec 'ScanPage' do |sss|
      
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/ScanPage/Controller/**'
        
        ssss.dependency 'MKScannerPro/Functions/ScanPage/Model'
        ssss.dependency 'MKScannerPro/Functions/ScanPage/View'
        
        ssss.dependency 'MKScannerPro/Functions/ServerForDevice/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/ScanPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/ScanPage/View/**'
        
        ssss.dependency 'MKScannerPro/Functions/ScanPage/Model'
      end
      
    end
    
    ss.subspec 'ScanTimeoutOptionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/ScanTimeoutOptionPage/Controller/**'
      end
    end
    
    ss.subspec 'ServerForAPP' do |sss|
      
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/ServerForAPP/Controller/**'
        
        ssss.dependency 'MKScannerPro/Functions/ServerForAPP/Model'
        ssss.dependency 'MKScannerPro/Functions/ServerForAPP/View'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/ServerForAPP/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/ServerForAPP/View/**'
      end
      
    end
    
    ss.subspec 'ServerForDevice' do |sss|
      
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/ServerForDevice/Controller/**'
        
        ssss.dependency 'MKScannerPro/Functions/ServerForDevice/Model'
        ssss.dependency 'MKScannerPro/Functions/ServerForDevice/View'
        
        ssss.dependency 'MKScannerPro/Functions/ConnectSuccessPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/ServerForDevice/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/ServerForDevice/View/**'
      end
      
    end
  
  
    ss.subspec 'SettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/SettingPage/Controller/**'
        
        ssss.dependency 'MKScannerPro/Functions/DeviceInfoPage/Controller'
        ssss.dependency 'MKScannerPro/Functions/MQTTSettingForDevicePage/Controller'
        ssss.dependency 'MKScannerPro/Functions/LEDSettingPage/Controller'
        ssss.dependency 'MKScannerPro/Functions/DataReportingPage/Controller'
        ssss.dependency 'MKScannerPro/Functions/NetworkStatusPage/Controller'
        ssss.dependency 'MKScannerPro/Functions/SystemTimePage/Controller'
        ssss.dependency 'MKScannerPro/Functions/OTAPage/Controller'
        ssss.dependency 'MKScannerPro/Functions/ConnectionSettingPage/Controller'
        ssss.dependency 'MKScannerPro/Functions/ScanTimeoutOptionPage/Controller'
      end
    end
    
    ss.subspec 'SystemTimePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/SystemTimePage/Controller/**'
      end
    end
    
    ss.subspec 'TypeFilterPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/TypeFilterPage/Controller/**'
      
        ssss.dependency 'MKScannerPro/Functions/TypeFilterPage/Model'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/TypeFilterPage/Model/**'
      end
    end
    
    ss.subspec 'UploadDataOptionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/UploadDataOptionPage/Controller/**'
      
        ssss.dependency 'MKScannerPro/Functions/UploadDataOptionPage/Model'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/UploadDataOptionPage/Model/**'
      end
    end
    
    ss.subspec 'UploadOptionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/UploadOptionPage/Controller/**'
      
        ssss.dependency 'MKScannerPro/Functions/UploadOptionPage/Model'
        
        ssss.dependency 'MKScannerPro/Functions/TypeFilterPage/Controller'
        ssss.dependency 'MKScannerPro/Functions/FilterConditionPage/Controller'
        ssss.dependency 'MKScannerPro/Functions/DuplicateDataFilterPage/Controller'
        ssss.dependency 'MKScannerPro/Functions/UploadDataOptionPage/Controller'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKScannerPro/Classes/Functions/UploadOptionPage/Model/**'
      end
    end
  
    ss.dependency 'MKScannerPro/DeviceModel'
    ss.dependency 'MKScannerPro/DatabaseManager'
    ss.dependency 'MKScannerPro/SDK'
    ss.dependency 'MKScannerPro/ServerManager'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'MLInputDodger'
  
  end
  
end
