require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    graduation_albums: Field::HasMany,
    message_for_everyones: Field::HasMany,
    message_for_each_menbers: Field::HasMany,
    events: Field::HasMany,
    ranks: Field::HasMany,
    answers: Field::HasMany,
    relationships: Field::HasMany,
    followings: Field::HasMany,
    reverse_of_relationships: Field::HasMany,
    followers: Field::HasMany,
    album_users: Field::HasMany,
    belong_albums: Field::HasMany,
    suprise_messages: Field::HasMany,
    registered_collections: Field::HasMany,
    event_comments: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    email: Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    avatar: Field::String,
    face_id: Field::String,
    social_unique_id: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    graduation_albums
    message_for_everyones
    message_for_each_menbers
    events
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    graduation_albums
    message_for_everyones
    message_for_each_menbers
    events
    ranks
    answers
    relationships
    followings
    reverse_of_relationships
    followers
    album_users
    belong_albums
    suprise_messages
    registered_collections
    event_comments
    id
    name
    email
    encrypted_password
    reset_password_token
    reset_password_sent_at
    remember_created_at
    created_at
    updated_at
    avatar
    face_id
    social_unique_id
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    graduation_albums
    message_for_everyones
    message_for_each_menbers
    events
    ranks
    answers
    relationships
    followings
    reverse_of_relationships
    followers
    album_users
    belong_albums
    suprise_messages
    registered_collections
    event_comments
    name
    email
    encrypted_password
    reset_password_token
    reset_password_sent_at
    remember_created_at
    avatar
    face_id
    social_unique_id
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user)
  #   "User ##{user.id}"
  # end
end
