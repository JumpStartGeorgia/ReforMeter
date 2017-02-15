# == Schema Information
#
# Table name: external_indicators
#
#  id                :integer          not null, primary key
#  indicator_type    :integer
#  chart_type        :integer
#  scale_type        :integer
#  min               :integer
#  max               :integer
#  show_on_home_page :boolean          default(FALSE)
#  is_public         :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  sort_order        :integer
#  use_decimals      :boolean          default(FALSE)
#  has_benchmark     :boolean          default(FALSE)
#

require 'csv'
class ExternalIndicator < AddMissingTranslation
  attr_accessor :data_hash, :update_change_values

  #######################
  ## TRANSLATIONS

  translates :title, :subtitle, :description, :benchmark_title, :data, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  has_and_belongs_to_many :reforms
  has_many :countries, class_name: 'ExternalIndicatorCountry', dependent: :destroy
  has_many :indices, class_name: 'ExternalIndicatorIndex', dependent: :destroy
  has_many :plot_bands, class_name: 'ExternalIndicatorPlotBand', dependent: :destroy
  has_many :time_periods, class_name: 'ExternalIndicatorTime', dependent: :destroy
  accepts_nested_attributes_for :countries, :reject_if => lambda { |x| x[:name_en].blank? && x[:name_ka].blank?}, allow_destroy: true
  accepts_nested_attributes_for :indices, :reject_if => lambda { |x|
    x[:name_en].blank? && x[:name_ka].blank? &&
    x[:short_name_en].blank? && x[:short_name_ka].blank?
  }, :allow_destroy => true
  accepts_nested_attributes_for :plot_bands, :reject_if => lambda { |x|
    x[:name_en].blank? && x[:name_ka].blank? &&
    x[:from].blank? && x[:to].blank?
  }, :allow_destroy => true
  accepts_nested_attributes_for :time_periods, :reject_if => lambda { |x| x[:name_en].blank? && x[:name_ka].blank?}, allow_destroy: true

  #######################
  ## VALIDATIONS

  validates :title, :indicator_type, :scale_type, :chart_type, presence: :true

  #######################
  ## CONSTANTS
  INDICATOR_TYPES = {basic: 1, country: 2, composite: 3}
  CHART_TYPES = {line: 1, bar: 2}
  SCALE_TYPES = {percent: 1, number: 2}

  #######################
  ## CALLBACKS
  after_initialize :load_data_hash
  before_save :set_data
  after_save :reset_unwanted_fields
  before_save :set_sort_order

  before_save :set_change_values
  # after_save :update_future_time
  # after_destroy :reset_future_time


  #######################
  ## SCOPES
  scope :published, -> { where(is_public: true) }
  scope :sorted, -> { with_translations(I18n.locale).order(title: :asc) }
  scope :sorted_for_list_page, -> { with_translations(I18n.locale).order(show_on_home_page: :desc).order(:sort_order).order(title: :asc) }
  scope :reverse_sorted, -> { with_translations(I18n.locale).order(title: :desc) }
  scope :for_home_page, -> { where(show_on_home_page: true).order(:sort_order) }


  # columns:
  # - basic: time, value
  # - country: time, country, value
  # - composite: time, index, value
  # format: {
  #   time_periods: [{id, name}]
  #   countries: [{id, name}]
  #   indexes: [{id, name, short_name, change_multiplier}]
  #   data: [{time_period, overall_value, overall_change, values[{index/country, value, change}] }]
  # }

  # Custom colors for external indicator gauge charts

  def ext_ind_gauge_colors
    [
     {
       r: '237',
       g: '59',
       b: '20',
       hex: '#ed3b14'
     },
     {
       r: '237',
       g: '120',
       b: '24',
       hex: '#ed7818'
     }
   ]
  end

  def gauge_chart_data(index, responsiveToSelector)
    most_recent_data_point = format_for_charting[:series][0][:data].last
    {
      id: "external-indicator-#{id}",
      title: nil,
      plotBandLabelTexts: plot_bands.map(&:name),
      min: min,
      max: max,
      score: most_recent_data_point[:y],
      change: most_recent_data_point[:change],
      responsiveTo: responsiveToSelector,
      color: ext_ind_gauge_colors[index % ext_ind_gauge_colors.length],
      use_decimals: use_decimals
    }
  end

  def self.to_csv(external_indicator_id=nil)
    ext_ind = published.find_by(id: external_indicator_id)
    time = ext_ind.time_periods.sorted

    case ext_ind.indicator_type
      when INDICATOR_TYPES[:basic]
        header = %w{time_period value}

        CSV.generate do |csv|
          csv << header
          time.each do |tp|
            csv << [tp.name, tp.data.first.value.to_f]
          end

          # ext_ind.data_hash[:data].each do |data|
          #   tp = ext_ind.data_hash[:time_periods].select{|x| x[:id] == data[:time_period]}.first
          #   if tp.present?
          #     csv << [tp[:name], data[:values][0][:value]]
          #   end
          # end
        end

      when INDICATOR_TYPES[:country]
        countries = ext_ind.countries.sorted
        header = [I18n.t('activerecord.attributes.verdict.time_period')]
        header << countries.map{|x| x.name}
        header.flatten!

        CSV.generate do |csv|
          csv << header

          time.each do |tp|
            row = [tp.name]
            # add each country value
            countries.each do |country|
              d = tp.data.select{|x| x.country_id == country.id}.first
              if d.present?
                row << d.value.to_f
              else
                row << ''
              end
            end
            csv << row
          end

          # ext_ind.data_hash[:data].each do |data|
          #   tp = ext_ind.data_hash[:time_periods].select{|x| x[:id] == data[:time_period]}.first
          #   if tp.present?
          #     data[:values].each do |value|
          #       c = ext_ind.data_hash[:countries].select{|x| x[:id] == value[:country]}.first
          #       if c.present?
          #         csv << [tp[:name], c[:name], value[:value]]
          #       end
          #     end
          #   end
          # end
        end

      when INDICATOR_TYPES[:composite]
        indices = ext_ind.indices.sorted
        header = [I18n.t('activerecord.attributes.verdict.time_period'), I18n.t('shared.categories.overall')]
        header << indices.map{|x| x.name}
        header.flatten!

        CSV.generate do |csv|
          csv << header

          time.each do |tp|
            row = [tp.name, tp.overall_value]
            # add each index value
            indices.each do |index|
              d = tp.data.select{|x| x.index_id == index.id}.first
              if d.present?
                row << d.value.to_f
              else
                row << ''
              end
            end
            csv << row


          end

        end


        # CSV.generate do |csv|
        #   csv << header
        #   ext_ind.data_hash[:data].each do |data|
        #     tp = ext_ind.data_hash[:time_periods].select{|x| x[:id] == data[:time_period]}.first
        #     if tp.present?
        #       csv << [tp[:name], 'Overall', data[:overall_value]]
        #       data[:values].each do |value|
        #         i = ext_ind.data_hash[:indexes].select{|x| x[:id] == value[:index]}.first
        #         if i.present?
        #           csv << [tp[:name], i[:short_name], value[:value]]
        #         end
        #       end
        #     end
        #   end
        # end

    end
  end

  #######################
  ## METHODS

  def is_basic?
    self.indicator_type == INDICATOR_TYPES[:basic]
  end

  def is_country?
    self.indicator_type == INDICATOR_TYPES[:country]
  end

  def is_composite?
    self.indicator_type == INDICATOR_TYPES[:composite]
  end

  def full_title(delim = ' - ')
    "#{self.title}#{delim}#{self.subtitle}"
  end

  # return one of following:
  # - min-max
  # - > min
  # - < max
  def range
    x = ''
    if min.present? && max.present?
      x = "#{min} - #{max}"
    elsif min.present?
      x = "> #{min}"
    elsif max.present?
      x = "< #{max}"
    end
    return x
  end

  # get the name of the indicator type
  def indicator_type_name
    I18n.t("shared.external_indicators.indicator_types.#{INDICATOR_TYPES.keys[INDICATOR_TYPES.values.index(self.indicator_type)]}")
  end

  # get the name of the chart type
  def chart_type_name
    I18n.t("shared.external_indicators.chart_types.#{CHART_TYPES.keys[CHART_TYPES.values.index(self.chart_type)]}")
  end

  # get the name of the scale type
  def scale_type_name
    I18n.t("shared.external_indicators.scale_types.#{SCALE_TYPES.keys[SCALE_TYPES.values.index(self.scale_type)]}")
  end

  # if this is country and line -> line
  # else if line -> area
  # else column
  def custom_highchart_type
    if chart_type == CHART_TYPES[:bar]
      'external-indicator-bar'
    else
      if indicator_type == INDICATOR_TYPES[:country]
        'external-indicator-line-time-series'
      else
        'external-indicator-area-time-series'
      end
    end
  end

  def unit_is_percent?
    scale_type == SCALE_TYPES[:percent]
  end

  def unit
    unit_is_percent? ? '%' : nil
  end

  def unit_label
    unit_is_percent? ? I18n.t('shared.common.percent') : nil
  end

  # format the data for charting
  # - use the indicator type to create the proper hash format for charting
  # format: title, subtitle, min, max, categories[], series[ {name: '', data: [ {y, change} ] } ]
  # - if the index is composite, there will be an additional item in output with all of the composite index values
  #   format: indexes[ {name: '', data: [ {y, change} ] } ]
  def format_for_charting
    hash = {
      id: "external-indicator-#{id}",
      chartType: custom_highchart_type,
      description: description,
      title: title,
      subtitle: subtitle,
      min: min,
      max: max,
      unitLabel: unit_label,
      categories: [],
      series: [],
      plot_bands: nil,
      use_decimals: use_decimals
    }

    # add x-axis lables (categories)
    time = self.time_periods.sorted
    hash[:categories] = time.map{|x| x.name}

    # if there are plot bands, add them
    plot_bands = self.plot_bands.sorted
    if plot_bands.present?
      hash[:plot_bands] = []
      plot_bands.each_with_index do |pb, index|
        hash[:plot_bands] << {from: pb.from, to: pb.to, text: pb.name, opacity: (0.4 + index*0.6/(plot_bands.length-1))}
      end
    end

    dash_styles = [
      'Dot',
      'LongDash',
      'ShortDash',
      'ShortDot',
      'ShortDashDot',
      'LongDashDotDot'
    ]

    # add data
    # based off of indicator type, build the data accordingly
    case indicator_type
    when INDICATOR_TYPES[:basic]
      # hash[:series] << {data: self.data_hash[:data].map{|x| {y: x[:values].first[:value], change: x[:values].first[:change]}}}
      data = []
      time.each do |x|
        if x.data.present?
          data << {y: x.data.first.value.to_f, change: x.data.first.change}
        else
          data << {y: nil, change: nil}
        end
      end
      hash[:series] << {
        name: I18n.t('shared.categories.overall'),
        data: data
      }

      # if this indciator has a benchmark, add it
      if self.has_benchmark?
        hash[:series] << {
          name: self.benchmark_title,
          data: time.map{|x| {y: x.data.select{|x| x.is_benchmark}.first.value.to_f, change: x.data.select{|x| x.is_benchmark}.first.change} },
          isBenchmark: true
        }
      end

    when INDICATOR_TYPES[:country]

      self.countries.sorted.each_with_index do |country, index|
        # start the item for the series
        item = {
          name: country.name,
          dashStyle: dash_styles[index % dash_styles.length],
          data: []
        }

        # for each time period, get the country data
        time.each do |tp|
          # get country data
          d = tp.data.select{|x| x.country_id == country.id}.first
          if d.present?
            item[:data] << {
              y: d.value.to_f,
              change: d.change
            }
          else
            item[:data] << {
              y: nil,
              change: nil
            }
          end
        end

        hash[:series] << item
      end

      # if this indciator has a benchmark, add it
      if self.has_benchmark?
        # start the item for the series
        item = {
          name: self.benchmark_title,
          dashStyle: nil,
          data: [],
          isBenchmark: true
        }

        # for each time period, get the benchmark data
        time.each do |tp|
          # get data
          d = tp.data.select{|x| x.is_benchmark?}.first
          if d.present?
            item[:data] << {
              y: d.value.to_f,
              change: d.change
            }
          else
            item[:data] << {
              y: nil,
              change: nil
            }
          end
        end

        hash[:series] << item
      end



      # data_hash[:countries].each_with_index do |country, index|

      #   item = {
      #     name: country[:name],
      #     dashStyle: dash_styles[index % dash_styles.length],
      #     data: []
      #   }

      #   data_hash[:data].each do |data|

      #     # find the data item for this country
      #     d = data[:values].find do |x|
      #       x[:country] == country[:id]
      #     end

      #     if d.present?
      #       item[:data] << {
      #         y: d[:value],
      #         change: d[:change]
      #       }
      #     else
      #       item[:data] << {
      #         y: nil,
      #         change: nil
      #       }
      #     end
      #   end

      #   hash[:series] << item
      # end

    when INDICATOR_TYPES[:composite]
      # the overall value is first
      hash[:series] << {
        name: I18n.t('shared.categories.overall'),
        data: time.map do |x|
          {
            y: x.overall_value.to_f,
            change: x.overall_change
          }
        end
      }

      # get the index values
      hash[:indexes] = []
      self.indices.sorted.each_with_index do |ind, index|
        item = {name: ind.name, short_name: ind.short_name, data: []}

        # for each time period, get the index data
        time.each do |tp|
          # get index data
          d = tp.data.select{|x| x.index_id == ind.id}.first
          if d.present?
            item[:data] << {
              y: d.value.to_f,
              change: d.change
            }
          else
            item[:data] << {
              y: nil,
              change: nil
            }
          end
        end
        hash[:indexes] << item
      end

      # if this indciator has a benchmark, add it
      if self.has_benchmark?
        # start the item for the series
        item = {
          name: self.benchmark_title,
          data: [],
          isBenchmark: true
        }

        # for each time period, get the benchmark data
        time.each do |tp|
          # get data
          d = tp.data.select{|x| x.is_benchmark?}.first
          if d.present?
            item[:data] << {
              y: d.value.to_f,
              change: d.change
            }
          else
            item[:data] << {
              y: nil,
              change: nil
            }
          end
        end

        hash[:series] << item
      end


      # # get the overall values for charting
      # hash[:series] << {
      #   name: I18n.t('shared.categories.overall'),
      #   data: data_hash[:data].map do |x|
      #     {
      #       y: x[:overall_value],
      #       change: x[:overall_change]
      #     }
      #   end
      # }

      # # get the index values
      # hash[:indexes] = []
      # self.data_hash[:indexes].each do |index|
      #   item = {name: index[:name], short_name: index[:short_name], data: []}
      #   self.data_hash[:data].each do |data|
      #     # find the data item for this index
      #     d = data[:values].select{|x| x[:index] == index[:id]}.first
      #     if d.present?
      #       item[:data] << {
      #         y: d[:value],
      #         change: d[:change]
      #       }
      #     else
      #       item[:data] << {
      #         y: nil,
      #         change: nil
      #       }
      #     end
      #   end
      #   hash[:indexes] << item
      # end
    end

    return hash

  end

  def format_for_charting_old
    hash = {
      id: "external-indicator-#{id}",
      chartType: custom_highchart_type,
      description: description,
      title: title,
      subtitle: subtitle,
      min: min,
      max: max,
      unitLabel: unit_label,
      categories: [],
      series: []
    }

    # add x-axis lables (categories)
    time = self.time_periods.sorted
    hash[:categories] = time.map{|x| x.name}

    dash_styles = [
      'Solid',
      'Dot',
      'LongDash',
      'ShortDash',
      'ShortDot',
      'ShortDashDot',
      'LongDashDotDot'
    ]

    # add data
    # based off of indicator type, build the data accordingly
    case indicator_type
    when INDICATOR_TYPES[:basic]
      hash[:series] << {data: self.data_hash[:data].map{|x| {y: x[:values].first[:value], change: x[:values].first[:change]}}}
    when INDICATOR_TYPES[:country]

      data_hash[:countries].each_with_index do |country, index|

        item = {
          name: country[:name],
          dashStyle: dash_styles[index % dash_styles.length],
          data: []
        }

        data_hash[:data].each do |data|

          # find the data item for this country
          d = data[:values].find do |x|
            x[:country] == country[:id]
          end

          if d.present?
            item[:data] << {
              y: d[:value],
              change: d[:change]
            }
          else
            item[:data] << {
              y: nil,
              change: nil
            }
          end
        end

        hash[:series] << item
      end

    when INDICATOR_TYPES[:composite]

      # get the overall values for charting
      hash[:series] << {
        name: I18n.t('shared.categories.overall'),
        data: data_hash[:data].map do |x|
          {
            y: x[:overall_value],
            change: x[:overall_change]
          }
        end
      }

      # get the index values
      hash[:indexes] = []
      self.data_hash[:indexes].each do |index|
        item = {name: index[:name], short_name: index[:short_name], data: []}
        self.data_hash[:data].each do |data|
          # find the data item for this index
          d = data[:values].select{|x| x[:index] == index[:id]}.first
          if d.present?
            item[:data] << {
              y: d[:value],
              change: d[:change]
            }
          else
            item[:data] << {
              y: nil,
              change: nil
            }
          end
        end
        hash[:indexes] << item
      end
    end

    if hash[:chartType] == 'external-indicator-area-time-series'
      hash[:translations] = {
        fail: I18n.t('shared.chart_rating_categories.external_indicators.fail'),
        poor: I18n.t('shared.chart_rating_categories.external_indicators.poor'),
        fair: I18n.t('shared.chart_rating_categories.external_indicators.fair'),
        good: I18n.t('shared.chart_rating_categories.external_indicators.good'),
      }
    end

    return hash

  end



  #######################
  #######################
  private

  # after load, populate data hash
  # format: {
  #   time_periods: [{id, name}]
  #   countries: [{id, name}]
  #   indexes: [{id, name, short_name, description, change_multiplier}]
  #   data: [{time_period, overall_value, overall_change, values[{index/country, value, change}] }]
  # }
  def load_data_hash
    self.data_hash = self.data.present? ? JSON.parse(self.data, symbolize_names: true) : {}
    return true
  end

  # convert the data hash to json string
  def set_data
    self.data = self.data_hash.to_json if self.data_hash.present?
    return true
  end

  def set_sort_order
    if !show_on_home_page
      self.sort_order = nil
      return true
    end

    if show_on_home_page && self.sort_order.blank?
      self.sort_order = 1
      return true
    end

    return true
  end

  def reset_unwanted_fields
    if self.indicator_type == INDICATOR_TYPES[:country]
      # this is country, so index records are not needed
      self.indices.destroy_all
    elsif self.indicator_type == INDICATOR_TYPES[:composite]
      # this is index, so country records are not needed
      self.countries.destroy_all
    end
    return true
  end

  # set the change value when compared to the last time period
  def set_change_values
    if self.update_change_values == true
      if self.time_periods.length == 1
        # there is only one record, so all change values should be nil
        self.time_periods.each do |tp|
          tp.overall_change = nil
          tp.data.each do |datum|
            datum.change = nil
          end
        end
      else
        # compare each time period with the previous time period and compute the change value
        # start with the most recent and go backwards
        (self.time_periods.length-1).downto(1).each do |index|
          current = self.time_periods[index]
          previous = self.time_periods[index-1]

          # if this is composite indicator, then update the overall_change in time period
          if self.is_composite?
            current.overall_change = compute_change(current.overall_value, previous.overall_value)
          end

          # compute change for the data values
          current.data.each_with_index do |current_datum, current_index|
            if self.is_country?
              # find country in previous
              previous_datum = previous.data.select{|x| x.country_id == current_datum.country_id}.first
              if previous_datum.present?
                current_datum.change = compute_change(current_datum.value, previous_datum.value)
              else
                # could not find the previous matching record, so reset to nil
                current_datum.change = nil
              end

            elsif self.is_composite?
              # find index in previous
              previous_datum = previous.data.select{|x| x.index_id == current_datum.index_id}.first
              if previous_datum.present?
                # get change_multiplier value for this index
                index = self.indices.select{|x| x.id == current_datum.index_id}.first
                current_datum.change = compute_change(current_datum.value, previous_datum.value, index.present? ? index.change_multiplier : 1)
              else
                # could not find the previous matching record, so reset to nil
                current_datum.change = nil
              end

            else # basic
              previous_datum = previous.data[current_index]
              if previous_datum.present?
                current_datum.change = compute_change(current_datum.value, previous_datum.value)
              else
                # could not find the previous matching record, so reset to nil
                current_datum.change = nil
              end
            end
          end
        end
      end
    end

    return true
  end

  # any change in value is a change
  def compute_change(current_value, previous_value, change_multiplier=1)
    return nil if current_value.nil? || previous_value.nil?

    diff = current_value - previous_value
    change = nil
    if diff < 0
      change = -1
    elsif diff > 0
      change = 1
    else
      change = 0
    end

    return change * change_multiplier
  end


  #######################
  #######################

  def has_required_translations?(trans)
    trans.title.present?
  end

  def add_missing_translations(default_trans)
    self.title = default_trans.title if self["title_#{Globalize.locale}"].blank?
  end

end
