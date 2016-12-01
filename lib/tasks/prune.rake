namespace :URLShortener do
  task purge_old_url: :environment do
    puts 'Remove urls not visited in the last 15 minutes'
    ShortenedUrl.prune
  end
end
