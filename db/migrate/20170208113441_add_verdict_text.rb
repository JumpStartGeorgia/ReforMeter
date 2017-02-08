class AddVerdictText < ActiveRecord::Migration
  def up
    # add new
    PageContent.find_or_create_by(name: 'verdict') do |pc|
        puts 'creating page content for verdict'
        pc.title = 'ReformVerdict'
        pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
    end

  end

  def down
    PageContent.where(name: 'verdict').destroy_all
  end
end
