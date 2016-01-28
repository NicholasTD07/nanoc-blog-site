desc 'Bootstrap nanoc blogging environment'
task :bootstrap do
  puts 'Installing Pygments with pip'
  system 'pip install Pygments'
  puts 'Installing pygments.rb with bundle'
  system 'bundle install'
end
task :b => :bootstrap

desc 'Create a new post'
task :new, :title do |t, args|
  mkdir_p './content/posts'
  args.with_defaults(:title => 'new-post')
  title = args.title

  filename = (title.gsub(%r{\W}, '-')).downcase.chomp '-'
  path = "./content/posts/#{Time.now.strftime('%Y-%m-%d')}-#{filename}.md"

  if File.exist?(path)
    abort('rake aborted!') if ask("#{path} already exists. Want to overwrite?", ['y','n']) == 'n'
  end

  puts "Creating new post: #{path}"
  open(path, 'w') do |post|
    post.puts '---'
    post.puts "title: \"#{title}\""
    post.puts "created_at: #{Time.now}"
    post.puts 'kind: article'
    post.puts "---\n\n"
  end
end
task :n => :new
