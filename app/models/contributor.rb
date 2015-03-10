class Contributor < ActiveRecord::Base

	has_and_belongs_to_many :repositories
	attr_accessible :login, :name, :email, :company, :blog, :avatar_url, :location, :latitude, :longitude

	def self.format contributor

		user = Contributor.where(:login => contributor.login).first
		
		unless user
			u = Github.users.get user: contributor.login
			
			loc = self.locate u if !u[:location].nil? and u[:location] != ""
			user = self.create!(
				:login => u.login,
				:name => u.name,
				:email => u.email,
				:company => u.company,
				:blog => u.blog,
				:avatar_url => u.avatar_url,
				:location => u[:location],
				:latitude => loc.nil? ? nil : loc[:lat],
				:longitude => loc.nil? ? nil : loc[:lng]
			)
		end
		user
	end

	def repos
		Github.repos.list :user => login
	end

	def followers
		Github.users.followers.list login
	end

	def gists
		Github.gists.list user: login
	end

	private

	def self.locate contributor
		begin 
			Gmaps4rails.geocode(contributor[:location]).first
		rescue Gmaps4rails::GeocodeStatus
			return nil
		end
	end

end