# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).

roles = %w(super_admin site_admin content_manager)
roles.each do |role|
  Role.find_or_create_by(name: role)
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
# expert methodology
PageContent.find_or_create_by(name: 'methodology_expert') do |pc|
    puts 'creating page content for methodology expert'
    pc.title = 'Expert Survey Methodology'
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
# expert text
PageContent.find_or_create_by(name: 'expert_text') do |pc|
    puts 'creating page content for expert text'
    pc.title = 'Experts'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end
# download text
PageContent.find_or_create_by(name: 'download_text') do |pc|
    puts 'creating page content for download text'
    pc.title = 'Download Data & Reports'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end
# download expert text
PageContent.find_or_create_by(name: 'download_expert_text') do |pc|
    puts 'creating page content for download expert text'
    pc.title = 'Experts'
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


# if the env variable of load_test_data exists, load the data
if ENV['load_test_data'].present?
  puts 'LOADING TEST DATA'
  Quarter.transaction do
    # first clear all data
    puts 'deleting data in database (quarter, reform, experts, survey data, etc)'
    Quarter.destroy_all
    Reform.destroy_all
    Expert.destroy_all
    ExternalIndicator.destroy_all

    # create reform
    puts 'creating test reform'
    reform1 = Reform.create(name: 'Innovations', summary: '<p>This is a brief summary about test reform 1.</p>', reform_color_id: rc_colors.sample.id)
    reform2 = Reform.create(name: 'Land Market Development', summary: '<p>This is a brief summary about test reform 2.</p>', reform_color_id: rc_colors.sample.id)
    reform3 = Reform.create(name: 'Insolvency', summary: '<p>This is a brief summary about test reform 3.</p>', reform_color_id: rc_colors.sample.id)

    # create experts
    puts 'creating experts'
    exp1 = Expert.create(name: 'Expert One', bio: '<p>Expert One is cool cat from Sesame Street.</p>')
    exp2 = Expert.create(name: 'Expert Two', bio: '<p>Expert Two doesn\'t know how to get to Sesame Street.</p>')
    exp3 = Expert.create(name: 'Expert Three', bio: '<p>Expert Three was born and raised on Sesame Street.</p>')

    # create quarters
    puts 'creating quarters'
    path = "#{Rails.root}/db/test_report_files/"
    report_en = File.open(path + 'sample_report1.pdf')
    q2 = Quarter.create(year: 2015, quarter: 2, is_public: true, report: report_en, summary_good: '<p>this is awesome!</p>', summary_bad: '<p>this is not good!</p>')
    q3 = Quarter.create(year: 2015, quarter: 3, is_public: true, report: report_en, summary_good: '<p>this is ok!</p>', summary_bad: '<p>no progress has been made!</p>')
    q4 = Quarter.create(year: 2015, quarter: 4, is_public: true, report: report_en, summary_good: '<p>good effort!</p>', summary_bad: '<p>are you even working?!</p>')

    # create expert surveys
    puts 'creating expert surveys'
    es = q2.create_expert_survey(overall_score: 6.4, category1_score: 6, category2_score: 8, category3_score: 5, summary: '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p>', details: 'Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p><p> Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam. Causae dolores reformidans ea pri, usu pericula forensibus in, utroque nusquam explicari no sit.</p>')
    es.experts << exp1
    es.experts << exp2

    es = q3.create_expert_survey(overall_score: 5.36, category1_score: 5.8, category2_score: 6, category3_score: 4.5,
                                overall_change: -1, category1_change: 0, category2_change: -1, category3_change: -1,
                                summary: '<p>sit amet, te duo probo timeam</p>', details: 'Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus. Ferri commune voluptatibus ne sed. </p><p>Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam.</p>')
    es.experts << exp2
    es.experts << exp3

    es = q4.create_expert_survey(overall_score: 6.82, category1_score: 6.5, category2_score: 8.3, category3_score: 5.5,
                                overall_change: 1, category1_change: 1, category2_change: 1, category3_change: 1,
                                summary: '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p><p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p><p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p>', details: 'Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam. </p><p>Causae dolores reformidans ea pri, usu pericula forensibus in, utroque nusquam explicari no sit.</p>')
    es.experts << exp1
    es.experts << exp3

    # create reform surveys
    puts 'creating reform surveys'
    reform_survey_scores = [
      [63.5, 70, 35, 62, 80, 5.6,6,6.8,4.2],
      [65, 72, 38, 63, 80, 5.36, 5.8, 6, 4.5],
      [66.9, 73, 41, 65, 82, 6.82, 6.5, 8.3, 5.5],
    ]

    (0..2).each do |index|
      id = index == 0 ? reform1.id : index == 1  ? reform2.id : reform3.id
      score_indexes = index == 0 ? [0,1,2] : index == 1  ? [1,2,0] : [2,1,0]
      rs2, rs3, rs4 = nil
      # do not create value for 3rd reform in q2
      if index != 2
        rs2 = q2.reform_surveys.create(reform_id: id,
                government_overall_score: reform_survey_scores[score_indexes[0]][0],government_category1_score: reform_survey_scores[score_indexes[0]][1],
                government_category2_score: reform_survey_scores[score_indexes[0]][2],government_category3_score: reform_survey_scores[score_indexes[0]][3],
                government_category4_score: reform_survey_scores[score_indexes[0]][4], stakeholder_overall_score: reform_survey_scores[score_indexes[0]][5],
                stakeholder_category1_score: reform_survey_scores[score_indexes[0]][6],stakeholder_category2_score: reform_survey_scores[score_indexes[0]][7],
                stakeholder_category3_score: reform_survey_scores[score_indexes[0]][8],
                summary: 'this is a summary', government_summary: 'this is a government summary', stakeholder_summary: 'this is a stakeholder summary')
      end
      rs3 = q3.reform_surveys.create(reform_id: id,
              government_overall_score: reform_survey_scores[score_indexes[1]][0],government_category1_score: reform_survey_scores[score_indexes[1]][1],
              government_category2_score: reform_survey_scores[score_indexes[1]][2],government_category3_score: reform_survey_scores[score_indexes[1]][3],
              government_category4_score: reform_survey_scores[score_indexes[1]][4], stakeholder_overall_score: reform_survey_scores[score_indexes[1]][5],
              stakeholder_category1_score: reform_survey_scores[score_indexes[1]][6],stakeholder_category2_score: reform_survey_scores[score_indexes[1]][7],
              stakeholder_category3_score: reform_survey_scores[score_indexes[1]][8],
              summary: 'this is a summary', government_summary: 'this is a government summary', stakeholder_summary: 'this is a stakeholder summary')
      if rs2
        rs3.government_overall_change = rs3.compute_government_change(rs2.government_overall_score, rs3.government_overall_score)
        rs3.government_category1_change = rs3.compute_government_change(rs2.government_category1_score, rs3.government_category1_score)
        rs3.government_category2_change = rs3.compute_government_change(rs2.government_category2_score, rs3.government_category2_score)
        rs3.government_category3_change = rs3.compute_government_change(rs2.government_category3_score, rs3.government_category3_score)
        rs3.government_category4_change = rs3.compute_government_change(rs2.government_category4_score, rs3.government_category4_score)
        rs3.stakeholder_overall_change = rs3.compute_stakeholder_change(rs2.stakeholder_overall_score, rs3.stakeholder_overall_score)
        rs3.stakeholder_category1_change = rs3.compute_stakeholder_change(rs2.stakeholder_category1_score, rs3.stakeholder_category1_score)
        rs3.stakeholder_category2_change = rs3.compute_stakeholder_change(rs2.stakeholder_category2_score, rs3.stakeholder_category2_score)
        rs3.stakeholder_category3_change = rs3.compute_stakeholder_change(rs2.stakeholder_category3_score, rs3.stakeholder_category3_score)
        rs3.save

      end
      rs4 = q4.reform_surveys.create(reform_id: id,
              government_overall_score: reform_survey_scores[score_indexes[2]][0],government_category1_score: reform_survey_scores[score_indexes[2]][1],
              government_category2_score: reform_survey_scores[score_indexes[2]][2],government_category3_score: reform_survey_scores[score_indexes[2]][3],
              government_category4_score: reform_survey_scores[score_indexes[2]][4], stakeholder_overall_score: reform_survey_scores[score_indexes[2]][5],
              stakeholder_category1_score: reform_survey_scores[score_indexes[2]][6],stakeholder_category2_score: reform_survey_scores[score_indexes[2]][7],
              stakeholder_category3_score: reform_survey_scores[score_indexes[2]][8],
              summary: 'this is a summary', government_summary: 'this is a government summary', stakeholder_summary: 'this is a stakeholder summary')

      rs4.government_overall_change = rs4.compute_government_change(rs3.government_overall_score, rs4.government_overall_score)
      rs4.government_category1_change = rs4.compute_government_change(rs3.government_category1_score, rs4.government_category1_score)
      rs4.government_category2_change = rs4.compute_government_change(rs3.government_category2_score, rs4.government_category2_score)
      rs4.government_category3_change = rs4.compute_government_change(rs3.government_category3_score, rs4.government_category3_score)
      rs4.government_category4_change = rs4.compute_government_change(rs3.government_category4_score, rs4.government_category4_score)
      rs4.stakeholder_overall_change = rs4.compute_stakeholder_change(rs3.stakeholder_overall_score, rs4.stakeholder_overall_score)
      rs4.stakeholder_category1_change = rs4.compute_stakeholder_change(rs3.stakeholder_category1_score, rs4.stakeholder_category1_score)
      rs4.stakeholder_category2_change = rs4.compute_stakeholder_change(rs3.stakeholder_category2_score, rs4.stakeholder_category2_score)
      rs4.stakeholder_category3_change = rs4.compute_stakeholder_change(rs3.stakeholder_category3_score, rs4.stakeholder_category3_score)
      rs4.save

    end

    # create news
    puts 'creating news'
    path = "#{Rails.root}/db/test_image_files/"
    News.create(quarter_id: q4.id, title: 'This is expert news', content: '<p>this is expert news for Q4 2015</p>', url: 'http://google.ge')
    News.create(quarter_id: q4.id, reform_id: reform3.id, title: 'This is reform news', content: "<p>this is #{reform3.name} reform news for Q4 2015</p>", url: 'http://google.ge')
    News.create(quarter_id: q4.id, reform_id: reform3.id, title: 'This is more reform news', content: '<p>this is additional expert news for Q4 2015 with image!</p>', url: 'http://google.ge', image: File.new(path + '1.jpg'))
    News.create(quarter_id: q4.id, reform_id: reform2.id, title: 'This is reform news', content: "<p>this is #{reform3.name} reform news for Q4 2015</p>", url: 'http://google.ge')
    News.create(quarter_id: q4.id, reform_id: reform2.id, title: 'This is more reform news', content: '<p>this is additional expert news for Q4 2015 with image!</p>', url: 'http://google.ge', image: File.new(path + '1.jpg'))
    News.create(quarter_id: q3.id, title: 'This is expert news', content: '<p>this is expert news for Q3 2015</p>', url: 'http://google.ge', image: File.new(path + '2.jpg'))
    News.create(quarter_id: q3.id, title: 'This is more expert news', content: '<p>this is more expert news for Q3 2015</p>', url: 'http://google.ge', image: File.new(path + '3.jpg'))
    News.create(quarter_id: q3.id, reform_id: reform2.id, title: 'This is reform news', content: "<p>this is #{reform3.name} reform news for Q4 2015</p>", url: 'http://google.ge', image: File.new(path + '4.jpg'))
    News.create(quarter_id: q3.id, reform_id: reform1.id, title: 'This is reform news', content: "<p>this is #{reform3.name} reform news for Q4 2015</p>", url: 'http://google.ge')


    # external indicators
    puts 'creating external indicators'
    ei1 = ExternalIndicator.new(title: 'Growth of Total Factor Productivity', scale_type: 2, indicator_type: 2, chart_type: 2, is_public: true)
    data = {
      countries: [
        {id: 1, name: 'Georgia'},
        {id: 2, name: 'Estonia'},
        {id: 3, name: 'Armenia'},
        {id: 4, name: 'Azerbaijan'}
      ],
      time_periods: [
        {id: 1, name: '2003'},
        {id: 2, name: '2004'},
        {id: 3, name: '2005'},
        {id: 4, name: '2006'},
        {id: 5, name: '2007'},
        {id: 6, name: '2008'},
        {id: 7, name: '2009'},
        {id: 8, name: '2010'},
        {id: 9, name: '2011'},
        {id: 10, name: '2012'},
        {id: 11, name: '2013'},
        {id: 12, name: '2014'},
      ],
      data: [
        {time_period: 1, values: [
          {country: 1, value: 1.8, change: nil},
          {country: 2, value: 2.5, change: nil},
          {country: 3, value: 11.6, change: nil},
          {country: 4, value: 1.9, change: nil}
        ]},
        {time_period: 2, values: [
          {country: 1, value: -3.2, change: -1},
          {country: 2, value: 3.0, change: 1},
          {country: 3, value: 9.5, change: -1},
          {country: 4, value: -1.5, change: -1}
        ]},
        {time_period: 3, values: [
          {country: 1, value: 1.7, change: 1},
          {country: 2, value: 4.2, change: 1},
          {country: 3, value: 9.2, change: -1},
          {country: 4, value: 13.1, change: 1}
        ]},
        {time_period: 4, values: [
          {country: 1, value: 1.4, change: -1},
          {country: 2, value: 3.8, change: -1},
          {country: 3, value: 8.7, change: -1},
          {country: 4, value: 19.2, change: 1}
        ]},
        {time_period: 5, values: [
          {country: 1, value: 5.5, change: 1},
          {country: 2, value: 3.2, change: -1},
          {country: 3, value: 7.7, change: -1},
          {country: 4, value: 12.1, change: -1}
        ]},
        {time_period: 6, values: [
          {country: 1, value: -1.0, change: -1},
          {country: 2, value: -7.2, change: -1},
          {country: 3, value: 1.0, change: -1},
          {country: 4, value: -0.1, change: -1}
        ]},
        {time_period: 7, values: [
          {country: 1, value: -7.6, change: -1},
          {country: 2, value: -4.6, change: 1},
          {country: 3, value: -17.3, change: -1},
          {country: 4, value: 0.1, change: 1}
        ]},
        {time_period: 8, values: [
          {country: 1, value: 5.2, change: 1},
          {country: 2, value: 4.7, change: 1},
          {country: 3, value: -2.6, change: 1},
          {country: 4, value: -1.3, change: -1}
        ]},
        {time_period: 9, values: [
          {country: 1, value: 4.2, change: -1},
          {country: 2, value: 2.4, change: -1},
          {country: 3, value: 3.9, change: 1},
          {country: 4, value: -4.8, change: -1}
        ]},
        {time_period: 10, values: [
          {country: 1, value: 3.2, change: -1},
          {country: 2, value: 3.2, change: 1},
          {country: 3, value: 4.9, change: 1},
          {country: 4, value: -3.1, change: 1}
        ]},
        {time_period: 11, values: [
          {country: 1, value: 2.7, change: -1},
          {country: 2, value: 0.1, change: -1},
          {country: 3, value: 2.1, change: -1},
          {country: 4, value: 0.0, change: 1}
        ]},
        {time_period: 12, values: [
          {country: 1, value: 3.8, change: 1},
          {country: 2, value: 0.6, change: 1},
          {country: 3, value: 0.9, change: -1},
          {country: 4, value: -3.1, change: -1}
        ]}
      ]
    }
    ei1.data = data.to_json
    ei1.save
    ei1.reforms << reform1


    ei2 = ExternalIndicator.new(title: 'How do people feel about the economy?', subtitle: 'Georgian Economic Sentiment Index (G-ESI)', description: 'A confidence index of +100 would indicate that economic agents (consumers and businesses) were much more confident about future prospects, while -100 would indicate that all survey respondents were much less confident about future prospects.', scale_type: 2, indicator_type: 3, chart_type: 2, min: -100, max: 100, show_on_home_page: true, is_public: true)
    data = {
      indexes: [
        {id: 1, name: 'Business Confidence Index', short_name: 'BCI', change_multiplier: 1},
        {id: 2, name: 'Consumer Confidence Index', short_name: 'CCI', change_multiplier: 1}
      ],
      time_periods: [
        {id: 1, name: 'Q1 2015'},
        {id: 2, name: 'Q2 2015'},
        {id: 3, name: 'Q3 2015'},
        {id: 4, name: 'Q4 2015'},
        {id: 5, name: 'Q1 2016'}
      ],
      data: [
        {time_period: 1, overall_value: -5.64961274, overall_change: nil, values: [
          {index: 1, value: 24.52426211, change: nil},
          {index: 2, value: -25.76552931, change: nil}
        ]},
        {time_period: 2, overall_value: -19.60873495, overall_change: -1, values: [
          {index: 1, value: 3.610635446, change: -1},
          {index: 2, value: -35.08831522, change: -1}
        ]},
        {time_period: 3, overall_value: -14.68866731, overall_change: 1, values: [
          {index: 1, value: 14.814046, change: 1},
          {index: 2, value: -34.35714286, change: 1}
        ]},
        {time_period: 4, overall_value: -16.94167264, overall_change: -1, values: [
          {index: 1, value: 11.98510412, change: -1},
          {index: 2, value: -36.22619048, change: -1}
        ]},
        {time_period: 5, overall_value: -16.6468132, overall_change: -1, values: [
          {index: 1, value: 14.01850071, change: -1},
          {index: 2, value: -37.09035581, change: -1}
        ]}
      ]
    }
    ei2.data = data.to_json
    ei2.save
    ei2.reforms << reform2


    ei3 = ExternalIndicator.new(title: 'How is the economy doing?', subtitle: 'Georgian Economic Performance Index (G-EPI)', scale_type: 1, indicator_type: 3, chart_type: 1, min: 0, max: 100, show_on_home_page: true, is_public: true)
    data = {
      indexes: [
        {id: 1, name: 'Difference in borrowing and lending rates of financial institutions', short_name: 'Net Interest Spread', change_multiplier: -1},
        {id: 2, name: 'Georgia’s performance in the OECD Programme for International Student Assessment (Pisa)', short_name: 'Pisa', change_multiplier: 1},
        {id: 3, name: 'Waste water treatment capacity per capita', short_name: 'Waste water treatment capacity per capita', change_multiplier: 1},
        {id: 4, name: 'The change in real GDP', short_name: '%∆GDP', change_multiplier: 1},
        {id: 5, name: 'Dollarization rate of the Georgian economy', short_name: 'Dollarization Rate', change_multiplier: -1},
        {id: 6, name: 'Share of investment in total GDP ', short_name: 'Investment % of GDP', change_multiplier: 1},
        {id: 7, name: 'Degree of export diversification across major geographic jurisdictions', short_name: 'Export Diversification', change_multiplier: 1},
        {id: 8, name: 'Degree of export innovation (measured as the share of new products and services in total exports)', short_name: 'Creative Export', change_multiplier: 1},
        {id: 9, name: 'Share of formally employed in Georgia’s total population', short_name: 'Formal Employment', change_multiplier: 1},
        {id: 10, name: 'Gini coefficient as measure of income inequality', short_name: 'Gini', change_multiplier: -1}
      ],
      time_periods: [
        {id: 1, name: '2003'},
        {id: 2, name: '2004'},
        {id: 3, name: '2005'},
        {id: 4, name: '2006'},
        {id: 5, name: '2007'},
        {id: 6, name: '2008'},
        {id: 7, name: '2009'},
        {id: 8, name: '2010'},
        {id: 9, name: '2011'},
        {id: 10, name: '2012'},
        {id: 11, name: '2013'},
        {id: 12, name: '2014'}
      ],
      data: [
        {time_period: 1, overall_value: 81.91367201, overall_change: nil, values: [
          {index: 1, value: 4.7852, change: nil},
          {index: 2, value: 11.50112799, change: nil},
          {index: 3, value: 1.8, change: nil},
          {index: 4, value: nil, change: nil},
          {index: 5, value: 86.43, change: nil},
          {index: 6, value: 5.5, change: nil},
          {index: 7, value: 25, change: nil},
          {index: 8, value: 2, change: nil},
          {index: 9, value: 16, change: nil},
          {index: 10, value: 0.4, change: nil}
        ]},
        {time_period: 1, overall_value: 87.01985371, overall_change: 1, values: [
          {index: 1, value: 5.6564, change: -1},
          {index: 2, value: 12.62374629, change: 1},
          {index: 3, value: 0.3, change: -1},
          {index: 4, value: 5.6, change: 1},
          {index: 5, value: 73.80, change: 1},
          {index: 6, value: 6, change: 1},
          {index: 7, value: 28, change: 1},
          {index: 8, value: 2.5, change: 1},
          {index: 9, value: 16, change: 0},
          {index: 10, value: 0.4, change: 0}
        ]},
        {time_period: 1, overall_value: 85.7529, overall_change: -1, values: [
          {index: 1, value: 8.2471, change: -1},
          {index: 2, value: 13.8, change: 1},
          {index: 3, value: 2.6, change: 1},
          {index: 4, value: 10.4, change: 1},
          {index: 5, value: 69.98, change: 1},
          {index: 6, value: 7.067718937, change: 1},
          {index: 7, value: 33.74824224, change: 1},
          {index: 8, value: 3.991048066, change: 1},
          {index: 9, value: 17.2178668, change: 1},
          {index: 10, value: 0.4, change: 0}
        ]},
        {time_period: 1, overall_value: 83.439, overall_change: -1, values: [
          {index: 1, value: 9.161, change: -1},
          {index: 2, value: 13.6, change: -1},
          {index: 3, value: 3.4, change: 1},
          {index: 4, value: 9.6, change: -1},
          {index: 5, value: 67.26, change: 1},
          {index: 6, value: 15.10950314, change: 1},
          {index: 7, value: 32.86554748, change: -1},
          {index: 8, value: 2.801545486, change: -1},
          {index: 9, value: 16.8142681, change: -1},
          {index: 10, value: 0.45, change: -1}
        ]},
        {time_period: 1, overall_value: 84.4551, overall_change: 1, values: [
          {index: 1, value: 9.2449, change: -1},
          {index: 2, value: 13.3, change: -1},
          {index: 3, value: 4.8, change: 1},
          {index: 4, value: 11.8, change: 1},
          {index: 5, value: 62.30, change: 1},
          {index: 6, value: 18.34073446, change: 1},
          {index: 7, value: 31.20571571, change: -1},
          {index: 8, value: 3.188808309, change: 1},
          {index: 9, value: 17.29774582, change: 1},
          {index: 10, value: 0.46, change: -1}
        ]},
        {time_period: 1, overall_value: 69.9005, overall_change: -1, values: [
          {index: 1, value: 9.9995, change: -1},
          {index: 2, value: 16.5, change: 1},
          {index: 3, value: 6.5, change: 1},
          {index: 4, value: 2.9, change: -1},
          {index: 5, value: 72.55, change: -1},
          {index: 6, value: 12.37460741, change: -1},
          {index: 7, value: 28.61997207, change: -1},
          {index: 8, value: 4.1354565, change: 1},
          {index: 9, value: 15.78071217, change: -1},
          {index: 10, value: 0.45, change: 1}
        ]},
        {time_period: 1, overall_value: 67.5725, overall_change: -1, values: [
          {index: 1, value: 1.7275, change: 1},
          {index: 2, value: 16.9, change: 1},
          {index: 3, value: 9.2, change: 1},
          {index: 4, value: -4.6, change: -1},
          {index: 5, value: 68.85, change: 1},
          {index: 6, value: 6.012966012, change: -1},
          {index: 7, value: 29.73941121, change: 1},
          {index: 8, value: 5.131097741, change: 1},
          {index: 9, value: 16.39159325, change: 1},
          {index: 10, value: 0.46, change: -1}
        ]},
        {time_period: 1, overall_value: 76.089, overall_change: 1, values: [
          {index: 1, value: 7.111, change: -1},
          {index: 2, value: 16.3, change: -1},
          {index: 3, value: 6.7, change: -1},
          {index: 4, value: 6.2, change: 1},
          {index: 5, value: 67.11, change: 1},
          {index: 6, value: 7.443187587, change: 1},
          {index: 7, value: 34.95113295, change: 1},
          {index: 8, value: 4.516608352, change: -1},
          {index: 9, value: 16.80923801, change: 1},
          {index: 10, value: 0.46, change: 0}
        ]},
        {time_period: 1, overall_value: 79.9567, overall_change: 1, values: [
          {index: 1, value: 8.5433, change: -1},
          {index: 2, value: 15.1, change: -1},
          {index: 3, value: 3.6, change: -1},
          {index: 4, value: 7.2, change: 1},
          {index: 5, value: 58.57, change: 1},
          {index: 6, value: 5.96709492, change: -1},
          {index: 7, value: 36.24242342, change: 1},
          {index: 8, value: 4.597467412, change: 1},
          {index: 9, value: 17.03495663, change: 1},
          {index: 10, value: 0.46, change: 0}
        ]},
        {time_period: 1, overall_value: 87.6563, overall_change: 1, values: [
          {index: 1, value: -0.9437, change: 1},
          {index: 2, value: 15, change: -1},
          {index: 3, value: 2.8, change: -1},
          {index: 4, value: 6.4, change: -1},
          {index: 5, value: 60.35, change: -1},
          {index: 6, value: 2.687611656, change: 1},
          {index: 7, value: 38.15052258, change: 1},
          {index: 8, value: 4.609485818, change: 1},
          {index: 9, value: 17.73322949, change: 1},
          {index: 10, value: 0.43, change: 1}
        ]},
        {time_period: 1, overall_value: 85.588, overall_change: -1, values: [
          {index: 1, value: -0.512, change: -1},
          {index: 2, value: 14.6, change: -1},
          {index: 3, value: 2.6, change: -1},
          {index: 4, value: 3.3, change: -1},
          {index: 5, value: 55.67, change: 1},
          {index: 6, value: 4.370229431, change: 1},
          {index: 7, value: 44.68923236, change: 1},
          {index: 8, value: 4.091340424, change: -1},
          {index: 9, value: 17.68974394, change: -1},
          {index: 10, value: 0.42, change: 1}
        ]},
        {time_period: 1, overall_value: 86.1312, overall_change: 1, values: [
          {index: 1, value: 3.0688, change: -1},
          {index: 2, value: 12.4, change: -1},
          {index: 3, value: 3.2, change: 1},
          {index: 4, value: 4.8, change: 1},
          {index: 5, value: 57.08, change: -1},
          {index: 6, value: 9.965800826, change: 1},
          {index: 7, value: 42.88995091, change: -1},
          {index: 8, value: 3.912538767, change: -1},
          {index: 9, value: 18.60355085, change: 1},
          {index: 10, value: 0.41, change: 1}
        ]}
      ]
    }
    ei3.data = data.to_json
    ei3.save

    ei4 = ExternalIndicator.new(title: 'Georgia Growth of Total Factor Productivity', scale_type: 2, indicator_type: 1, chart_type: 1, is_public: true)
    data = {
      time_periods: [
        {id: 1, name: '2003'},
        {id: 2, name: '2004'},
        {id: 3, name: '2005'},
        {id: 4, name: '2006'},
        {id: 5, name: '2007'},
        {id: 6, name: '2008'},
        {id: 7, name: '2009'},
        {id: 8, name: '2010'},
        {id: 9, name: '2011'},
        {id: 10, name: '2012'},
        {id: 11, name: '2013'},
        {id: 12, name: '2014'},
      ],
      data: [
        {time_period: 1, values: [
          {value: 1.8, change: nil}
        ]},
        {time_period: 2, values: [
          {value: -3.2, change: -1}
        ]},
        {time_period: 3, values: [
          {value: 1.7, change: 1}
        ]},
        {time_period: 4, values: [
          {value: 1.4, change: -1}
        ]},
        {time_period: 5, values: [
          {value: 5.5, change: 1}
        ]},
        {time_period: 6, values: [
          {value: -1.0, change: -1}
        ]},
        {time_period: 7, values: [
          {value: -7.6, change: -1}
        ]},
        {time_period: 8, values: [
          {value: 5.2, change: 1}
        ]},
        {time_period: 9, values: [
          {value: 4.2, change: -1}
        ]},
        {time_period: 10, values: [
          {value: 3.2, change: -1}
        ]},
        {time_period: 11, values: [
          {value: 2.7, change: -1}
        ]},
        {time_period: 12, values: [
          {value: 3.8, change: 1}
        ]}
      ]
    }
    ei4.data = data.to_json
    ei4.save
    ei4.reforms << reform1
    ei4.reforms << reform2
    ei4.reforms << reform3

    ei5 = ExternalIndicator.new(title: 'Line Chart Total Factor Productivity', scale_type: 2, indicator_type: 2, chart_type: 1, is_public: true)
    data = {
      countries: [
        {id: 1, name: 'Georgia'},
        {id: 2, name: 'Estonia'},
        {id: 3, name: 'Armenia'},
        {id: 4, name: 'Azerbaijan'}
      ],
      time_periods: [
        {id: 1, name: '2003'},
        {id: 2, name: '2004'},
        {id: 3, name: '2005'},
        {id: 4, name: '2006'},
        {id: 5, name: '2007'},
        {id: 6, name: '2008'},
        {id: 7, name: '2009'},
        {id: 8, name: '2010'},
        {id: 9, name: '2011'},
        {id: 10, name: '2012'},
        {id: 11, name: '2013'},
        {id: 12, name: '2014'},
      ],
      data: [
        {time_period: 1, values: [
          {country: 1, value: 1.8, change: nil},
          {country: 2, value: 2.5, change: nil},
          {country: 3, value: 11.6, change: nil},
          {country: 4, value: 1.9, change: nil}
        ]},
        {time_period: 2, values: [
          {country: 1, value: -3.2, change: -1},
          {country: 2, value: 3.0, change: 1},
          {country: 3, value: 9.5, change: -1},
          {country: 4, value: -1.5, change: -1}
        ]},
        {time_period: 3, values: [
          {country: 1, value: 1.7, change: 1},
          {country: 2, value: 4.2, change: 1},
          {country: 3, value: 9.2, change: -1},
          {country: 4, value: 13.1, change: 1}
        ]},
        {time_period: 4, values: [
          {country: 1, value: 1.4, change: -1},
          {country: 2, value: 3.8, change: -1},
          {country: 3, value: 8.7, change: -1},
          {country: 4, value: 19.2, change: 1}
        ]},
        {time_period: 5, values: [
          {country: 1, value: 5.5, change: 1},
          {country: 2, value: 3.2, change: -1},
          {country: 3, value: 7.7, change: -1},
          {country: 4, value: 12.1, change: -1}
        ]},
        {time_period: 6, values: [
          {country: 1, value: -1.0, change: -1},
          {country: 2, value: -7.2, change: -1},
          {country: 3, value: 1.0, change: -1},
          {country: 4, value: -0.1, change: -1}
        ]},
        {time_period: 7, values: [
          {country: 1, value: -7.6, change: -1},
          {country: 2, value: -4.6, change: 1},
          {country: 3, value: -17.3, change: -1},
          {country: 4, value: 0.1, change: 1}
        ]},
        {time_period: 8, values: [
          {country: 1, value: 5.2, change: 1},
          {country: 2, value: 4.7, change: 1},
          {country: 3, value: -2.6, change: 1},
          {country: 4, value: -1.3, change: -1}
        ]},
        {time_period: 9, values: [
          {country: 1, value: 4.2, change: -1},
          {country: 2, value: 2.4, change: -1},
          {country: 3, value: 3.9, change: 1},
          {country: 4, value: -4.8, change: -1}
        ]},
        {time_period: 10, values: [
          {country: 1, value: 3.2, change: -1},
          {country: 2, value: 3.2, change: 1},
          {country: 3, value: 4.9, change: 1},
          {country: 4, value: -3.1, change: 1}
        ]},
        {time_period: 11, values: [
          {country: 1, value: 2.7, change: -1},
          {country: 2, value: 0.1, change: -1},
          {country: 3, value: 2.1, change: -1},
          {country: 4, value: 0.0, change: 1}
        ]},
        {time_period: 12, values: [
          {country: 1, value: 3.8, change: 1},
          {country: 2, value: 0.6, change: 1},
          {country: 3, value: 0.9, change: -1},
          {country: 4, value: -3.1, change: -1}
        ]}
      ]
    }
    ei5.data = data.to_json
    ei5.save
    ei5.reforms << reform1

    puts 'LOADING TEST DATA DONE'
  end
end
