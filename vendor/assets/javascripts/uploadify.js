//= require jquery.uploadify.js
//= require nested_attachments_uploader.js
//=# require jquery_nested_form.js
//= require_self

function add_nested_resources() {
  $('#add-nested-resources').nestedAttachmentsUploader({
    uploadsContainer: $('#nested_resources')
  });
};

function delete_nested_resource() {
  $("#nested_resources a.delete").live("click", function(){
    var link = $(this);
    var id = link.attr("id");
    var url = "/" + id.replace("_", "/");
    $.post(url, function(data) {
      link.parents(".fields:first").remove();
    });
  });
};

$(document).ready(function(){
  add_nested_resources();
  delete_nested_resource();
});
