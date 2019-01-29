module Fastlane
  module Actions
    module SharedValues
      GIT_REMOTE_URL_CUSTOM_VALUE = :GIT_REMOTE_URL_CUSTOM_VALUE
    end

    class GitRemoteUrlAction < Action
      def self.run(params)
        commond = "git remote -v"
        # exists = true
        # Action.sh(commond, 
        #           success_callback: ->(result) {exists = false}
        # )
        result = Actions.sh(commond)
        # UI.message("Successfully set remote url #{result.count} 🚀 ")
        if result.empty? 
          return true
        else 
          return false
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "A short description with <= 80 characters of what this action does"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
        # Define all options your action supports. 
        
        # Below a few examples
        [
          
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['GIT_REMOTE_URL_CUSTOM_VALUE', 'A description of what this value contains']
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
