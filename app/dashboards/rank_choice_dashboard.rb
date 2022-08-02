require 'administrate/base_dashboard'

class RankChoiceDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    rank_choice_image_attachment: Field::HasOne,
    rank_choice_image_blob: Field::HasOne,
    rank: Field::BelongsTo,
    answers: Field::HasMany,
    id: Field::Number,
    content: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    answers_count: Field::Number
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    rank_choice_image_attachment
    rank_choice_image_blob
    rank
    answers
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    rank_choice_image_attachment
    rank_choice_image_blob
    rank
    answers
    id
    content
    created_at
    updated_at
    answers_count
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    rank_choice_image_attachment
    rank_choice_image_blob
    rank
    answers
    content
    answers_count
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

  # Overwrite this method to customize how rank choices are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(rank_choice)
  #   "RankChoice ##{rank_choice.id}"
  # end
end
