class Repository < ActiveRecord::Base

	has_and_belongs_to_many :contributors

	attr_accessible :user, :repo

	validates_presence_of :user, :repo
	validate :exists

	after_save :find_and_add_contributors

	def lost_contributors
		contributors.where(:location => nil)
	end

	private

	def exists
		begin
			Github.repos.get(user, repo)
		rescue Github::Error::NotFound
			errors.add("#{user}/#{repo}", "can't be found on Github !")
		end
	end

	def find_and_add_contributors
		contributors = Github.repos.contributors(user, repo)
		contributors.each do |contributor|
			self.contributors << Contributor.format(contributor)
		end
	end

end