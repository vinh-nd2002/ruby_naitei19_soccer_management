class Admin::BaseController < ApplicationController
  before_action :check_admin_role

  layout "layouts/application_admin"
end
