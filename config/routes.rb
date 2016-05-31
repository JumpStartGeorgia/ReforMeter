Rails.application.routes.draw do
  scope ':locale', locale: /#{I18n.available_locales.join("|")}/ do
    post '/users', to: 'users#create'

    devise_for :users,
               controllers: {
                 confirmations: 'users/confirmations',
                 omniauth: 'users/omniauth',
                 passwords: 'users/passwords',
                 registrations: 'users/registrations',
                 sessions: 'users/sessions',
                 unlocks: 'users/unlocks'
               },
               path_names: {sign_in: 'login', sign_out: 'logout'},
               constraints: { format: :html }

    match '/admin', :to => 'admin#index', :as => :admin, :via => :get
    namespace :admin do
      resources :users, constraints: { format: :html }
      resources :page_contents, constraints: { format: :html }
    end

    get '/contact' => 'root#contact'
    get '/about' => 'root#about'
    get '/download_data_and_reports' => 'root#download_data_and_reports'
    post '/download_data_and_reports' => 'root#download_data_and_reports'
    get '/reforms' => 'root#reforms'
    # if there is no time period then send back to reforms page with reform as query string
    get '/reforms/:reform_id', to: redirect('/%{locale}/reforms?reform=%{reform_id}')
    get '/reforms/:reform_id/:quarter_id' => 'root#reform_show', as: :reform_show
    get '/experts' => 'root#experts'
    get '/experts/:id' => 'root#expert_show', as: :expert_show




    root 'root#index'

    # handles /en/fake/path/whatever
    get '*path', to: redirect("/#{I18n.default_locale}")
  end

  # handles /
  get '', to: redirect("/#{I18n.default_locale}")

  # handles /not-a-locale/anything
  get '*path', to: redirect("/#{I18n.default_locale}/%{path}")


end
