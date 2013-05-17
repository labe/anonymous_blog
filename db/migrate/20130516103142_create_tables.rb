class CreateTables < ActiveRecord::Migration
  def change
  	create_table 	:blogs do |t|
  		t.string		:name, :null => false
      t.timestamps
  	end

  	create_table 	:posts do |t|
  		t.string		:title, :null => false
  		t.text			:body, :null => false
      t.integer   :user_id
      t.timestamps
  	end

  	create_table 	:tags do |t|
  		t.string		:name
      t.timestamps
  	end

  	create_table 	:post_tags do |t|
  		t.integer		:post_id
  		t.integer		:tag_id
  	end

    create_table  :users  do |t|
      t.string    :name
      t.string    :email, :uniqueness => true
      t.string    :password
      t.string    :link_id
      t.integer   :blog_id, :default => 1
      t.timestamps
    end

  end
end
