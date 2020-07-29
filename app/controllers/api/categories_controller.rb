class Api::CategoriesController < ApplicationController

  def index
    puts "-----------------"
    puts "受け取ったカテゴリのID"
    puts params[:category_id]
    puts "-----------------"
  end

end