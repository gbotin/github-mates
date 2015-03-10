class ContributorsController < ApplicationController

	def index
		@contributors = Repository.where(:user => params[:user], :repo => params[:repo]).first.contributors

		respond_to do |format|
			format.json { render :json => @contributors }
		end
	end

	def show
		@contributor = Contributor.find(params[:id])
		render :layout => false
	end

	def infos
		@contributor = Contributor.where(:login => params[:user]).first
		render :layout => false
	end

end
