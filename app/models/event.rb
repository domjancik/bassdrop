require 'json'

class Event < ActiveRecord::Base
  belongs_to :venue

  has_many :performances, -> { order(:stage_id) }, dependent: :destroy

  has_many :stages, -> { uniq }, through: :performances

  has_many :artists, -> { uniq }, through: :performances
  has_many :headliners, -> { where(:performances => {is_headliner: true}).uniq },
           through: :performances, :source => :artist
  has_many :non_headliners, -> { where(:performances => {is_headliner: false}) },
           through: :performances, :source => :artist

  def to_s
    title
  end

  def stage_lineup(stage)
    lineup.where(stage: stage)
  end

  def lineup
    performances.order :date_start
  end

  def update_from_fb
    params = {access_token: FacebookHelper.access_token, fields: 'description,cover'}
    response =  RestClient.get "#{FacebookHelper.graph_url}/#{link_fb}", {params: params}
    json_response = JSON.parse response

    self.description = json_response['description']
    self.image_url_cached = json_response['cover']['source']

    self.cached_at = Time.now

    self.save
  end
end
