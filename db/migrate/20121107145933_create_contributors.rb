class CreateContributors < ActiveRecord::Migration
	def change
		create_table :contributors do |t|
			t.string :login, :null => false
			t.string :email
			t.string :name
			t.string :avatar_url
			t.string :company
			t.string :blog
			t.string :location
			t.float :latitude
			t.float :longitude
		end
	end
end