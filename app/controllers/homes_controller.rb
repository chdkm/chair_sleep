class HomesController < ApplicationController
  skip_before_action :require_login
  
  def top; end

  def rules; end

  def policy; end
end