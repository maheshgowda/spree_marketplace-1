FFaker = Faker # fix problem with ffaker in spree_drop_ship factory
FactoryGirl.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  
  require 'spree_drop_ship/factories'
end
