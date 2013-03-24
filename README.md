## Installation

Add this line to your application's Gemfile:

    gem 'uploadify_rails'

And then execute:

    $ bundle

## Usage

Routes:

    resources :photos, :only => [:create]

    post "/photo/:id" => "photos#destroy"

Javascripts:

    //= require uploadify

Stylesheets:

    *= require uploadify

Model Parent (F.E. Advert):

    class Advert ...

        # Support only one relation name in just moment

        uploadify_nested_parent :relations => [:photos]

Model with Photo:

    class Photo ...

        uploadify_nested_resource

Photos Controller:

    class PhotosController < ApplicationController

      uploadify_nested_resource

    end

Adverts Controller:

    class AdvertsController < ApplicationController

      def create

        @advert = Advert.new

        @advert.build_attributes_from_params(params, current_user, session[:session_id])

        if @advert.save

          ...

View:

    Example: in app/views/shared/uploadify/...

Formtastic Form Integration (@advert form):

    = form.input :photos, :as => :uploadify

## Enjoy!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks

Thanks to https://github.com/dead-zygote for javascripts and first time realization
