module Playlistable extend ActiveSupport::Concern
  included do
    # model_var_name = controller_name.classify.downcase
    # set_method_name = "set_#{model_var_name}"
    # before_action set_method_name.to_sym, only: [:create_playlist]
  end

  # POST /<models>/:id/create_playlist
  def create_playlist
    Playlist.create_for model
  end

  private
    def model_var_name
      controller_name.classify.downcase
    end

    def model
      instance_variable_get("@#{model_var_name}")
    end
end