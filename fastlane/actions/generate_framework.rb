module Fastlane
  module Actions
    module SharedValues
      GENERATE_FRAMEWORK_CUSTOM_VALUE = :GENERATE_FRAMEWORK_CUSTOM_VALUE
    end

    class GenerateFrameworkAction < Action
      def self.run(params)
        #生成 framework 
        framework_name = params[:framework_name]
        configuration = params[:configuration] # Release or Debug
        script_name = "framework_build.sh"
        commond = []
        if framework_name 
          if configuration 
            commond << "./#{script_name} #{framework_name} #{configuration}"
          end
          
          result = Action.sh(commond.join('&'))
          # UI.seccess("Successfully generate framework 🚀 ")
          # unless result[:failed_testcount].zero?
          #   UI.messge("There are #{result[:failed_testcount]} legitimate failing tests")
          # end
          return result
        else 
          UI.seccess("Generate framework failure, please input framework_name 🚀 ")
        end
        
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "私有库 framework 生成"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "使用当前 action 生成 framework"
      end

      def self.available_options
        # Define all options your action supports. 
        
        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :framework_name,
                                       description: "请输入私有库的名称:", # a short description of this parameter
                                       is_string: true),
          FastlaneCore::ConfigItem.new(key: :configuration,
                                       description: "请输入framework configuration,[Relseae/Debug]",
                                       is_string: true, # true: verifies the input is a string, false: every kind of value
                                       default_value: "Release") # the default value if the user didn't provide one
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['GENERATE_FRAMEWORK_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["zhanghui"]
      end

      def self.is_supported?(platform)
        # you can do things like
        # 
        #  true
        # 
        #  platform == :ios
        # 
        #  [:ios, :mac].include?(platform)
        # 

        platform == :ios
      end
    end
  end
end
