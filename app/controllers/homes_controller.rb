class HomesController < ApplicationController
  skip_before_action :require_login, only: %i[top rules]
  
  def top; end

  def rules; end
end