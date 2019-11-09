# frozen_string_literal: true

module ModelFactories
  TABLES_TO_CLEAN = ['public.users', 'public.user_roles',
                     'public.roles', 'public.rooms'].freeze

  def seed_database
    average_joe
    average_fred
    average_sally
    # some_organization
    # some_room
  end

  def teardown
    TABLES_TO_CLEAN.each do |table|
      ActiveRecord::Base.connection.execute "TRUNCATE TABLE #{table} CASCADE"
    end
  end

  # Seed Roles
  def admin_role
    @admin_role ||= Role.find_or_create_by!(name: 'admin')
  end

  def owner_role
    @owner_role ||= Role.find_or_create_by!(name: 'owner')
  end

  def member_role
    @member_role ||= Role.find_or_create_by!(name: 'member')
  end

  # Seed Users
  def average_joe
    @average_joe ||= add_user('Joe', owner_role)
  end

  def average_fred
    @average_fred ||= add_user('Fred', member_role)
  end

  def average_sally
    @average_sally ||= add_user('Sally', member_role)
  end

  def add_user(first_name, role)
    @add_user ||= User.find_or_create_by!(
      email: "#{first_name.downcase}@email.com",
      first_name: first_name,
      last_name: 'Average'
    ) do |u|
      u.password = 'password'
      u.roles << role
    end
  end

  # Seed Orgs
  def orange_org
    @orange_org ||= Org.find_or_create_by!(name: 'Orange Company')
  end

  def banana_org
    @banana_org ||= Org.find_or_create_by!(name: 'Banana Company')
  end

  # def some_room
  #   @some_room ||= Room.find_or_create_by!(
  #     user: average_joe,
  #     organization: some_organization,
  #     title: "Bar's Room",
  #     subtitle: 'A place for chating',
  #     background_image: 'https://picsum.photos/600/400',
  #     avatar_image: 'https://i.pravatar.cc/150'
  #   )
  # end
end
