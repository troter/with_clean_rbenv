module WithCleanRbenv
  class Context
    class << self
      def current
        @current ||= Context.new
      end

      def current=(context)
        @current = context
      end
    end

    def initialize(env = {})
      @env = default_clean_env.merge(env)
    end

    def default_clean_env
      { 'RBENV_VERSION' => nil, 'RBENV_DIR' => nil }
    end

    def with_env(env, &_block)
      original_env = ENV.to_hash
      ENV.update(env)
      yield if block_given?
    ensure
      ENV.replace(original_env)
    end

    def with_clean_bundler_env(&_block)
      if defined?(Bundler)
        Bundler.with_clean_env do
          yield if block_given?
        end
      else
        yield if block_given?
      end
    end

    def with_clean_rbenv(&block)
      with_clean_bundler_env do
        with_env(@env, &block)
      end
    end

    def within_clean_rbenv(directory, &block)
      with_clean_rbenv do
        Dir.chdir(directory, &block)
      end
    end
  end
end
