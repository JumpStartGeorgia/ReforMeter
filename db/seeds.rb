# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# run-time variables (set these to true if you want seeds to run them):
# 1. create_user_accounts
# 2. delete_page_content
# 3. delete_reform_colors
# 4. delete_test_data
# 5. load_test_data
#
# To load seeds with all variables set to true:
#
# bundle exec rake db:seed create_user_accounts=true delete_page_content=true delete_reform_colors=true delete_test_data=true load_test_data=true

roles = %w(super_admin site_admin content_manager)
roles.each do |role|
  Role.find_or_create_by(name: role)
end

# if this is not production
# and variable is set, create users if not exist
if ENV['create_user_accounts'].present? && !Rails.env.production?
  puts "LOADING TEST USER ACCOUNTS"
  User.find_or_create_by(email: 'site.admin@test.ge') do |u|
    puts "creating site admin"
    u.password = 'password123'
    u.role_id = 2
  end

  User.find_or_create_by(email: 'content.manager@test.ge') do |u|
    puts "creating content manager"
    u.password = 'password123'
    u.role_id = 3
  end
end


if ENV['delete_page_content'].present?
  puts 'DELETING PAGE CONTENT'
  PageContent.destroy_all
end


# load page content records with placeholder text
# home page about
PageContent.find_or_create_by(name: 'home_page_about') do |pc|
    puts 'creating page content for home page about'
    pc.title = 'What are Reforms?'
    pc.content = '<p>Reforms are where changes are made in order to improve something.</p>'
end
# review board methodology
PageContent.find_or_create_by(name: 'methodology_review_board') do |pc|
    puts 'creating page content for methodology review board'
    pc.title = 'Review Board Survey Methodology'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end
# government methodology
PageContent.find_or_create_by(name: 'methodology_government') do |pc|
    puts 'creating page content for methodology government'
    pc.title = 'Government Survey Methodology'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end
# stakeholder methodolgy
PageContent.find_or_create_by(name: 'methodology_stakeholder') do |pc|
    puts 'creating page content for methodology stakeholder'
    pc.title = 'Stakeholder Survey Methodology'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end
# about text
PageContent.find_or_create_by(name: 'about_text') do |pc|
    puts 'creating page content for about text'
    pc.title = 'About ReforMeter'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end
# reform text
PageContent.find_or_create_by(name: 'reform_text') do |pc|
    puts 'creating page content for reform text'
    pc.title = 'What are Reforms?'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end
# review board text
PageContent.find_or_create_by(name: 'review_board_text') do |pc|
    puts 'creating page content for review board text'
    pc.title = 'Review Board'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end
# download text
PageContent.find_or_create_by(name: 'download_text') do |pc|
    puts 'creating page content for download text'
    pc.title = 'Download Data & Reports'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end
# download review board text
PageContent.find_or_create_by(name: 'download_review_board_text') do |pc|
    puts 'creating page content for download review board text'
    pc.title = 'Review Board'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit.</p>'
end
# download reform text
PageContent.find_or_create_by(name: 'download_reform_text') do |pc|
    puts 'creating page content for download reform text'
    pc.title = 'Reforms'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit.</p>'
end
# download ext ind text
PageContent.find_or_create_by(name: 'download_external_indicator_text') do |pc|
    puts 'creating page content for download external indicators text'
    pc.title = 'External Indicators'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit.</p>'
end
# download reports text
PageContent.find_or_create_by(name: 'download_report_text') do |pc|
    puts 'creating page content for download report text'
    pc.title = 'Quarterly Reports'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit.</p>'
end
# contact intro text
PageContent.find_or_create_by(name: 'contact_text') do |pc|
    puts 'creating page content for contact text'
    pc.title = 'Contact'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit.</p>'
end



if ENV['delete_reform_colors'].present?
  puts 'DELETING REFORM COLORS'
  ReformColor.destroy_all
end

