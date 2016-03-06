class Posts < ActiveRecord::Migration
  def change
  	create_table :posts do |t|
  		t.text :content
  		t.text :autor

  		t.timestamps null: false
  	end
  end
end
