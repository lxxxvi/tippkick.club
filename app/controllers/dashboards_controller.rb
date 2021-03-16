class DashboardsController < ApplicationController
  def show
    @dashboard = DashboardService.new(current_user)
  end
end
