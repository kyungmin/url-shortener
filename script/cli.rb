def login
  puts "Input your email:"
  email = gets.chomp
  if user = User.find_by_email(email)
    puts "Logged in as #{user.name}"
  else
    user = User.create!({name: email, email: email})
  end
  user
end

def create_url(user)
  puts "Type in your long URL"
  long_url = gets.chomp
  shortened_url = ShortenedUrl.create_for_user_and_long_url!(user, long_url)
  puts "Short URL is: #{shortened_url.short_url}"
  # display available topics. ask for which topic to tag.
end

def visit_url(user)
  puts "Type in the shortened URL"
  short_url = gets.chomp
  shortened_url = ShortenedUrl.find_by_short_url(short_url)
  Visit.record_visit!(user, shortened_url)
  # puts "#{shortened_url.long_url}"
  uri = shortened_url.long_url
  Launchy.open(uri) do |exception|
    puts "Attempted to open #{uri} and failed because #{exception}"
  end
end

def get_input
  puts "What do you want to do?"
  puts "0. Create shortened URL"
  puts "1. Visit shortened URL"
  gets.chomp
end

loop do
  user = login
  mode = get_input
  case mode
  when "0"
    create_url(user)
  when "1"
    visit_url(user)
  else
    break
  end
end