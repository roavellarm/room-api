# frozen_string_literal: true

# rubocop:disable all

require 'model_factories'
include ModelFactories

puts 'Seeding database with test data...'
seed_database
puts 'done!'

# rubocop:enable all
