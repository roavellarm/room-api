# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
module ModelFactories
  TABLES_TO_CLEAN = ['public.users', 'public.rooms', 'public.orgs',
                     'public.user_orgs'].freeze

  # rubocop:disable Metrics/AbcSize
  def seed_database
    [average_joe, average_fred, average_sally, orange_org, banana_org,
     cafe_room, music_room, very_dissatisfied, very_bad, bad, dissatisfied, satisfied, happy, very_happy,
     very_satisfied, chat_message, chat_message2, chat_message3, status_available,
     status_busy, status_on_call]
  end
  # rubocop:enable Metrics/AbcSize

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
      email: "#{first_name.downcase}@email.com", first_name: first_name,
      last_name: 'Average'
    ) { |u| u.password = "#{first_name.downcase}password" }
  end

  # Seed Orgs
  def orange_org
    @orange_org ||= add_org(average_joe, 'Orange Company', 'Lorem ipsum dolor '\
      'sit amet, consectetur adipiscing elit.')
  end

  def banana_org
    @banana_org ||= add_org(average_fred, 'Banana Company', 'Aliquam pharetra'\
      ' magna ut augue varius eget vitae est.')
  end

  def add_org(user, name, description)
    Org.find_or_create_by!(user: user, name: name, description: description,
                           image: 'https://source.unsplash.com/random')
  end

  # Seed rooms
  def cafe_room
    @cafe_room ||= add_room(banana_org, 'Cafe', 'Take a break and drink some '\
      'coffe')
  end

  def music_room
    @music_room ||= add_room(orange_org, 'Music room', 'Relax and listen to '\
      'some music')
  end

  def add_room(org, title, subtitle)
    Room.find_or_create_by!(org: org, title: title, subtitle: subtitle,
                            background_image: 'https://picsum.photos/600/400',
                            avatar_image: 'https://i.pravatar.cc/150')
  end

  # Seed moods
  def very_dissatisfied
    @very_dissatisfied ||= Mood.find_or_create_by!(name: 'Very dissatisfied')
  end

  def very_bad
    @very_bad ||= Mood.find_or_create_by!(name: 'Very bad')
  end

  def bad
    @bad ||= Mood.find_or_create_by!(name: 'Bad')
  end

  def dissatisfied
    @dissatisfied ||= Mood.find_or_create_by!(name: 'Dissatisfied')
  end

  def satisfied
    @satisfied ||= Mood.find_or_create_by!(name: 'Satisfied')
  end

  def happy
    @happy ||= Mood.find_or_create_by!(name: 'Happy')
  end

  def very_happy
    @very_happy ||= Mood.find_or_create_by!(name: 'Very happy')
  end

  def very_satisfied
    @very_satisfied ||= Mood.find_or_create_by!(name: 'Very satisfied')
  end

  # Seed chat messages
  def chat_message
    @chat_message ||= Chat.find_or_create_by!(
      user: average_fred, room: cafe_room, message: 'Hey guys!'
    )
  end

  def chat_message2
    @chat_message2 ||= Chat.find_or_create_by!(
      user: average_joe, room: cafe_room, message: "What's up, Fred?"
    )
  end

  def chat_message3
    @chat_message3 ||= Chat.find_or_create_by!(
      user: average_sally, room: cafe_room, message: 'Hey, Fred!'
    )
  end

  def status_available
    @status_available ||= Status.find_or_create_by!(status: 'available')
  end

  def status_busy
    @status_busy ||= Status.find_or_create_by!(status: 'busy')
  end

  def status_on_call
    @status_on_call ||= Status.find_or_create_by!(status: 'on_call')
  end
end
# rubocop:enable Metrics/ModuleLength
