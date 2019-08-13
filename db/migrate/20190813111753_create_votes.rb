class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.string :vote_type #type is rails reserved
      t.timestamps
    end
  end
end
