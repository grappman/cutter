class Api::ApplicationController < InheritedResources::Base

  protect_from_forgery with: :null_session, if: ->{request.format.json?}

  respond_to :json

end