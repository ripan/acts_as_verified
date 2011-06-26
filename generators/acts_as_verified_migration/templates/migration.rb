class ActsAsVerifiedMigration < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string  :name
      #t.integer :verifyable_id
      #t.string  :verifyable_type
      t.references :verifyable, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :states
  end
end


