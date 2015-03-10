class CreateContributorsRepositories < ActiveRecord::Migration
  def change
	create_table :contributors_repositories, :id => false do |t|
		t.references :contributor, :null => false
		t.references :repository, :null => false
	end
  end
end
