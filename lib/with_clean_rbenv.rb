require 'with_clean_rbenv/version'
require 'with_clean_rbenv/context'

module WithCleanRbenv
  class << self
    def current=(context)
      Context.current = context
    end

    def current
      Context.current
    end
  end

  def with_clean_rbenv(*args, &block)
    Context.current.with_clean_rbenv(*args, &block)
  end

  def within_clean_rbenv(*args, &block)
    Context.current.within_clean_rbenv(*args, &block)
  end

  module_function :with_clean_rbenv, :within_clean_rbenv
end
