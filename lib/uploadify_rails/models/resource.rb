# coding: utf-8
module UploadifyRails
  module Models
    module Resource
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def uploadify_nested_resource
          unless included_modules.include? InstanceMethods
            include InstanceMethods
          end
        end
      end

      module InstanceMethods
        def build_nested_resource(params, user)
          params[:Filedata].content_type = MIME::Types.type_for(params[:Filedata].original_filename).first
          self.data = params[:Filedata]
          self.session_id = params[:_session_id]
          self.user = user if user
        end
      end
    end
  end
end
