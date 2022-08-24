class Admin::DashboardController < ApplicationController
  include HttpAuthConcern

  #  have the controller fetch data from database using active record

  # set instance variable in controller
  #  then render the view with the data "/views/admin/dashboard/show.html.erb"

  #  desired data
  # Display a count of how many products are in the database
  # Display a count of how many categories are in the database
  def show
    @products = Product.count
    @categories = Category.count
  end
end
