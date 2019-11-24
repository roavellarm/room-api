# frozen_string_literal: true

module ModelFactories
  TABLES_TO_CLEAN = ['public.users', 'public.rooms', 'public.orgs',
                     'public.user_orgs'].freeze

  def seed_database
    average_joe
    average_fred
    average_sally
    orange_org
    banana_org
    cafe_room
    music_room
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
    User.find_or_create_by!(
      email: "#{first_name.downcase}@email.com",
      first_name: first_name,
      last_name: 'Average'
    ) do |u|
      u.password = "#{first_name.downcase}password"
    end
  end

  # Seed Orgs
  def orange_org
    @orange_org ||= Org.find_or_create_by!(
      user: average_joe,
      name: 'Orange Company',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      image: 'https://source.unsplash.com/random'
    )
  end

  def banana_org
    @banana_org ||= Org.find_or_create_by!(
      user: average_fred,
      name: 'Banana Company',
      description: 'Aliquam pharetra magna ut augue varius eget vitae est.',
      image: 'https://source.unsplash.com/random'
    )
  end

  # Seed rooms
  def cafe_room
    @cafe_room ||= Room.find_or_create_by!(
      org: banana_org,
      title: 'Cafe',
      subtitle: 'Take a break and drink some coffe',
      background_image: 'https://picsum.photos/600/400',
      avatar_image: 'https://i.pravatar.cc/150'
    )
  end

  def music_room
    @music_room ||= Room.find_or_create_by!(
      org: banana_org,
      title: 'Music room',
      subtitle: 'Relax and listen to some music',
      background_image: 'https://picsum.photos/600/400',
      avatar_image: 'https://i.pravatar.cc/150'
    )
  end
end
