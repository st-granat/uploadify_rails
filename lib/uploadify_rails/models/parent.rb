# coding: utf-8
module UploadifyRails
  module Models
    module Parent
      include ActionView::Helpers::TextHelper

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def uploadify_nested_parent(options = {})
          class_attribute :uploadify_options
          self.uploadify_options = {
            # Only one relation in this version!
            :relations => (options[:relations] || [:photos]),
          }
          unless included_modules.include? InstanceMethods
            include InstanceMethods
          end
        end
      end

      module InstanceMethods
        def build_attributes_from_params(params, user, session_id)
          parent_class_singular = self.class.to_s.singularize.downcase
          relation_name = uploadify_options[:relations].first.to_s
          relation_singular = relation_name.singularize
          relation_model = relation_singular.classify.constantize
          params[parent_class_singular].delete("#{relation_name}_attributes")
          self.attributes = params[parent_class_singular]
          self.user_id = user ? user.id : nil
          self.session_id = session_id
          object_ids = params["#{relation_singular}_ids"]
          if object_ids && !object_ids.blank?
            checked_object_ids = []
            object_ids.first.values.each do |object_id|
              object = relation_model.find_by_id(object_id)
              if object
                if (object.session_id == session_id ||(user && user.id == object.user_id))
                  checked_object_ids << object_id
                  object.update_attribute(:user_id, user.id) if user
                end
              end
            end
            self.send("#{relation_singular}_ids=", checked_object_ids)
          end
        end
      end
    end
  end
end
