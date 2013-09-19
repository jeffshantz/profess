module ConfigurationHelper

  def setup_sample_project

        Dir.mkdir('/proj')
        Dir.mkdir('/proj/config')
        Dir.mkdir('/proj/slides')
        Dir.mkdir('/proj/slides/deck1')
        
        File.open('/proj/config/project.toml', 'w') do |f|
          f.puts <<-EOF
[project]
  name = "proj"

[deck]

  [deck.author]
    name        = "Joe User"
    email       = "user@example.com"
    department  = "Department of Computer Science"
    institution = "The University of Western Ontario"
EOF
        end
        
        File.open('/proj/slides/slides.toml', 'w') do |f|
          f.puts <<-EOF
[deck]
  
  [deck.author]
    email = "bcaygeon@example.com"
EOF
        end
        
        File.open('/proj/slides/deck1/deck.toml', 'w') do |f|
          f.puts <<-EOF
[deck]

  title = "deck1"
  
  [deck.author]
    name        = "Bob Caygeon"
    institution = "Western University"
EOF
        end

  end

end
