require "administrate/base_dashboard"

class GraduationAlbumDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    images_attachments: Field::HasMany,
    images_blobs: Field::HasMany,
    user: Field::BelongsTo,
    message_for_everyones: Field::HasMany,
    message_for_each_menbers: Field::HasMany,
    events: Field::HasMany,
    ranks: Field::HasMany,
    album_users: Field::HasMany,
    users: Field::HasMany,
    suprise_messages: Field::HasMany,
    photo_paths: Field::HasMany,
    id: Field::Number,
    album_name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    images_attachments
    images_blobs
    user
    message_for_everyones
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    images_attachments
    images_blobs
    user
    message_for_everyones
    message_for_each_menbers
    events
    ranks
    album_users
    users
    suprise_messages
    photo_paths
    id
    album_name
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    images_attachments
    images_blobs
    user
    message_for_everyones
    message_for_each_menbers
    events
    ranks
    album_users
    users
    suprise_messages
    photo_paths
    album_name
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

  # Overwrite this method to customize how graduation albums are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(graduation_album)
  #   "GraduationAlbum ##{graduation_album.id}"
  # end
end
