class User::BaseController < ApplicationController
  layout "layouts/application_user"

  include SearchPitchable
end
