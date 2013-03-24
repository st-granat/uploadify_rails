# coding: utf-8
require "formtastic"
require "renderer"

module Formtastic
  module Inputs
    class UploadifyInput
      # include ActionView::Helpers::TextHelper
      include Base

      def to_html
        uploader = Renderer.render("shared/uploadify/#{method.to_s}/form", {:form => builder})
        input_wrapping do
          label_html << uploader.html_safe
        end
      end
    end
  end
end
