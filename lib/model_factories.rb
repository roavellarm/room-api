# frozen_string_literal: true

module ModelFactories
  # Add any new tables to the list bellow
  TABLES_TO_CLEAN = ['public.users'].freeze

  def seed_database
    # Use this method to list all the data that should be immutable and present
    # every time
    # we start a spec case/ressed the development database
    average_joe
    some_room
  end

  def teardown
    TABLES_TO_CLEAN.each do |table|
      ActiveRecord::Base.connection.execute "TRUNCATE TABLE #{table} CASCADE"
    end
  end

  def average_joe
    # All factory methods should have a find_or_create_by using an unique key
    # that is not auto generated
    @average_joe ||= User.find_or_create_by!(
      email: 'joe@seasoned.cc', first_name: 'Average', last_name: 'Joe'
    ) do |u|
      u.password = 'password'
    end
  end

  def some_room
    @some_room ||= Room.find_or_create_by!(
      title: "Ornitorrinco's Room",
      subtitle: 'A place for chating',
      background_image: 'https://picsum.photos/600/400',
      avatar_image: 'https://i.pravatar.cc/150'
    )
  end
end
