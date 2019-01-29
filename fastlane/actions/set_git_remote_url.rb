module Fastlane
  module Actions
    module SharedValues
      SET_GIT_REMOTE_URL_CUSTOM_VALUE = :SET_GIT_REMOTE_URL_CUSTOM_VALUE
    end

    class SetGitRemoteUrlAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        remote_url = params[:remote_url]

        commond  = []
      
        commond << "git remote add origin #{params[:remote_url]}"
        commond << "git pull --rebase origin master"
        commond << "git push -u origin master"
        result = Action.sh(commond.join('&'))
        UI.message("Successfully set remote url 🚀 ")
        return result
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "设置私有仓库远程地址"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "使用当前 action 设置私有仓库的远程地址"
      end

      def self.available_options
        # Define all options your action supports. 
        
        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :remote_url,
                                       description: "输入远程仓库的地址" # a short description of this parameter
                                      )

        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['SET_GIT_REMOTE_URL_CUSTOM_VALUE', 'A description of what this value contains']
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
