require 'spec_helper'
require 'tmpdir'

describe WithCleanRbenv do
  it 'has a version number' do
    expect(WithCleanRbenv::VERSION).not_to be nil
  end

  describe '.with_clean_rbenv' do
    let(:rbenv_version) { 'dummy_version' }
    let(:rbenv_dir) { 'dummy_dir' }
    let(:env) do
      { 'RBENV_VERSION' => rbenv_version, 'RBENV_DIR' => rbenv_dir }
    end

    around do |example|
      begin
        original_env = ENV.to_hash
        ENV.update(env)
        example.call
      ensure
        ENV.replace(original_env)
      end
    end

    %w(RBENV_VERSION RBENV_DIR).each do |name|
      it "should clear #{name}" do
        expect(ENV[name]).to eq(env[name])
        WithCleanRbenv.with_clean_rbenv do
          expect(ENV[name]).to be_nil
        end
      end
    end
  end

  describe '.within_clean_rbenv' do
    it 'should change dir' do
      Dir.mktmpdir do |dir|
        dir = File.realdirpath(dir)
        expect(Dir.pwd).not_to eq(dir)
        WithCleanRbenv.within_clean_rbenv dir do
          expect(Dir.pwd).to eq(dir)
        end
      end
    end
  end

  describe '.current=' do
    let(:context) do
      WithCleanRbenv::Context.new('WIHT_CLEAN_RBENV_CUSTOM' => 'VARIABLE')
    end

    around do |example|
      begin
        original_env = ENV.to_hash
        ENV['WIHT_CLEAN_RBENV_CUSTOM'] = nil
        example.call
      ensure
        ENV.replace(original_env)
      end
    end

    around do |example|
      begin
        original_context = WithCleanRbenv.current
        example.call
      ensure
        WithCleanRbenv.current = original_context
      end
    end

    it 'should change default context' do
      expect(ENV['WIHT_CLEAN_RBENV_CUSTOM']).to be_nil
      WithCleanRbenv.current = context
      WithCleanRbenv.with_clean_rbenv do
        expect(ENV['WIHT_CLEAN_RBENV_CUSTOM']).to eq('VARIABLE')
      end
    end
  end
end
