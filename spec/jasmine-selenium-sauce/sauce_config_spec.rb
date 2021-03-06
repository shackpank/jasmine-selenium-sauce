require 'spec_helper'
require 'config_fixtures'
require 'sauce_config'

describe Jasmine::Sauce::CI::SauceConfig do

  after do
    ENV.delete('SAUCELABS_URL')
    ENV.delete('JASMINE_URL')
    ENV.delete('SAUCE_BROWSER')
  end

  describe "#validate" do
    subject { Jasmine::Sauce::CI::SauceConfig.new.validate }

    context "when valid" do
      before do
        ENV['SAUCELABS_URL'] = 'sauce'
        ENV['JASMINE_URL'] = 'jasmine'
        ENV['SAUCE_BROWSER'] = 'browser'
      end
      specify { expect { subject }.not_to raise_error  }
    end

    context "when saucelabs url is not set" do
      before do
        ENV['JASMINE_URL'] = 'jasmine'
        ENV['SAUCE_BROWSER'] = 'browser'
      end
      specify { expect { subject }.to raise_error(ArgumentError)  }
    end

    context "when jasmine url is not set" do
      before do
        ENV['SAUCELABS_URL'] = 'sauce'
        ENV['SAUCE_BROWSER'] = 'browser'
      end
      specify { expect { subject }.to raise_error(ArgumentError)  }
    end

    context "when browser is not set" do
      before do
        ENV['SAUCELABS_URL'] = 'sauce'
        ENV['JASMINE_URL'] = 'jasmine'
      end
      specify { expect { subject }.to raise_error(ArgumentError)  }
    end
  end

  it_behaves_like 'sauce config' do
    let(:under_test) { Jasmine::Sauce::CI::SauceConfig.new }
  end
end