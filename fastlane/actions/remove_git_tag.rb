module Fastlane
  module Actions
    module SharedValues
      REMOVE_GIT_TAG_CUSTOM_VALUE = :REMOVE_GIT_TAG_CUSTOM_VALUE
    end

    class RemoveGitTagAction < Action
      def self.run(params)
        #在这里写需要执行的操作
        #params[:参数名称] 参数名称与下面self.available_options中的保持一致
        tag_version = params[:tag_version]
        rm_local_tag = params[:rm_local_tag]
        rm_remote_tag = params[:rm_remote_tag]

        commond = []
        if rm_local_tag
          #删除本地 tag
          # git tag -d 标签名
          commond << "git tag -d #{tag_version}"
        end

        if rm_remote_tag
          #删除远程 tag
          # git push origin: 标签名
          commond << "git push origin :#{tag_version}"
        end

        result = Action.sh(commond.join('&'))
        UI.message("Successfully remove tag 🚀 ")
        return result

      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "删除 tag"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "使用当前 action 来删除本地和远程冲突的 tag"
      end

      def self.available_options
        # Define all options your action supports. 
        
        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :tag_version,
                                       description: "输入即将删除的 tag", # a short description of this parameter
                                       is_string: true),
          FastlaneCore::ConfigItem.new(key: :rm_local_tag,
                                       description: "是否删除本地 tag",
                                       optional: true,
                                       is_string: false, # true: verifies the input is a string, false: every kind of value
                                       default_value: true), # the default value if the user didn't provide one
          FastlaneCore::ConfigItem.new(key: :rm_remote_tag,
                                       description: "是否删除远程 tag",
                                       optional: true,
                                       is_string: false,
                                       default_value: true)
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['REMOVE_GIT_TAG_CUSTOM_VALUE', 'A description of what this value contains']
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
