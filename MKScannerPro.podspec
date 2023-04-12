#
# Be sure to run `pod lib lint MKScannerPro.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKScannerPro'
  s.version          = '2.1.1'
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
  
  s.resource_bundles = {
    'MKScannerPro' => ['MKScannerPro/Assets/*.png']
  }
  
  s.subspec 'Expand' do |ss|
    
    ss.subspec 'DatabaseManager' do |sss|
      sss.source_files = 'MKScannerPro/Classes/Expand/DatabaseManager/**'
      
      sss.dependency 'FMDB'
    end
    
    ss.subspec 'BaseController' do |sss|
      sss.source_files = 'MKScannerPro/Classes/Expand/BaseController/**'
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKScannerPro/DeviceModel'
    ss.dependency 'MKCustomUIModule'
    
  end
  
  s.subspec 'DeviceModel' do |ss|
    ss.source_files = 'MKScannerPro/Classes/DeviceModel/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKScannerPro/SDK/MQTT'
  end
  
  s.subspec 'CTMediator' do |ss|
    ss.source_files = 'MKScannerPro/Classes/CTMediator/**'
      
    ss.dependency 'CTMediator'
    
    ss.dependency 'MKScannerPro/DeviceModel'
  end
  
  s.subspec 'Target' do |ss|
    ss.source_files = 'MKScannerPro/Classes/Target/**'
          
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKScannerPro/Modules'
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
  
  
  s.subspec 'Modules' do |ss|
    
    ss.subspec '107PModule' do |sss|
        sss.subspec 'SDK' do |ssss|
          ssss.subspec 'MQTT' do |sssss|
            sssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/SDK/MQTT/**'
          end
        end
        sss.subspec 'Target' do |ssss|
          ssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Target/**'
          
          ssss.dependency 'MKScannerPro/Modules/107PModule/Functions'
        end
        sss.subspec 'Functions' do |ssss|
          
          ssss.subspec 'DeviceDataPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/DeviceDataPage/Controller/**'
                                
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/SettingPage/Controller'
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/UploadOptionPage/Controller'
              end
          end
          
          ssss.subspec 'DeviceInfoPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/DeviceInfoPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/DeviceInfoPage/Model'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/DeviceInfoPage/Model/**'
              end
          end
          
          ssss.subspec 'DuplicateDataFilterPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/DuplicateDataFilterPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/DuplicateDataFilterPage/Model'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/DuplicateDataFilterPage/Model/**'
              end
          end
          
          ssss.subspec 'ModifyMQTTServerPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/ModifyMQTTServerPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/ModifyMQTTServerPage/Model'
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/ModifyMQTTServerPage/View'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/ModifyMQTTServerPage/View/**'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/ModifyMQTTServerPage/Model/**'
              end
          end
          
          ssss.subspec 'NTPServerPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/NTPServerPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/NTPServerPage/Model'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/NTPServerPage/Model/**'
              end
          end
          
          ssss.subspec 'OTAPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/OTAPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/OTAPage/Model'
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/OTAPage/View'
                
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/SlaveFileSelectPage/Controller'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/OTAPage/View/**'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/OTAPage/Model/**'
                
                ssssss.dependency 'iOSDFULibrary'
              end
          end
          
          ssss.subspec 'ServerForDevice' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/ServerForDevice/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/ServerForDevice/Model'
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/ServerForDevice/View'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/ServerForDevice/View/**'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/ServerForDevice/Model/**'
              end
          end
          
          ssss.subspec 'ServerForDPPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/ServerForDPPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/ServerForDPPage/Model'
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/ServerForDPPage/View'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/ServerForDPPage/View/**'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/ServerForDPPage/Model/**'
              end
          end
          
          ssss.subspec 'SettingPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/SettingPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/SettingPage/Model'
                
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/DeviceInfoPage/Controller'
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/SystemTimePage/Controller'
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/ModifyMQTTServerPage/Controller'
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/OTAPage/Controller'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/SettingPage/Model/**'
              end
          end
          
          ssss.subspec 'SlaveFileSelectPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/SlaveFileSelectPage/Controller/**'
              end
          end
          
          ssss.subspec 'SystemTimePage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/SystemTimePage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/SystemTimePage/View'
                
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/NTPServerPage/Controller'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/SystemTimePage/View/**'
              end
          end
          
          ssss.subspec 'UploadDataOptionPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/UploadDataOptionPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/UploadDataOptionPage/Model'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/UploadDataOptionPage/Model/**'
              end
          end
          
          ssss.subspec 'UploadOptionPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/UploadOptionPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/UploadOptionPage/View'
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/UploadOptionPage/Model'
                
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/UploadDataOptionPage/Controller'
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/DuplicateDataFilterPage/Controller'
                ssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/FilterPages'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/UploadOptionPage/View/**'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/UploadOptionPage/Model/**'
              end
          end
          
          ssss.subspec 'FilterPages' do |sssss|
            
            sssss.subspec 'FilterByAdvNamePage' do |ssssss|
              ssssss.subspec 'Controller' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByAdvNamePage/Controller/**'
                
                sssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/FilterPages/FilterByAdvNamePage/Model'
              end
              ssssss.subspec 'Model' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByAdvNamePage/Model/**'
              end
            end
            
            sssss.subspec 'FilterByBeaconPage' do |ssssss|
              ssssss.subspec 'Controller' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByBeaconPage/Controller/**'
                
                sssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/FilterPages/FilterByBeaconPage/Model'
                sssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/FilterPages/FilterByBeaconPage/Header'
              end
              ssssss.subspec 'Header' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByBeaconPage/Header/**'
              end
              ssssss.subspec 'Model' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByBeaconPage/Model/**'
                
                sssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/FilterPages/FilterByBeaconPage/Header'
              end
            end
            
            sssss.subspec 'FilterByMacPage' do |ssssss|
              ssssss.subspec 'Controller' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByMacPage/Controller/**'
                
                sssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/FilterPages/FilterByMacPage/Model'
              end
              ssssss.subspec 'Model' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByMacPage/Model/**'
              end
            end
            
            sssss.subspec 'FilterByOtherPage' do |ssssss|
              ssssss.subspec 'Controller' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByOtherPage/Controller/**'
                
                sssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/FilterPages/FilterByOtherPage/Model'
              end
              ssssss.subspec 'Model' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByOtherPage/Model/**'
              end
            end
            
            sssss.subspec 'FilterByRawDataPage' do |ssssss|
              ssssss.subspec 'Controller' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByRawDataPage/Controller/**'
                
                sssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/FilterPages/FilterByRawDataPage/Model'
                
                sssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/FilterPages/FilterByBeaconPage/Controller'
                sssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/FilterPages/FilterByUIDPage/Controller'
                sssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/FilterPages/FilterByURLPage/Controller'
                sssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/FilterPages/FilterByTLMPage/Controller'
                sssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/FilterPages/FilterByOtherPage/Controller'
                
              end
              ssssss.subspec 'Model' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByRawDataPage/Model/**'
              end
            end
            
            sssss.subspec 'FilterByTLMPage' do |ssssss|
              ssssss.subspec 'Controller' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByTLMPage/Controller/**'
                
                sssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/FilterPages/FilterByTLMPage/Model'
              end
              ssssss.subspec 'Model' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByTLMPage/Model/**'
              end
            end
            
            sssss.subspec 'FilterByUIDPage' do |ssssss|
              ssssss.subspec 'Controller' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByUIDPage/Controller/**'
                
                sssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/FilterPages/FilterByUIDPage/Model'
              end
              ssssss.subspec 'Model' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByUIDPage/Model/**'
              end
            end
            
            sssss.subspec 'FilterByURLPage' do |ssssss|
              ssssss.subspec 'Controller' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByURLPage/Controller/**'
                
                sssssss.dependency 'MKScannerPro/Modules/107PModule/Functions/FilterPages/FilterByURLPage/Model'
              end
              ssssss.subspec 'Model' do |sssssss|
                sssssss.source_files = 'MKScannerPro/Classes/Modules/107PModule/Functions/FilterPages/FilterByURLPage/Model/**'
              end
            end
            
          end
          
          ssss.dependency 'MKScannerPro/Modules/CommonModule'
          ssss.dependency 'MKScannerPro/Modules/107PModule/SDK'
        end
    end
    
    ss.subspec '107Module' do |sss|
        sss.subspec 'SDK' do |ssss|
          ssss.subspec 'MQTT' do |sssss|
            sssss.source_files = 'MKScannerPro/Classes/Modules/107Module/SDK/MQTT/**'
          end
        end
        sss.subspec 'Target' do |ssss|
          ssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Target/**'
          
          ssss.dependency 'MKScannerPro/Modules/107Module/Functions'
        end
        sss.subspec 'Functions' do |ssss|
          
          ssss.subspec 'DeviceDataPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/DeviceDataPage/Controller/**'
                                
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/SettingPage/Controller'
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/UploadOptionPage/Controller'
              end
          end
          
          ssss.subspec 'DeviceInfoPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/DeviceInfoPage/Controller/**'
              end
          end
          
          ssss.subspec 'DuplicateDataFilterPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/DuplicateDataFilterPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/DuplicateDataFilterPage/Model'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/DuplicateDataFilterPage/Model/**'
              end
          end
          
          ssss.subspec 'FilterConditionPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/FilterConditionPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/FilterConditionPage/Model'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/FilterConditionPage/Model/**'
              end
          end
          
          ssss.subspec 'OTAPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/OTAPage/Controller/**'
              end
          end
          
          ssss.subspec 'ServerForDevice' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/ServerForDevice/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/ServerForDevice/Model'
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/ServerForDevice/View'
                
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/ServerForDevice/View/**'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/ServerForDevice/Model/**'
              end
          end
          
          ssss.subspec 'SettingPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/SettingPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/SettingPage/Model'
                
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/DeviceInfoPage/Controller'
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/SystemTimePage/Controller'
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/OTAPage/Controller'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/SettingPage/Model/**'
              end
          end
          
          ssss.subspec 'SystemTimePage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/SystemTimePage/Controller/**'
              end
          end
          
          ssss.subspec 'TypeFilterPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/TypeFilterPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/TypeFilterPage/Model'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/TypeFilterPage/Model/**'
              end
          end
          
          ssss.subspec 'UploadDataOptionPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/UploadDataOptionPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/UploadDataOptionPage/Model'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/UploadDataOptionPage/Model/**'
              end
          end
          
          ssss.subspec 'UploadOptionPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/UploadOptionPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/UploadOptionPage/Model'
                
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/TypeFilterPage/Controller'
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/FilterConditionPage/Controller'
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/DuplicateDataFilterPage/Controller'
                ssssss.dependency 'MKScannerPro/Modules/107Module/Functions/UploadDataOptionPage/Controller'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/107Module/Functions/UploadOptionPage/Model/**'
              end
          end
          
          ssss.dependency 'MKScannerPro/Modules/CommonModule'
          ssss.dependency 'MKScannerPro/Modules/107Module/SDK'
        end
        
    end
    
    ss.subspec 'MainModule' do |sss|
        sss.subspec 'SDK' do |ssss|
          ssss.source_files = 'MKScannerPro/Classes/Modules/MainModule/SDK/**'
        end
        sss.subspec 'Functions' do |ssss|
          
          ssss.subspec 'DeviceListPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/MainModule/Functions/DeviceListPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/MainModule/Functions/DeviceListPage/View'
                
                ssssss.dependency 'MKScannerPro/Modules/MainModule/Functions/ScanPage/Controller'
                ssssss.dependency 'MKScannerPro/Modules/MainModule/Functions/ServerForAPP/Controller'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/MainModule/Functions/DeviceListPage/View/**'
              end
          end
          
          ssss.subspec 'ScanPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/MainModule/Functions/ScanPage/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/MainModule/Functions/ScanPage/View'
                ssssss.dependency 'MKScannerPro/Modules/MainModule/Functions/ScanPage/Model'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/MainModule/Functions/ScanPage/Model/**'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/MainModule/Functions/ScanPage/View/**'
                ssssss.dependency 'MKScannerPro/Modules/MainModule/Functions/ScanPage/Model'
              end
          end
          
          ssss.subspec 'ServerForAPP' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/MainModule/Functions/ServerForAPP/Controller/**'
                
                ssssss.dependency 'MKScannerPro/Modules/MainModule/Functions/ServerForAPP/View'
                ssssss.dependency 'MKScannerPro/Modules/MainModule/Functions/ServerForAPP/Model'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/MainModule/Functions/ServerForAPP/Model/**'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKScannerPro/Classes/Modules/MainModule/Functions/ServerForAPP/View/**'
              end
          end
          
          ssss.dependency 'MKScannerPro/Modules/MainModule/SDK'
        end
        sss.dependency 'MKScannerPro/Modules/CommonModule'
    end
    
    ss.subspec 'CommonModule' do |sss|
      
      sss.subspec 'Pages' do |ssss|
        
        ssss.subspec 'ConnectionSettingPage' do |sssss|
            sssss.subspec 'Controller' do |ssssss|
              ssssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Pages/ConnectionSettingPage/Controller/**'
              
              ssssss.dependency 'MKScannerPro/Modules/CommonModule/Pages/ConnectionSettingPage/Protocol'
            end
            sssss.subspec 'Protocol' do |ssssss|
              ssssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Pages/ConnectionSettingPage/Protocol/**'
            end
        end
        
        ssss.subspec 'ConnectSuccessPage' do |sssss|
            sssss.subspec 'Controller' do |ssssss|
              ssssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Pages/ConnectSuccessPage/Controller/**'
            end
        end
        
        ssss.subspec 'DataReportingPage' do |sssss|
            sssss.subspec 'Controller' do |ssssss|
              ssssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Pages/DataReportingPage/Controller/**'
              
              ssssss.dependency 'MKScannerPro/Modules/CommonModule/Pages/DataReportingPage/Protocol'
            end
            sssss.subspec 'Protocol' do |ssssss|
              ssssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Pages/DataReportingPage/Protocol/**'
            end
        end
        
        ssss.subspec 'LEDSettingPage' do |sssss|
            sssss.subspec 'Controller' do |ssssss|
              ssssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Pages/LEDSettingPage/Controller/**'
              
              ssssss.dependency 'MKScannerPro/Modules/CommonModule/Pages/LEDSettingPage/Protocol'
            end
            sssss.subspec 'Protocol' do |ssssss|
              ssssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Pages/LEDSettingPage/Protocol/**'
            end
        end
        
        ssss.subspec 'MQTTSettingForDevicePage' do |sssss|
            sssss.subspec 'Controller' do |ssssss|
              ssssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Pages/MQTTSettingForDevicePage/Controller/**'
              
              ssssss.dependency 'MKScannerPro/Modules/CommonModule/Pages/MQTTSettingForDevicePage/Protocol'
              ssssss.dependency 'MKScannerPro/Modules/CommonModule/Pages/MQTTSettingForDevicePage/View'
            end
            sssss.subspec 'Protocol' do |ssssss|
              ssssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Pages/MQTTSettingForDevicePage/Protocol/**'
            end
            sssss.subspec 'View' do |ssssss|
              ssssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Pages/MQTTSettingForDevicePage/View/**'
            end
        end
        
        ssss.subspec 'NetworkStatusPage' do |sssss|
            sssss.subspec 'Controller' do |ssssss|
              ssssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Pages/NetworkStatusPage/Controller/**'
              
              ssssss.dependency 'MKScannerPro/Modules/CommonModule/Pages/NetworkStatusPage/Protocol'
            end
            sssss.subspec 'Protocol' do |ssssss|
              ssssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Pages/NetworkStatusPage/Protocol/**'
            end
        end
        
        ssss.subspec 'ScanTimeoutOptionPage' do |sssss|
            sssss.subspec 'Controller' do |ssssss|
              ssssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Pages/ScanTimeoutOptionPage/Controller/**'
              
              ssssss.dependency 'MKScannerPro/Modules/CommonModule/Pages/ScanTimeoutOptionPage/Protocol'
            end
            sssss.subspec 'Protocol' do |ssssss|
              ssssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Pages/ScanTimeoutOptionPage/Protocol/**'
            end
        end
        
      end
      
      sss.subspec 'Views' do |ssss|
        
        ssss.subspec 'DeviceDataPageView' do |sssss|
          sssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Views/DeviceDataPageView/**'
        end
        
        ssss.subspec 'FilterBeaconCell' do |sssss|
          sssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Views/FilterBeaconCell/**'
        end
        
        ssss.subspec 'FilterByRawDataCell' do |sssss|
          sssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Views/FilterByRawDataCell/**'
        end
        
        ssss.subspec 'FilterEditSectionHeaderView' do |sssss|
          sssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Views/FilterEditSectionHeaderView/**'
        end
        
        ssss.subspec 'FilterNormalTextFieldCell' do |sssss|
          sssss.source_files = 'MKScannerPro/Classes/Modules/CommonModule/Views/FilterNormalTextFieldCell/**'
        end
        
      end
    end
    
  
    ss.dependency 'MKScannerPro/DeviceModel'
    ss.dependency 'MKScannerPro/Expand'
    ss.dependency 'MKScannerPro/SDK'
    ss.dependency 'MKScannerPro/CTMediator'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'MLInputDodger'
  
  end
  
end
