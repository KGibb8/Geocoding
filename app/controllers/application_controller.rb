class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  semantic_breadcrumb :index, :root_path
end
