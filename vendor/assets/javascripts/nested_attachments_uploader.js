// переопределить SWFUpload.completeURL нужно,
// чтобы после инициализации uploadify
// не отправлялся странный и ненужный get запрос

SWFUpload.completeURL = function(a){
  return a;
}

jQuery.fn.nestedAttachmentsUploader = function(options) {
  var that = this;
  this.parents('form').submit(function(e) {
    options.uploadsContainer.each(function() {
      $(this).find('.fields').each(function(index) {
        $(this).find('input').each(function() {
          var inputName = $(this).attr('name');
          if (inputName.search(/^[_a-z]+$/) !== -1) {
            // если файл был только что добавлен
            $(this).attr('name', options.ownerName + '[' + options.nestedName + '_attributes][' + index + '][' + inputName + ']');
          } else {
            // если файл был изначально
            var nameParts = inputName.split('][');
            nameParts[1] = index;
            $(this).attr('name', nameParts.join(']['));
          }
        });
      });
    });
  });

  var csrf_token = $('meta[name=csrf-token]').attr('content');

  this.uploadify({
    swf: '/assets/uploadify.swf',
    uploader: that.data('uploader'),
    formData: {
      authenticity_token: csrf_token,
      _session_id: session_id
    },
    overrideEvents: ['onUploadSuccess'],
    onUploadSuccess: function(file, data, response) {
      $('#' + file.id).find('.data').html(' - Загрузка завершена');
      options.uploadsContainer.append(data);
    },
    onUploadError: function(file, errorCode, errorMsg, errorString) {
    },
    onInit: function(instance) {
      // После инициализации padding кнопки
      // зачем-то устанавливается равным 10px,
      // исправляем это:
      $(that.selector).find('.uploadify-button').css({
        'padding': 0,
        'padding-left': '30px'
      });
    },
    buttonText: 'Добавить фотографии',
    buttonClass: 'button',
    width: 160,
    height: 30
  });
}
