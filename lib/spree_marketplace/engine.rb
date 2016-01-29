module SpreeMarketplace
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_marketplace'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'spree_marketplace.custom_splitters', after: 'spree_drop_ship.custom_splitters' do |app|
      # delete not relevant splitter
      app.config.spree.stock_splitters.delete Spree::Stock::Splitter::DropShip
      app.config.spree.stock_splitters << Spree::Stock::Splitter::Supplier
    end
    
    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
