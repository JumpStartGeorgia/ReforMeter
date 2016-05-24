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
    pc.content = '<p>I have no idea.</p>'
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

    # create reform
    puts 'creating test reform'
    reform1 = Reform.create(name: 'Test Reform 1', summary: '<p>This is a brief summary about test reform 1.</p>', reform_color_id: rc_colors.sample.id)
    reform2 = Reform.create(name: 'Another Test Reform 2', summary: '<p>This is a brief summary about test reform 2.</p>', reform_color_id: rc_colors.sample.id)
    reform3 = Reform.create(name: 'Reform 3', summary: '<p>This is a brief summary about test reform 3.</p>', reform_color_id: rc_colors.sample.id)

    # create experts
    puts 'creating experts'
    exp1 = Expert.create(name: 'Expert One', bio: '<p>Expert One is cool cat from Sesame Street.</p>')
    exp2 = Expert.create(name: 'Expert Two', bio: '<p>Expert Two doesn\'t know how to get to Sesame Street.</p>')
    exp3 = Expert.create(name: 'Expert Three', bio: '<p>Expert Three was born and raised on Sesame Street.</p>')

    # create quarters
    puts 'creating quarters'
    path = "#{Rails.root}/db/test_report_files/"
    report_en = File.new(path + 'sample_report1.pdf')
    q2 = Quarter.create(year: 2015, quarter: 2, is_public: true, report: report_en, summary_good: '<p>this is awesome!</p>', summary_bad: '<p>this is not good!</p>')
    q3 = Quarter.create(year: 2015, quarter: 3, is_public: true, report: report_en, summary_good: '<p>this is ok!</p>', summary_bad: '<p>no progress has been made!</p>')
    q4 = Quarter.create(year: 2015, quarter: 4, is_public: true, report: report_en, summary_good: '<p>good effort!</p>', summary_bad: '<p>are you even working?!</p>')

    # create expert surveys
    puts 'creating expert surveys'
    es = q2.create_expert_survey(overall_score: 6.4, category1_score: 6, category2_score: 8, category3_score: 5, summary: '<p>this is a summary</p>', details: 'Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p><p> Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam. Causae dolores reformidans ea pri, usu pericula forensibus in, utroque nusquam explicari no sit.</p>')
    es.experts << exp1
    es.experts << exp2

    es = q3.create_expert_survey(overall_score: 5.36, category1_score: 5.8, category2_score: 6, category3_score: 4.5,
                                overall_change: -1, category1_change: 0, category2_change: -1, category3_change: -1,
                                summary: '<p>sit amet, te duo probo timeam</p>', details: 'Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus. Ferri commune voluptatibus ne sed. </p><p>Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam.</p>')
    es.experts << exp2
    es.experts << exp3

    es = q4.create_expert_survey(overall_score: 6.82, category1_score: 6.5, category2_score: 8.3, category3_score: 5.5,
                                overall_change: 1, category1_change: 1, category2_change: 1, category3_change: 1,
                                summary: '<p>this is a summary</p>', details: 'Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam. </p><p>Causae dolores reformidans ea pri, usu pericula forensibus in, utroque nusquam explicari no sit.</p>')
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



    puts 'LOADING TEST DATA DONE'
  end
end
