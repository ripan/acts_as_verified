class State < ActiveRecord::Base
  belongs_to :verifyable, :polymorphic => true
end