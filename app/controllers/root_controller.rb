# Non-resource pages
class RootController < ApplicationController
  def index
    @home_page_about = PageContent.find_by(name: 'home_page_about')

    @quarter = Quarter.latest
    @reforms = Reform.active.sorted.highlight

    # get the survey data for charting
    expert_survey_data = Quarter.expert_survey_data_for_charting(overall_score_only: true)

    reform_survey_data = []
    @reforms.each do |reform|
      reform_survey_data << Quarter.reform_survey_data_for_charting(reform.id, overall_score_only: true)
    end

  end

  def about
    @about_text = PageContent.find_by(name: 'about_text')
    @methodology_expert = PageContent.find_by(name: 'methodology_expert')
    @methodology_government = PageContent.find_by(name: 'methodology_government')
    @methodology_stakeholder = PageContent.find_by(name: 'methodology_stakeholder')
  end

  def download_data_and_reports
    @download_text = PageContent.find_by(name: 'download_text')
    @download_expert_text = PageContent.find_by(name: 'download_expert_text')
    @download_reform_text = PageContent.find_by(name: 'download_reform_text')
    @download_external_indicator_text = PageContent.find_by(name: 'download_external_indicator_text')
    @download_report_text = PageContent.find_by(name: 'download_report_text')

    @reforms = Reform.active.sorted
    @quarters = Quarter.published.recent

    # if there is a download request, process it
    if request.post? && params[:type].present?
      data,filename = nil
      is_csv = false
      case params[:type]
        when 'expert'
          data = Quarter.to_csv('expert')
          filename = 'ReforMeter_Expert_Data'
          is_csv = true
        when 'reform'
          reform = Reform.friendly.find(params[:reform_id])
          if reform
            data = Quarter.to_csv('reform', reform.id)
            filename = "ReforMeter_#{reform.name}_Reform_Data"
            is_csv = true
          else

          end
        when 'external_indicator'
          is_csv = true
        when 'report'
          # just need the url to the file
          quarter = @quarters.select{|x| x.slug == params[:quarter]}.first
          data = quarter.report.path if quarter
      end

      # send the file
      if data
        if is_csv
          send_data data, filename: clean_filename("#{filename}-#{I18n.l(Time.now, :format => :file)}") + ".csv"
        else
          ext = File.extname(data)
          filename = File.basename(data, ext)
          send_file data, filename: clean_filename("#{filename}-#{I18n.l(Time.now, :format => :file)}") + ext
        end
      end
    end
  end

  def reforms
    @reform_text = PageContent.find_by(name: 'reform_text')
    @quarters = Quarter.published.recent
    @reforms = Reform.active.sorted.with_color
    @reform_surveys = ReformSurvey.in_quarters(@quarters.map{|x| x.id}) if @quarters.present?

    reform_survey_data = []
    @reforms.each do |reform|
      reform_survey_data << Quarter.reform_survey_data_for_charting(reform.id, overall_score_only: true)
    end
  end

  def reform_show
    begin
      @quarter = Quarter.published.with_expert_survey.friendly.find(params[:quarter_id])
      @reform = Reform.active.with_color.friendly.find(params[:reform_id])
      @reform_survey = ReformSurvey.for_reform(@reform.id).in_quarter(@quarter.id).first if @quarter && @reform

      if @reform.nil? || @quarter.nil? || @reform_survey.nil?
        redirect_to reforms_path,
                alert: t('shared.msgs.does_not_exist')
      end

      @active_reforms = Reform.active_reforms_array
      @active_quarters = Quarter.active_quarters_array
      @methodology_government = PageContent.find_by(name: 'methodology_government')
      @methodology_stakeholder = PageContent.find_by(name: 'methodology_stakeholder')

      # get the reform survey data for charting
      survey_data = {
        government: Quarter.reform_survey_data_for_charting(@reform.id),
        stakeholder: Quarter.reform_survey_data_for_charting(@reform.id, type: 'stakeholder')
      }

    rescue ActiveRecord::RecordNotFound  => e
      redirect_to experts_path,
                alert: t('shared.msgs.does_not_exist')
    end
  end

  def experts
    @expert_text = PageContent.find_by(name: 'expert_text')
    @methodology_expert = PageContent.find_by(name: 'methodology_expert')

    @quarters = Quarter.published.recent.with_expert_survey

    # get the expert survey data for charting
    survey_data = Quarter.expert_survey_data_for_charting

  end

  def expert_show
    begin
      @quarter = Quarter.published.with_expert_survey.friendly.find(params[:id])

      if @quarter.nil?
        redirect_to experts_path,
                alert: t('shared.msgs.does_not_exist')
      end

      @active_quarters = Quarter.active_quarters_array
      @methodology_expert = PageContent.find_by(name: 'methodology_expert')

      # get the expert survey data for charting
      survey_data = Quarter.expert_survey_data_for_charting

      # set the chart data into gon variables
      gon.expert_overall_score = @quarter.expert_survey.overall_score.to_f
      gon.expert_overall_change_icon = view_context.generate_change_icon(@quarter.expert_survey.overall_change)

    rescue ActiveRecord::RecordNotFound => e
      redirect_to experts_path,
                alert: t('shared.msgs.does_not_exist')
    end
  end

end
