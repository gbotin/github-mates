class CreateRepositories < ActiveRecord::Migration
	def change
		create_table :repositories do |t|
			t.string :user, :null => false
			t.string :repo, :null => false
		end
	end
end