# load reform colors
colors = %w{#4dc1bb #2bb673 #e0689e #7668dd #8dabd8 #6ab1d8 #9fd66b #d6c654 #fbb040 #db9f4f #d86a50 #e84646 #5dcec8 #b464bf}
rc_colors = []
colors.each do |color|
  rc_colors << ReformColor.find_or_create_by(hex: color) do |rc|
    puts 'creating reform color: ' + color
    rc.hex = color
  end
end

if ENV['delete_test_data'].present? || ENV['load_test_data'].present?
  # first clear all data
  puts 'deleting data in database (quarter, reform, experts, survey data, etc)'
  Quarter.destroy_all
  Reform.destroy_all
  Expert.destroy_all
  ExternalIndicator.destroy_all
  News.destroy_all
end


# if the env variable of load_test_data exists, load the data
if ENV['load_test_data'].present?
  puts 'LOADING TEST DATA'

  # create reform
  puts 'creating test reform'
  reform1 = Reform.create(name: 'Innovations', summary: 'This is a brief summary about test reform 1.', reform_color_id: rc_colors.delete_at(rand(rc_colors.length)).id)
  reform2 = Reform.create(name: 'Land Market Development', summary: 'This is a brief summary about test reform 2.', reform_color_id: rc_colors.delete_at(rand(rc_colors.length)).id)
  reform3 = Reform.create(name: 'Insolvency', summary: 'This is a brief summary about test reform 3.', reform_color_id: rc_colors.delete_at(rand(rc_colors.length)).id)
  reform4 = Reform.create(name: 'Outsolvency', summary: 'This is the outsolvency reform.', reform_color_id: rc_colors.delete_at(rand(rc_colors.length)).id)

  # create board members
  puts 'creating board members'
  exp1 = Expert.create(name: 'Giorgi Gamkharashvili', bio: 'Giorgi Gamkharashvili is cool cat from Sesame Street.')
  exp2 = Expert.create(name: 'Mariam Macharashvili', bio: 'Mariam Macharashvili doesn\'t know how to get to Sesame Street.')
  exp3 = Expert.create(name: 'Irakli Sultanishvili', bio: 'Irakli Sultanishvili was born and raised on Sesame Street.')

  # create quarters
  puts 'creating quarters'
  path = "#{Rails.root}/db/test_report_files/"
  report_en = File.open(path + 'sample_report1.pdf')
  q2 = Quarter.create(year: 2015, quarter: 2, report: report_en, summary_good: 'this is awesome!', summary_bad: 'this is not good!')
  q3 = Quarter.create(year: 2015, quarter: 3, report: report_en, summary_good: 'this is ok!', summary_bad: 'no progress has been made!')
  q4 = Quarter.create(year: 2015, quarter: 4, report: report_en, summary_good: 'good effort!', summary_bad: 'are you even working?!')

  # create board member surveys
  puts 'creating expert surveys'
  es = q2.create_expert_survey(overall_score: 6.4, category1_score: 6, category2_score: 8, category3_score: 5,
                              summary: 'Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.', details: '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p><p> Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam. Causae dolores reformidans ea pri, usu pericula forensibus in, utroque nusquam explicari no sit.</p>')
  es.experts << exp1
  es.experts << exp2

  es = q3.create_expert_survey(overall_score: 5.36, category1_score: 5.8, category2_score: 6, category3_score: 4.5,
                              summary: 'sit amet, te duo probo timeam', details: '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus. Ferri commune voluptatibus ne sed. </p><p>Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam.</p>')
  es.experts << exp2
  es.experts << exp3

  es = q4.create_expert_survey(overall_score: 6.82, category1_score: 6.5, category2_score: 8.3, category3_score: 5.5,
                              summary: 'Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus. Lorem ipsum dolor sit amet, te duo probo timeam salutandi.', details: '<p>Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam. </p><p>Causae dolores reformidans ea pri, usu pericula forensibus in, utroque nusquam explicari no sit.</p>')
  es.experts << exp1
  es.experts << exp3

  # create reform surveys
  puts 'creating reform surveys'
  reform_survey_scores = [
    [
      [63.5, 70, 35, 62, 80, 5.6,6,6.8,4.2],
      [65, 72, 38, 63, 80, 5.36, 5.8, 6, 4.5],
      [66.9, 73, 41, 65, 82, 6.82, 6.5, 8.3, 5.5],
    ],
    [
      [23.5, 30, 35, 62, 80, 5.6,6,6.8,4.2],
      [35, 42, 38, 63, 80, 5.36, 5.8, 6, 4.5],
      [46.9, 53, 41, 65, 82, 6.82, 6.5, 8.3, 5.5],
    ],
    [
      [63, 50, 35, 62, 80, 5.6,6,6.8,4.2],
      [63, 52, 58, 63, 80, 5.36, 5.8, 6, 4.5],
      [63, 73, 71, 63, 82, 6.82, 6.5, 8.3, 5.5],
    ],
    [
      [33.5, 30, 35, 62, 80, 5.6,6,6.8,4.2],
      [35, 42, 38, 63, 80, 5.36, 5.8, 6, 4.5],
      [35, 53, 41, 65, 82, 6.82, 6.5, 8.3, 5.5],
    ]
  ]

  (0..3).each do |index|
    id = index == 0 ? reform1.id : index == 1  ? reform2.id : index == 2 ? reform3.id : reform4.id
#    score_indexes = index == 0 ? [0,1,2] : index == 1  ? [1,2,0] : index == 2 ? [2,1,0] : [2, 0, 1]
    rs2, rs3, rs4 = nil
    # do not create value for 3rd reform in q2
    if index != 2
      rs2 = q2.reform_surveys.create(reform_id: id,
              government_overall_score: reform_survey_scores[index][0][0],government_category1_score: reform_survey_scores[index][0][1],
              government_category2_score: reform_survey_scores[index][0][2],government_category3_score: reform_survey_scores[index][0][3],
              government_category4_score: reform_survey_scores[index][0][4], stakeholder_overall_score: reform_survey_scores[index][0][5],
              stakeholder_category1_score: reform_survey_scores[index][0][6],stakeholder_category2_score: reform_survey_scores[index][0][7],
              stakeholder_category3_score: reform_survey_scores[index][0][8],
              summary: 'this is a summary', government_summary: '<p>this is a government summary</p>', stakeholder_summary: '<p>this is a stakeholder summary</p>')
    end

    if index != 3
      rs3 = q3.reform_surveys.create(reform_id: id,
              government_overall_score: reform_survey_scores[index][1][0],government_category1_score: reform_survey_scores[index][1][1],
              government_category2_score: reform_survey_scores[index][1][2],government_category3_score: reform_survey_scores[index][1][3],
              government_category4_score: reform_survey_scores[index][1][4], stakeholder_overall_score: reform_survey_scores[index][1][5],
              stakeholder_category1_score: reform_survey_scores[index][1][6],stakeholder_category2_score: reform_survey_scores[index][1][7],
              stakeholder_category3_score: reform_survey_scores[index][1][8],
              summary: 'this is a summary', government_summary: '<p>this is a government summary</p>', stakeholder_summary: '<p>this is a stakeholder summary</p>')

      rs4 = q4.reform_surveys.create(reform_id: id,
              government_overall_score: reform_survey_scores[index][2][0],government_category1_score: reform_survey_scores[index][2][1],
              government_category2_score: reform_survey_scores[index][2][2],government_category3_score: reform_survey_scores[index][2][3],
              government_category4_score: reform_survey_scores[index][2][4], stakeholder_overall_score: reform_survey_scores[index][2][5],
              stakeholder_category1_score: reform_survey_scores[index][2][6],stakeholder_category2_score: reform_survey_scores[index][2][7],
              stakeholder_category3_score: reform_survey_scores[index][2][8],
              summary: 'this is a summary', government_summary: '<p>this is a government summary</p>', stakeholder_summary: '<p>this is a stakeholder summary</p>')
    end

  end

  # publish the quarters
  # - have to do this after the survey results are created for they are required for published
  q2.is_public = true
  q2.save
  q3.is_public = true
  q3.save
  q4.is_public = true
  q4.save


  # create news
  puts 'creating news'
  path = "#{Rails.root}/db/test_image_files/"
  News.create(quarter_id: q4.id, title: 'This is review board news', content: 'this is review board news for Q4 2015', url: 'http://google.ge')
  News.create(quarter_id: q4.id, reform_id: reform3.id, title: 'This is reform news', content: "this is #{reform3.name} reform news for Q4 2015", url: 'http://google.ge')
  News.create(quarter_id: q4.id, reform_id: reform3.id, title: 'This is more reform news', content: 'this is additional review board news for Q4 2015 with image!', url: 'http://google.ge', image: File.new(path + '1.jpg'))
  News.create(quarter_id: q4.id, reform_id: reform2.id, title: 'This is reform news', content: "this is #{reform3.name} reform news for Q4 2015", url: 'http://google.ge')
  News.create(quarter_id: q4.id, reform_id: reform2.id, title: 'This is more reform news', content: 'this is additional review board news for Q4 2015 with image!', url: 'http://google.ge', image: File.new(path + '1.jpg'))
  News.create(quarter_id: q3.id, title: 'This is review board news', content: 'this is review board news for Q3 2015', url: 'http://google.ge', image: File.new(path + '2.jpg'))
  News.create(quarter_id: q3.id, title: 'This is more review board news', content: 'this is more review board news for Q3 2015', url: 'http://google.ge', image: File.new(path + '3.jpg'))
  News.create(quarter_id: q3.id, reform_id: reform2.id, title: 'This is reform news', content: "this is #{reform3.name} reform news for Q4 2015", url: 'http://google.ge', image: File.new(path + '4.jpg'))
  News.create(quarter_id: q3.id, reform_id: reform1.id, title: 'This is reform news', content: "this is #{reform3.name} reform news for Q4 2015", url: 'http://google.ge')



  # external indicators
  csv_path = "#{Rails.root}/db/test_external_indicator_files/"
  puts 'creating external indicators'

  ei = ExternalIndicator.new(title: 'Growth of Total Factor Productivity', scale_type: 2, indicator_type: 2, chart_type: 2, is_public: true, description: 'This is the external indicator for the growth of total factor productivity.')
  csv_data = CSV.read(csv_path + 'growth.csv')

  # countries
  csv_data[0].each_with_index do |header, index|
    if index > 0
      ei.countries.build(name: header, sort_order: index)
    end
  end

  # times
  csv_data.map{|x| x[0]}.each_with_index do |time, index|
    if index > 0
      ei.time_periods.build(name: time, sort_order: index)
    end
  end
  ei.save

  #data
  csv_data.each_with_index do |row, r_index|
    if r_index > 0
      time = ei.time_periods[r_index-1]

      row.each_with_index do |cell, c_index|
        if c_index > 0
          time.data.build(country_id: ei.countries[c_index-1].id, value: row[c_index])
        end
      end
    end
  end
  ei.update_change_values = true
  ei.save
  ei.reforms << reform1


  ei = ExternalIndicator.new(title: 'How do people feel about the economy?', subtitle: 'Georgian Economic Sentiment Index (G-ESI)', description: 'A confidence index of +100 would indicate that economic agents (consumers and businesses) were much more confident about future prospects, while -100 would indicate that all survey respondents were much less confident about future prospects.', scale_type: 2, indicator_type: 3, chart_type: 2, min: -100, max: 100, show_on_home_page: true, sort_order: 2, is_public: true)
  csv_data = CSV.read(csv_path + 'gesi.csv')

  # indices
  ei.indices.build(name: 'Business Confidence Index', short_name: 'BCI', sort_order: 1)
  ei.indices.build(name: 'Consumer Confidence Index', short_name: 'CCI', sort_order: 2)

  # plot bands
  ei.plot_bands.build(name_en: 'Negative', name_ka: 'უარყოფითი', from: -100, to: -33)
  ei.plot_bands.build(name_en: 'Neutral', name_ka: 'საშუალო', from: -33, to: 33)
  ei.plot_bands.build(name_en: 'Positive', name_ka: 'დადებითი', from: 33, to: 100)

  # times
  csv_data.map{|x| x[0]}.each_with_index do |time, index|
    if index > 0
      ei.time_periods.build(name: time, sort_order: index)
    end
  end
  ei.save

  #data
  csv_data.each_with_index do |row, r_index|
    if r_index > 0
      time = ei.time_periods[r_index-1]

      row.each_with_index do |cell, c_index|
        if c_index > 0
          if c_index == 1
            time.overall_value = row[c_index]
          else
            time.data.build(index_id: ei.indices[c_index-2].id, value: row[c_index])
          end
        end
      end
    end
  end
  ei.update_change_values = true
  ei.save
  ei.reforms << reform2


  ei = ExternalIndicator.new(title: 'How is the economy doing?', subtitle: 'Georgian Economic Performance Index (G-EPI)', scale_type: 1, indicator_type: 3, chart_type: 1, min: 0, max: 100, show_on_home_page: true, sort_order: 1, is_public: true)
  csv_data = CSV.read(csv_path + 'gepi.csv')

  # indices
  ei.indices.build(name: 'Difference in borrowing and lending rates of financial institutions', short_name: 'Net Interest Spread', change_multiplier: -1, sort_order: 1)
  ei.indices.build(name: 'Georgia’s performance in the OECD Programme for International Student Assessment (Pisa)', short_name: 'Pisa', change_multiplier: 1, sort_order: 2)
  ei.indices.build(name: 'Waste water treatment capacity per capita', short_name: 'Waste water treatment capacity per capita', change_multiplier: 1, sort_order: 3)
  ei.indices.build(name: 'The change in real GDP', short_name: '%∆GDP', change_multiplier: 1, sort_order: 4)
  ei.indices.build(name: 'Dollarization rate of the Georgian economy', short_name: 'Dollarization Rate', change_multiplier: -1, sort_order: 5)
  ei.indices.build(name: 'Share of investment in total GDP ', short_name: 'Investment % of GDP', change_multiplier: 1, sort_order: 6)
  ei.indices.build(name: 'Degree of export diversification across major geographic jurisdictions', short_name: 'Export Diversification', change_multiplier: 1, sort_order: 7)
  ei.indices.build(name: 'Degree of export innovation (measured as the share of new products and services in total exports)', short_name: 'Creative Export', change_multiplier: 1, sort_order: 8)
  ei.indices.build(name: 'Share of formally employed in Georgia’s total population', short_name: 'Formal Employment', change_multiplier: 1, sort_order: 9)
  ei.indices.build(name: 'Gini coefficient as measure of income inequality', short_name: 'Gini', change_multiplier: -1, sort_order: 10)

  # plot bands
  ei.plot_bands.build(name_en: 'Poor', name_ka: 'ცუდი', from: 0, to: 33)
  ei.plot_bands.build(name_en: 'Fair', name_ka: 'საშუალო', from: 34, to: 66)
  ei.plot_bands.build(name_en: 'Good', name_ka: 'კარგი', from: 67, to: 100)

  # times
  csv_data.map{|x| x[0]}.each_with_index do |time, index|
    if index > 0
      ei.time_periods.build(name: time, sort_order: index)
    end
  end
  ei.save

  #data
  csv_data.each_with_index do |row, r_index|
    if r_index > 0
      time = ei.time_periods[r_index-1]

      row.each_with_index do |cell, c_index|
        if c_index > 0
          if c_index == 1
            time.overall_value = row[c_index]
          else
            time.data.build(index_id: ei.indices[c_index-2].id, value: row[c_index])
          end
        end
      end
    end
  end
  ei.update_change_values = true
  ei.save



  ei = ExternalIndicator.new(title: 'Georgia Growth of Total Factor Productivity', scale_type: 2, indicator_type: 1, chart_type: 1, is_public: true)
  csv_data = CSV.read(csv_path + 'geo_growth.csv')

  # times
  csv_data.map{|x| x[0]}.each_with_index do |time, index|
    if index > 0
      ei.time_periods.build(name: time, sort_order: index)
    end
  end
  ei.save

  #data
  csv_data.each_with_index do |row, r_index|
    if r_index > 0
      time = ei.time_periods[r_index-1]

      row.each_with_index do |cell, c_index|
        if c_index > 0
          time.data.build(value: row[c_index])
        end
      end
    end
  end
  ei.update_change_values = true
  ei.save
  ei.reforms << reform1
  ei.reforms << reform2
  ei.reforms << reform3


  ei = ExternalIndicator.new(title: 'Line Chart Total Factor Productivity', subtitle: 'This is the very loooooong subtitle of Line Chart Total Factor Productivity', scale_type: 2, indicator_type: 2, chart_type: 1, is_public: true)
  csv_data = CSV.read(csv_path + 'growth.csv')

  # countries
  csv_data[0].each_with_index do |header, index|
    if index > 0
      ei.countries.build(name: header, sort_order: index)
    end
  end

  # times
  csv_data.map{|x| x[0]}.each_with_index do |time, index|
    if index > 0
      ei.time_periods.build(name: time, sort_order: index)
    end
  end
  ei.save

  #data
  csv_data.each_with_index do |row, r_index|
    if r_index > 0
      time = ei.time_periods[r_index-1]

      row.each_with_index do |cell, c_index|
        if c_index > 0
          time.data.build(country_id: ei.countries[c_index-1].id, value: row[c_index])
        end
      end
    end
  end
  ei.update_change_values = true
  ei.save
  ei.reforms << reform1

  puts 'LOADING TEST DATA DONE'
end
