namespace :db do
    desc 'Clean up villages with empty names'
    task cleanup: :environment do
      Village.where(subdivision: [nil, '']).destroy_all
    end
  end
  