desc "Create a new post"
task :new, :title do |t, args|
  mkdir_p './content/posts'
  args.with_defaults(:title => 'new-post')
  title = args.title
  filename = "./content/posts/#{Time.now.strftime('%Y-%m-%d')}-#{title}.md"

  if File.exist?(filename)
    abort('rake aborted!') if ask("#{filename} already exists. Want to overwrite?", ['y','n']) == 'n'
  end

  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts '---'
    post.puts "title: \"#{title}\""
    post.puts "created_at: #{Time.now}"
    # post.puts 'kind: article'
    # post.puts 'published: false'
    post.puts "---\n\n"
  end
end
