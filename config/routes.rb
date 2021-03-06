Rails3BootstrapDeviseCancan::Application.routes.draw do
  
  match "vectors/vectoratdate/:vec/:dat" => "vectors#vectoratdate", :as => :vectoratdate
  resources :vectors

  resources :operations

  match "raw_data_scores/prepmassiveInsertion/:date_id" => "raw_data_scores#prepmassiveInsertion", :as => :prepmassiveInsertion
  resources :raw_data_scores

  resources :raw_data

  match "indicators/emancipate/:father/:son" => "indicators#emancipate", :as => :emancipate
  match "indicators/fill" => "indicators#fill", :as => :fill

  resources :indicators

  match "indicator_scores/indicatoratdate/:ind/:date/:trend" => "indicator_scores#indicatoratdate", :as => :indicatoratdate
  resources :indicator_scores

  match "objective_scores/objectiveatdate/:obj/:date/:trend" => "objective_scores#objectiveatdate", :as => :objectiveatdate
  resources :objective_scores

  match "perspective_scores/strategymap/:date_id" => "perspective_scores#strategymap", :as => :thestrategymap
  match "perspective_scores/strategymap" => "perspective_scores#strategymap", :as => :strategymap
  resources :perspective_scores

  match "score_dates/setindicatorsgoals/:id" => "score_dates#setindicatorsgoals", :as => :setindicatorsgoals
  match "score_dates/filloperands/:id" => "score_dates#filloperands", :as => :filloperands
  match "score_dates/setindicatorsscores/:id" => "score_dates#setindicatorsscores", :as => :setindicatorsscores
  match "score_dates/setperspectivesscores/:id" => "score_dates#setperspectivesscores", :as => :setperspectivesscores
  match "score_dates/setobjectivesscores/:id" => "score_dates#setobjectivesscores", :as => :setobjectivesscores
  resources :score_dates

  match "objectives/demoshow" => "objectives#demoshow", :as => :demoshowobjectives 
  match "objectives/explore" => "objectives#explore", :as => :exploreobjectives
  resources :objectives

  match "perspectives/strategyMap" => "perspectives#strategyMap", :as => :strategyMap
  resources :perspectives

  match "dashboards/show/:cat/:type/:id/:date" => "dashboards#show", :as => :showdashboard
  #match "dashboards/show/:cat/:id/:date" => "dashboards#show", :as => :showdashboard
  authenticated :user do
    root :to => 'perspective_scores#strategymap'
  end
  unauthenticated :user do
    devise_scope :user do 
      get "/" => "devise/sessions#new"
    end
  end
  devise_for :users
  resources :users, :only => [:show, :index]
end
