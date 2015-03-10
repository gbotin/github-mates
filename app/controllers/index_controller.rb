class IndexController < ApplicationController

	def index
	end

	def search
		@repository = Repository.find_or_create_by_user_and_repo params[:user], params[:repo]
		render :index
	end

end
