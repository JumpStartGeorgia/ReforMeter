class ChartsController < ApplicationController
  def create_share_image
    require 'uri'
    require 'net/http'
    require 'fileutils'

    png_image_path = params['png_image_path']

    image_glob = png_image_path.gsub(/_id-\w+\./, '_id-*.')

    # end action if chart image already exists
    render json: nil, status: :ok if Dir.glob(image_glob).present?

    post_params = params['highcharts_export_options']

    response = Net::HTTP.post_form(
      URI.parse('http://export.highcharts.com/'),
      post_params
    )

    FileUtils::mkdir_p(File.dirname(png_image_path))

    File.open(png_image_path, 'wb') do |file|
      file.write response.body
    end

    render json: nil, status: :ok
  end
end
