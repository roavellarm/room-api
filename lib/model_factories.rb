# frozen_string_literal: true

module ModelFactories
  TABLES_TO_CLEAN = ['public.users', 'public.user_roles',
                     'public.roles', 'public.rooms'].freeze

  def seed_database
    average_joe
    average_fred
    average_sally
    some_organization
    # some_room
  end

  def teardown
    TABLES_TO_CLEAN.each do |table|
      ActiveRecord::Base.connection.execute "TRUNCATE TABLE #{table} CASCADE"
    end
  end

  # Seed Users
  def average_joe
    @average_joe ||= add_user('Joe')
  end

  def average_fred
    @average_fred ||= add_user('Fred')
  end

  def average_sally
    @average_sally ||= add_user('Sally')
  end

  def add_user(first_name)
    @add_user ||= User.find_or_create_by!(
      email: "#{first_name.downcase}@email.com",
      first_name: first_name,
      last_name: 'Average'
    ) do |u|
      u.password = 'password'
    end
  end

  # Seed Orgs
  def orange_org
    @orange_org ||= Org.find_or_create_by!(
      name: 'Orange Company',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    )
  end

  def banana_org
    @banana_org ||= Org.find_or_create_by!(
      name: 'Banana Company',
      description: 'Aliquam pharetra magna ut augue varius eget vitae est.'
    )
  end

  def cafe_room
    @cafe_room ||= Room.find_or_create_by!(
      organization: banana_org,
      title: 'Cafe',
      subtitle: 'Take a break and drink some coffe',
      background_image: 'https://picsum.photos/600/400',
      avatar_image: 'https://i.pravatar.cc/150'
    )
  end
end
