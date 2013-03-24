# coding: utf-8
module UploadifyRails
  module Controllers
    module Base
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def uploadify_nested_resource
          unless included_modules.include? InstanceMethods
            include InstanceMethods
          end
          skip_before_filter :verify_authenticity_token, :only => [:create]
        end
      end

      module InstanceMethods
        def create
          object = controller_name.classify.constantize.new
          object.build_nested_resource(params, current_user)
          if object.save
            render :partial => "shared/uploadify/#{controller_name}/fields",
                   :locals => {:object => object}
          else
            head 442
          end
        end

        def destroy
          load_object
          @object.destroy
          head :ok
        end

        protected

        def load_object
          model = controller_name.classify.constantize
          object_by_session = model.where(:session_id => session[:session_id], :id => params[:id]).first
          object_by_current_user = current_user.send(controller_name).find_by_id(params[:id]) if current_user
          @object = object_by_session || (object_by_current_user if object_by_current_user)
          permission_denied if @object.nil?
        end
      end
    end
  end
end
