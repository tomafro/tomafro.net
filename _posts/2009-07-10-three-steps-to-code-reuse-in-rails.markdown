---
layout: post
title: Salvador Dali on "What's My Line?"
categories: [salvador-dali, whats-my-line, tv, youtube]
---
class Comment < ActiveRecord::Base
  has_many :abuse_flags

  def flag!
    abuse_flags.create!
  end
end

Step 1: Move code into a model specific module

module Comment::Flaggable
  def self.included(base)
    base.has_many :abuse_flags
  end
  
  def flag!
    abuse_flags.create!
  end
end

class Comment < ActiveRecord::Base
  include Flaggable
end

Step 2: Convert module into a generic ActiveRecord extension

module Flaggable
  def is_flaggable
    include ::Flaggable::Behaviour
  end
  
  module Behaviour
    def self.included(base)
      base.has_many :abuse_flags
    end
  
    def flag!
      abuse_flags.create!
    end
  end
  
  ActiveRecord::Base.extend self
end

class Comment < ActiveRecord::Base
  is_flaggable
end

Step 3: Promote extension to a plugin