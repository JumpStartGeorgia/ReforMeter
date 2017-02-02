class AddNewPagecontent < ActiveRecord::Migration
  def up
    # add new

    PageContent.find_or_create_by(name: 'methodology_general') do |pc|
        puts 'creating page content for general methodology'
        pc.title = 'Methodology'
        pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
    end

    # remove old
    PageContent.where(name: 'methodology_review_board').destroy_all
    PageContent.where(name: 'review_board_text').destroy_all
    PageContent.where(name: 'download_review_board_text').destroy_all

  end

  def down
    PageContent.where(name: 'methodology_general').destroy_all

    PageContent.find_or_create_by(name: 'methodology_review_board') do |pc|
        puts 'creating page content for methodology review board'
        pc.title = 'Review Board Survey Methodology'
        pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
    end

    PageContent.find_or_create_by(name: 'review_board_text') do |pc|
        puts 'creating page content for review board text'
        pc.title = 'Review Board'
        pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
    end

    PageContent.find_or_create_by(name: 'download_review_board_text') do |pc|
        puts 'creating page content for download review board text'
        pc.title = 'Review Board'
        pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit.</p>'
    end
  end
end
