class LookupController < ApplicationController
  MODELS = [
      Event,
      Artist,
      Release
  ]

  def lookup
    id = params[:id]

    MODELS.each do |model|
      instance = model.find_universal id
      if instance
        redirect_to url_for(instance)
        return
      end
    end
  end
end